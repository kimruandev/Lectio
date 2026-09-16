//
//  UVNetworkServices.swift
//  LCNetwork
//
//  Created by Kim Lopes on 10/09/26.
//

enum APIVersion: String {
    case rwMiddlewareV1 = "rw-middleware/v1"
    case rwMiddlewareV2 = "rw-middleware/v2"
    case rwMiddlewareV3 = "rw-middleware/v3"
    case rwMiddlewareV4 = "rw-middleware/v4"
    case rwMiddlewareV5 = "rw-middleware/v5"
    case extApplicationV1 = "ext-application/v1"
    case extApplicationV2 = "ext-application/v2"
    case extApplicationV3 = "ext-application/v3"
    case claroFlexExtensionsV1 = "claro-flex-extensions/v1"
    case claroFlexExtensionsV2 = "claro-flex-extensions/v2"
    case crmPublicV1 = "crm-public/v1"
    case esim = "esim"
    case downgradeV1 = "downgrade/v1"
    case bffScreen = "ext-screen/v1"
}

public enum UVNetworkServices: String, NetworkServices {
    case walkthrough
    
    public var path: String {
        switch self {
        case .walkthrough:
            return apiVersion + "/walkthrough"
        }
    }
    
    var apiVersion: String {
        switch self {
        case .walkthrough:
            return APIVersion.extApplicationV2.rawValue
        }
    }
}
