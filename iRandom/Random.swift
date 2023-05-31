//
//  URL.swift
//  Alamofire
//
//  Created by mac on 2023/4/7.
//

import Foundation
class iRandom{
    public static let wordList = [
      "alias", "consequatur", "aut", "perferendis", "sit", "voluptatem",
      "accusantium", "doloremque", "aperiam", "eaque", "ipsa", "quae", "ab",
      "illo", "inventore", "veritatis", "et", "quasi", "architecto",
      "beatae", "vitae", "dicta", "sunt", "explicabo", "aspernatur", "aut",
      "odit", "aut", "fugit", "sed", "quia", "consequuntur", "magni",
      "dolores", "eos", "qui", "ratione", "voluptatem", "sequi", "nesciunt",
      "neque", "dolorem", "ipsum", "quia", "dolor", "sit", "amet",
      "consectetur", "adipisci", "velit", "sed", "quia", "non", "numquam",
      "eius", "modi", "tempora", "incidunt", "ut", "labore", "et", "dolore",
      "magnam", "aliquam", "quaerat", "voluptatem", "ut", "enim", "ad",
      "minima", "veniam", "quis", "nostrum", "exercitationem", "ullam",
      "corporis", "nemo", "enim", "ipsam", "voluptatem", "quia", "voluptas",
      "sit", "suscipit", "laboriosam", "nisi", "ut", "aliquid", "ex", "ea",
      "commodi", "consequatur", "quis", "autem", "vel", "eum", "iure",
      "reprehenderit", "qui", "in", "ea", "voluptate", "velit", "esse",
      "quam", "nihil", "molestiae", "et", "iusto", "odio", "dignissimos",
      "ducimus", "qui", "blanditiis", "praesentium", "laudantium", "totam",
      "rem", "voluptatum", "deleniti", "atque", "corrupti", "quos",
      "dolores", "et", "quas", "molestias", "excepturi", "sint",
      "occaecati", "cupiditate", "non", "provident", "sed", "ut",
      "perspiciatis", "unde", "omnis", "iste", "natus", "error",
      "similique", "sunt", "in", "culpa", "qui", "officia", "deserunt",
      "mollitia", "animi", "id", "est", "laborum", "et", "dolorum", "fuga",
      "et", "harum", "quidem", "rerum", "facilis", "est", "et", "expedita",
      "distinctio", "nam", "libero", "tempore", "cum", "soluta", "nobis",
      "est", "eligendi", "optio", "cumque", "nihil", "impedit", "quo",
      "porro", "quisquam", "est", "qui", "minus", "id", "quod", "maxime",
      "placeat", "facere", "possimus", "omnis", "voluptas", "assumenda",
      "est", "omnis", "dolor", "repellendus", "temporibus", "autem",
      "quibusdam", "et", "aut", "consequatur", "vel", "illum", "qui",
      "dolorem", "eum", "fugiat", "quo", "voluptas", "nulla", "pariatur",
      "at", "vero", "eos", "et", "accusamus", "officiis", "debitis", "aut",
      "rerum", "necessitatibus", "saepe", "eveniet", "ut", "et",
      "voluptates", "repudiandae", "sint", "et", "molestiae", "non",
      "recusandae", "itaque", "earum", "rerum", "hic", "tenetur", "a",
      "sapiente", "delectus", "ut", "aut", "reiciendis", "voluptatibus",
      "maiores", "doloribus", "asperiores", "repellat",
    ]
    public static let zh_wordList = [
      "alias", "consequatur", "aut", "perferendis", "sit", "voluptatem",
      "accusantium", "doloremque", "aperiam", "eaque", "ipsa", "quae", "ab",
      "illo", "inventore", "veritatis", "et", "quasi", "architecto",
      "beatae", "vitae", "dicta", "sunt", "explicabo", "aspernatur", "aut",
      "odit", "aut", "fugit", "sed", "quia", "consequuntur", "magni",
      "dolores", "eos", "qui", "ratione", "voluptatem", "sequi", "nesciunt",
      "neque", "dolorem", "ipsum", "quia", "dolor", "sit", "amet",
      "consectetur", "adipisci", "velit", "sed", "quia", "non", "numquam",
      "eius", "modi", "tempora", "incidunt", "ut", "labore", "et", "dolore",
      "magnam", "aliquam", "quaerat", "voluptatem", "ut", "enim", "ad",
      "minima", "veniam", "quis", "nostrum", "exercitationem", "ullam",
      "corporis", "nemo", "enim", "ipsam", "voluptatem", "quia", "voluptas",
      "sit", "suscipit", "laboriosam", "nisi", "ut", "aliquid", "ex", "ea",
      "commodi", "consequatur", "quis", "autem", "vel", "eum", "iure",
      "reprehenderit", "qui", "in", "ea", "voluptate", "velit", "esse",
      "quam", "nihil", "molestiae", "et", "iusto", "odio", "dignissimos",
      "ducimus", "qui", "blanditiis", "praesentium", "laudantium", "totam",
      "rem", "voluptatum", "deleniti", "atque", "corrupti", "quos",
      "dolores", "et", "quas", "molestias", "excepturi", "sint",
      "occaecati", "cupiditate", "non", "provident", "sed", "ut",
      "perspiciatis", "unde", "omnis", "iste", "natus", "error",
      "similique", "sunt", "in", "culpa", "qui", "officia", "deserunt",
      "mollitia", "animi", "id", "est", "laborum", "et", "dolorum", "fuga",
      "et", "harum", "quidem", "rerum", "facilis", "est", "et", "expedita",
      "distinctio", "nam", "libero", "tempore", "cum", "soluta", "nobis",
      "est", "eligendi", "optio", "cumque", "nihil", "impedit", "quo",
      "porro", "quisquam", "est", "qui", "minus", "id", "quod", "maxime",
      "placeat", "facere", "possimus", "omnis", "voluptas", "assumenda",
      "est", "omnis", "dolor", "repellendus", "temporibus", "autem",
      "quibusdam", "et", "aut", "consequatur", "vel", "illum", "qui",
      "dolorem", "eum", "fugiat", "quo", "voluptas", "nulla", "pariatur",
      "at", "vero", "eos", "et", "accusamus", "officiis", "debitis", "aut",
      "rerum", "necessitatibus", "saepe", "eveniet", "ut", "et",
      "voluptates", "repudiandae", "sint", "et", "molestiae", "non",
      "recusandae", "itaque", "earum", "rerum", "hic", "tenetur", "a",
      "sapiente", "delectus", "ut", "aut", "reiciendis", "voluptatibus",
      "maiores", "doloribus", "asperiores", "repellat",
    ]
}
extension URL{
    public static var i_randomImageURL:URL{
        let url = URL.init(string: "https://picsum.photos/600/\(UInt32.random(in: 600...1200))?id=\(UInt32.random(in: UInt32.min...UInt32.max))")!
        return url
    }
    public static func i_randomImgUrl(size:CGSize,id:String)->URL{
        let url = URL.init(string: "https://picsum.photos/\(UInt32(size.width))/\(UInt32(size.height))?id=\(id)")!
        return url
    }
   
}

extension String{
    public static var i_random_zh:String{
        iRandom.zh_wordList.i_random()!
    }
    public static var i_random_en:String{
        iRandom.wordList.i_random()!
    }
    
    public static func  i_random_zh(count: Int) -> String {
        var strings = [String]()
        
        for _ in 0..<count {
            let high = UInt32(0x9fa5 - 0x4e00 + 1)
            let low = UInt32(0x4e00)
            let code = Int(arc4random_uniform(high) + low)
            let char = UnicodeScalar(code)!
            let chinese = String(char)
            
            strings.append(chinese)
        }
        
        return strings.joined(separator: "")
    }
}

extension Array{
    public func i_random() -> Element? {
      (count > 0) ? shuffled()[0] : nil
    }
}
