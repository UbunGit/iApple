//
//  StoreKit.swift
//  UGDLNA
//
//  Created by mac on 2022/10/20.
//

import Foundation
import StoreKit
#if DEBUG
private let appStoreUrl = URL(string:"https://sandbox.itunes.apple.com/verifyReceipt")!// 测试环境(沙盒账号付款)
#else
private let appStoreUrl = URL(string:"https://buy.itunes.apple.com/verifyReceipt")!
#endif

enum StoreError:Error{
    case defual
}


extension Notification.Name{
    public static let storeDidFinishTransaction:Notification.Name = .init("storeDidFinishTransaction")
}
public struct StoreFinishTransaction{
    public var result: [String : Any]
    public var transaction:SKPaymentTransaction
}


extension UIApplication:SKProductsRequestDelegate{
    // MARK: 初始化
    public func setup_applepay(password:String){
        UserDefaults.standard.set(password, forKey: "store.password")
        SKPaymentQueue.default().add(self)
    }
    
    //  MARK: 开始支付
    public func i_storePay(proId:String ){
        if SKPaymentQueue.canMakePayments() == false {
            return
        }
        UIView.loading()
        let set = Set<String>.init([proId])
        let request = SKProductsRequest.init(productIdentifiers: set)
        request.delegate = self
        request.start()
        
    }
    public func i_storeRecover(){
        UIView.loading()
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    //  MARK: 支付凭证
    var receiptTransactionsString: String? {
        get {
            guard let receiptURL = Bundle.main.appStoreReceiptURL else {
                return nil
            }
            guard let receiptData = try? Data(contentsOf: receiptURL) else {
                return nil
            }
            return receiptData.base64EncodedString()
        }
    }
    
    // MARK: 客户端验证支付凭证
    func clientValidationOrder(_ transaction: SKPaymentTransaction)async throws{
        guard let transactionString = receiptTransactionsString else{
            logging.error("获取支付凭证失败")
            throw StoreError.defual
        }
        let password = UserDefaults.standard.object(forKey: "store.password")
        let parmas = ["receipt-data":transactionString,
                      "password":password
        ]
        
        let bodydata = try JSONSerialization.data(withJSONObject: parmas)
        var request = URLRequest(url: appStoreUrl)
        request.httpMethod = "post"
        request.httpBody = bodydata
        let (data, response) = try await URLSession.shared.data(for: request)
        debugPrint(response)
        
        guard let jsondata = try JSONSerialization.jsonObject(with: data) as? [String:Any]else{
            logging.error("支付凭证验证失败")
            throw StoreError.defual
        }
        logging.debug(jsondata)
        if jsondata["status"].i_int(-1) != 0{
            logging.error("支付凭证验证失败")
            throw StoreError.defual
        }
        guard let datas = jsondata["latest_receipt_info"] as? [[String:Any]],
              let data = datas.first else{
            logging.error("支付结果验证失败")
            throw StoreError.defual
        }
        let product_id = data["product_id"].i_string()
        var values:[String:Any] = UserDefaults.standard.object(forKey: "TransactionModels") as? [String : Any] ?? [:]
        values[product_id] = try data.toData()
        UserDefaults.standard.setValue(values, forKey: "TransactionModels")
        SKPaymentQueue.default().finishTransaction(transaction)
        NotificationCenter.default.post(name: .storeDidFinishTransaction, object: nil)
        
    }
    
    // MARK: SKProductsRequestDelegate
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        logging.debug(response.products.map{$0.productIdentifier})
        response.products.forEach { product in
            let payment = SKMutablePayment.init(product: product)
            payment.quantity = 1
            SKPaymentQueue.default().add(payment)
        }
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        UIView.loadingDismiss()
        DispatchQueue.main.async {
            UIApplication.shared.delegate?.window??.rootViewController?.view.tost( msg: error.localizedDescription)
        }
        
    }
    
}

extension UIApplication:SKPaymentTransactionObserver{
    public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        UIView.loadingDismiss()
        if queue.transactions.count==0{
            UIView.tost(msg: "未找到购买记录")
        }else{
            UIView.tost(msg: "恢复成功")
        }
    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        UIView.loadingDismiss()
        UIView.tost(msg: "未找到购买记录？如有疑问请联系开发者")
    }
    
    // 这里接收所有支付事务的状态：成功、失败或者正在支付
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        Task{
            do{
                for transaction in transactions {
                    try await handleTransaction(transaction)
                }
                UIView.loadingDismiss()
            }catch{
                UIView.tost(msg: error.localizedDescription)
            }
        }
        
    }
    
    func handleTransaction(_ transaction: SKPaymentTransaction) async throws{
        switch transaction.transactionState {
            // 购买成功，缓存这个事务
        case .purchased:
            //                unfinishedTransactions.append(transaction)
            debugPrint("购买成功，缓存这个事务")
            try await clientValidationOrder(transaction)
            break
            
            // 成功恢复购买，缓存这个事务
        case .restored:
           
            debugPrint("恢复购买成功")
            try await  clientValidationOrder(transaction)
            break
            
        case .failed:
            SKPaymentQueue.default().finishTransaction(transaction)
            UIView.error("购买失败")
            break
            
        case .purchasing:
            UIView.error("请稍后...")
            
            fallthrough
        case .deferred:
            
            fallthrough
        @unknown default:
            
            break
        }
    }
    
    
}

extension UIApplication{
    public struct AppleOrderModel:Codable{
        
        public var product_id:String
        public var expires_date_ms:Double? // 结束时间戳
        public var quantity:Int
        
        public var expires_date:Date?{
            guard let ms = expires_date_ms else{
                return nil
            }
            return .init(timeIntervalSince1970: ms/1000)
        }
        
    }
    
    public func lastOrder(pro_id:String)throws ->AppleOrderModel?{

        guard let values: [String: Data] = UserDefaults.standard.object(forKey: "TransactionModels") as? [String: Data] else{
           return nil
        }
        guard let data = values[pro_id] else {
            return nil
        }
        guard let value = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
            return nil
        }
        let product_id = value["product_id"].i_string()
        let ms = value["expires_date_ms"].i_double()
        let quantity = value["quantity"].i_int()
        return .init(product_id: product_id, expires_date_ms: ms, quantity: quantity)
    }
    
    public func isvip(pro_id:String)->Bool{
        do {
            if let storeData = try UIApplication.shared.lastOrder(pro_id: pro_id),
               let date = storeData.expires_date{
                if date.timeIntervalSince1970>Date().timeIntervalSince1970{
                    return true
                }
            }
            return false
        } catch  {
            return false
        }
        
    }
}


