//
//  EndPointType.swift
//  LCNetwork
//
//  Created by Kim Lopes on 10/09/26.
//

import Alamofire
import UIKit

public protocol RequestParameters: Encodable {}

public typealias Parameters = [String: Any]

public protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
    var name: String { get }
    var parameters: Parameters? { get }
    var service: NetworkServices { get }
    
    var currentOrigin: String { get }
    var environmentBaseURL: String { get }
    var baseURL: URL { get }
    var sharedHeader: [String: String] { get }
    var fullPath: String { get }
    var allowCleanCookies: Bool { get }
}
