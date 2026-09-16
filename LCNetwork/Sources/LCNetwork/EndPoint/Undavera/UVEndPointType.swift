//
//  UVEndPointType.swift
//  LCNetwork
//
//  Created by Kim Lopes on 10/09/26.
//

import Alamofire
import UIKit

enum UVEndpointHeaderValue: String {
    case rateLimitExceeded = "x-ratelimit-exceeded"
}

public protocol UVEndPointType: EndPointType {}

@MainActor
public extension UVEndPointType {
    var currentOrigin: String {
        switch NetworkConfig.currentEnviroment {
        case .development:
            return "https://clarogateway.flexdev.aws.clarobrasil.mobi"
        case .production:
            return "https://prd-gw-flex.claro.com.br"
        case .local:
            return "http://127.0.0.1:8080"
        }
    }

    var environmentBaseURL: String {
        currentOrigin + "/" + service.path
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }

    var sharedHeader: [String: String] {
        var headers: [String: String] = [:]
        let environment = NetworkConfig.currentEnviroment

        headers["X-Application-Id"] = environment == .production ? "flex" : "ac76a7739985cdacad94eecd7f04ff64a97e0e93"
        headers["X-Application-Key"] = environment == .production ? "6bc26de028ad013c2606000d3ac06d76" : "b9f3918028ac013c2604000d3ac06d76"
        headers["X-Channel-Id"] = environment == .production ? "8210b617-e9da-40d3-81a9-7bbd5dea7b8f" : "6062f134-b4b1-41db-98ad-c3b289fed970"
        headers["X-Organization-Slug"] = "claro"
        headers["deviceId"] = UIDevice.current.identifierForVendor?.uuidString
        headers["local-session-id"] = UUID().uuidString
        headers["x-app-version"] = NetworkConfig.shared.versionBuild
        headers["x-platform"] = "iOS"
        headers["x-platform-version"] = NetworkConfig.shared.osVersion
        headers["X-Uid"] = UVNetworkConfig.shared.userId
        headers["X-MSISDN"] = UVNetworkConfig.shared.msisdn
        headers["x-customer-id"] = UVNetworkConfig.shared.customerId
        headers["x-product-id"] = UVNetworkConfig.shared.productId
        
        if environment == .development {
            headers.merge(createTraceHeaders()){(_, val) in val }
        }
        
        if let rawTokenData = "\(UVNetworkConfig.shared.userId):\(UVNetworkConfig.shared.accessToken)".data(using: .utf8) {
            let bearerToken = rawTokenData.base64EncodedString(options: [])
            headers["Authorization"] = String(format: "Bearer %@", bearerToken)
        }
        
        return headers
    }

    var fullPath: String {
        var path = baseURL.appendingPathComponent(self.path).absoluteString

        // Add query params to cache path
        if let parameters = parameters,
            !parameters.isEmpty,
            var urlComps = URLComponents(string: path),
            let enconding = encoding as? URLEncoding {
            let percentEncodedQuery = (urlComps.percentEncodedQuery.map { $0 + "&" } ?? "") + query(enconding, parameters)
            urlComps.percentEncodedQuery = percentEncodedQuery
            path = urlComps.url?.absoluteString ?? path
        }

        return path
    }

    private func query(_ enconding: URLEncoding, _ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            guard let value = parameters[key] else { continue }
            components += enconding.queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    var allowCleanCookies: Bool {
        return true
    }
    
    private func createTraceHeaders() -> [String : String]{
        // Geração dos identificadores
        let version = "00"
        let traceId = generateHex(size: 32)
        let parentId = generateHex(size: 16)
        let traceFlags = "01"
        let traceparent = "\(version)-\(traceId)-\(parentId)-\(traceFlags)"
        
        return [
            "traceparent": traceparent,
            "X-Tracking-Id": traceId,
            "x-rw-tracking-id": traceId,
            "x-tracking-source": traceId,
            "X-Tracking-Source-Id": traceId,
            "X-ContextTracking-Id": traceId
        ]
    }
    
    private func generateHex(size: Int) -> String {
        var hexString = ""
        for _ in 0..<size {
            let randomDigit = Int.random(in: 0...15)
            hexString += String(format: "%x", randomDigit)
        }
        return hexString
    }
}
