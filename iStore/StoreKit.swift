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

var g_proId:String? = nil

extension UIApplication:SKProductsRequestDelegate{
    // MARK: 初始化
    func setup_applepay(){
        SKPaymentQueue.default().add(self)
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
   
    //  MARK: 开始支付
    func beginPay(proId:String ){
        if SKPaymentQueue.canMakePayments() == false {
            return
        }
        let set = Set<String>.init([proId])
        let request = SKProductsRequest.init(productIdentifiers: set)
        g_proId = proId
        request.delegate = self
        request.start()
        
    }
    
    // MARK: 客户端验证支付凭证
    func clientValidationOrder(_ transaction: SKPaymentTransaction){
        guard let transactionString = receiptTransactionsString else{
            debugPrint("获取支付凭证失败")
            return
        }

        let parmas = ["receipt-data":transactionString]
        do {
            let bodydata = try JSONSerialization.data(withJSONObject: parmas)
            var request = URLRequest(url: appStoreUrl)
            request.httpMethod = "post"
            request.httpBody = bodydata
            URLSession.shared.dataTask(with: request) { data, response, error in
                debugPrint(response ?? "")
                DispatchQueue.main.async {
                    guard error == nil, let data = data else{ return }
                    
                    do{
                        guard let jsondata = try JSONSerialization.jsonObject(with: data) as? [String:Any] else{
                            return
                        }
                        let status =  jsondata["status"].i_int(-1)
//                        let productid = transaction.payment.productIdentifier
                        if status == 0{
                            
                            SKPaymentQueue.default().finishTransaction(transaction)
//                            UIApplication.shared.delegate?.window??.rootViewController?.alert(title: "成功", msg: "购买成功")
                        }else{
//                            UIApplication.shared.delegate?.window??.rootViewController?.alert(title: "失败", msg: "验证支付凭证失败\(status)")
                            debugPrint()
                        }
                    }catch  {
                   
//                        UIApplication.shared.delegate?.window??.rootViewController?.alert(title: "失败", msg: "验证支付凭证失败\(error)")
                        return
                    }
                }
                
            }.resume()
        } catch  {
//            UIApplication.shared.delegate?.window??.rootViewController?.alert(title: "失败", msg: "验证支付凭证失败\(error)")
            return
        }
    }
    
   
    // MARK: SKProductsRequestDelegate
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        debugPrint(response)
        let productArray = response.products
          if productArray.count == 0 {
//              UIApplication.shared.delegate?.window??.rootViewController?.alert(title: "失败", msg: "未找到对应的商品信息")
              return
          }
          var product:SKProduct!
          for pro in productArray {
              if pro.productIdentifier == g_proId {
                  product = pro
                  break
              }
          }
         
          let payment = SKMutablePayment.init(product: product)
          payment.quantity = 1
          SKPaymentQueue.default().add(payment)
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        DispatchQueue.main.async {
//            UIApplication.shared.delegate?.window??.rootViewController?.alert(title: "失败", msg: error.localizedDescription)
        }
       
    }
    
}

extension UIApplication:SKPaymentTransactionObserver{

    
    // 这里接收所有支付事务的状态：成功、失败或者正在支付
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            handleTransaction(transaction)
        }
    }
    
    func handleTransaction(_ transaction: SKPaymentTransaction) {
        switch transaction.transactionState {
            // 购买成功，缓存这个事务
        case .purchased:
            //                unfinishedTransactions.append(transaction)
            debugPrint("购买成功，缓存这个事务")
          
            clientValidationOrder(transaction)
            break
            
            // 成功恢复购买，缓存这个事务
        case .restored:
            //                unfinishedTransactions.append(transaction.original!)
//            UIApplication.shared.delegate?.window??.rootViewController?.alert(title: "成功", msg: "已购买过了")
            break
            
        case .failed:
            SKPaymentQueue.default().finishTransaction(transaction)
//            UIApplication.shared.delegate?.window??.rootViewController?.alert(title: "失败", msg: "购买失败")
            break
        
        case .purchasing:
//            UIApplication.shared.delegate?.window??.rootViewController?.alert(title: "请稍后", msg: "...")
            fallthrough
        case .deferred:
            
//            UIApplication.shared.delegate?.window??.rootViewController?.alert(title: "失败", msg: "支付\(transaction.transactionState):事务在队列中，但它的最终状态是等待外部操作。")
            fallthrough
        @unknown default:
//            UIApplication.shared.delegate?.window??.rootViewController?.alert(title: "失败", msg: "支付\(transaction.transactionState)")
            break
        }
    }
    
    
}


