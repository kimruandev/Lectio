//
//  UVWalkthroughEndPoint.swift
//  LCNetwork
//
//  Created by Kim Lopes on 10/09/26.
//

import Alamofire

public enum UVWalkthroughEndPoint {
    case getScreen(request: UVWalkthroughRequest)
}

extension UVWalkthroughEndPoint: @preconcurrency UVEndPointType {
    public var service: NetworkServices {
        switch self {
        case .getScreen:
            return UVNetworkServices.walkthrough
        }
    }
    
    public var path: String {
        switch self {
        case .getScreen:
            return ""
        }
    }

    public var httpMethod: HTTPMethod {
        switch self {
        case .getScreen:
            return .get
        }
    }

    public var parameters: Parameters? {
        switch self {
        case .getScreen:
            return nil
        }
    }

    public var headers: HTTPHeaders? {
        switch self {
        case .getScreen:
            return nil
        }
    }

    public var encoding: ParameterEncoding {
        switch self {
        case .getScreen:
            return JSONEncoding.default
        }
    }

    public var name: String {
        return String(describing: self)
    }
}
