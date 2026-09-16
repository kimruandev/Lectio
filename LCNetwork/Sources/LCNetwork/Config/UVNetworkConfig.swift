//
//  UVNetworkConfig.swift
//  LCNetwork
//
//  Created by Kim Lopes on 10/09/26.
//

import Foundation

public final class UVNetworkConfig: NSObject {
    var userId: String = ""
    var accessToken: String = ""
    var msisdn: String = ""
    var customerId: String = ""
    var productId: String = ""
    var recaptcha: String = ""
    
    var handler: ((_ accessToken: String, _ uid: String) -> Void)?
    
    public func setupAuthTokensResponse(handler: @escaping (_ accessToken: String, _ uid: String) -> Void) {
        self.handler = handler
    }
    
    @MainActor public static let shared = UVNetworkConfig()
    
    public func setProductId(_ productId: String?) {
        self.productId = productId ?? ""
    }
    
    public func setCustomerId(_ customerId: String?) {
        self.customerId = customerId ?? ""
    }
    
    public func setMsisdn(_ msisdn: String?) {
        guard let msisdn = msisdn?.onlyDigits else {
            self.msisdn = ""
            return
        }
        
        if msisdn.count == 11 {
            self.msisdn = "55\(msisdn)"
        }
        
        self.msisdn = msisdn
    }
    
    public func setUserId(_ userId: String?) {
        self.userId = userId ?? ""
    }
    
    public func setAccessToken(_ accessToken: String?) {
        self.accessToken = accessToken ?? ""
    }
    
    public func getUserIdAndAccessToken() -> (userId: String, accessToken: String) {
        (userId, accessToken)
    }
}
