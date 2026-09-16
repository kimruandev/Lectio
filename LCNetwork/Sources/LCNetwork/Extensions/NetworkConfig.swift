//
//  NetworkConfig.swift
//  LCNetwork
//
//  Created by Kim Lopes on 10/09/26.
//

import UIKit

extension NetworkConfig {
    @MainActor internal func setAppAttributes() {
        currentBundleId = readLineFromPlist(columnName: "BundleIdentifier")
        version = readLineFromPlist(columnName: "BundleShortVersionString")
        build = readLineFromPlist(columnName: "BundleVersion")
        versionBuild = "\(version) (\(build))"
        osVersion = UIDevice.current.systemVersion
    }
    
    private func readPlist() -> [String: Any]? {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let data = FileManager.default.contents(atPath: path) else {
            return nil
        }
        
        let propertyList = try? PropertyListSerialization.propertyList(from: data,
                                                                       options: .mutableContainersAndLeaves,
                                                                       format: nil) as? [String: Any]
        return propertyList
    }
    
    private func readLineFromPlist(columnName: String) -> String {
        readPlist()?[columnName] as? String ?? ""
    }
}
