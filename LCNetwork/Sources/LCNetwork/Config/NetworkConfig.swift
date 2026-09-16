//
//  NetworkConfig.swift
//  LCNetwork
//
//  Created by Kim Lopes on 09/09/26.
//

public enum AppEnviroment: String {
    case production = "Production"
    case development
    case local
}

@MainActor
public final class NetworkConfig {
    public static var shared = NetworkConfig()
    public private(set) var currentEnviroment: AppEnviroment = .development
    
    public var currentBundleId = ""
    public var version = ""
    public var build = ""
    public var versionBuild = ""
    public var osVersion = ""
    
    static var currentEnviroment: AppEnviroment {
        return shared.currentEnviroment
    }
    
    public static func config(environment: AppEnviroment) {
        shared.currentEnviroment = environment
        shared.setAppAttributes()
    }
}
