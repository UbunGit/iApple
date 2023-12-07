import Foundation
import Alamofire
import SSZipArchive
public enum DownManageError:Error{
    case defual
}
class InsecureURLSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

public extension URL{
    typealias DownProgressHandler = (Progress) -> Void
    // 获取url最后修改时间
    func lastModified()async throws ->String{
        let session = URLSession(configuration: .default,delegate: InsecureURLSessionDelegate(), delegateQueue: nil)
        var request = URLRequest(url: self)
        request.httpMethod = "HEAD"
        let (_, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
           let lastModifiedString = httpResponse.allHeaderFields["Last-Modified"] as? String else{
            throw DownManageError.defual
        }
        return lastModifiedString
      
    }
    // 下载url文件
    func down(closure: DownProgressHandler?)async throws -> (URL,String){
        return try await withUnsafeThrowingContinuation { continuation in

            var request  = AF.download(self)
            if let closure = closure {
                request = request.downloadProgress(closure: closure).validate()
            }
            
            request.responseData { response in
                debugPrint(response)
                guard let lastModifiedString = response.response?.allHeaderFields["Last-Modified"] as? String,
                      let fileUrl = response.fileURL
                else{
                    continuation.resume(throwing: DownManageError.defual)
                    return
                }
                continuation.resume(returning: (fileUrl, lastModifiedString))
            }
        }
    }
}

public extension URL{
    
    static var cloudUrl:URL?{
        if FileManager.default.ubiquityIdentityToken == nil{
            return nil
        }
        return FileManager.default.url(forUbiquityContainerIdentifier: nil)
    }
    static var documentUrls:[URL]{
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    }
    static var documentsUrl: URL?{
        documentUrls.last
    }
    
    
}

public extension URL{
    func unarchiver(to:URL)throws{
        let unzippath = to.path
        try FileManager.default.removeItem(atPath: unzippath)
        try FileManager.default.createDirectory(atPath: unzippath, withIntermediateDirectories: true)
        try SSZipArchive.unzipFile(atPath: self.path, toDestination: to.path, overwrite: true, password: nil)
    }
}
