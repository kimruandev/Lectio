//
//  NetworkMonitor.swift
//  LCNetwork
//
//  Created by Kim Lopes on 09/09/26.
//

import CoreTelephony
import SystemConfiguration.CaptiveNetwork

public class NetworkMonitor {
    @MainActor public static let shared = NetworkMonitor()
    
    public enum NetworkType: String {
        case wifi = "WIFI"
        case g2 = "2G"
        case g3 = "3G"
        case g4 = "4G"
        case g5 = "5G"
        case unknown = "N/A"
    }
    
    public func getNetworkType() -> NetworkType {
        var flags = SCNetworkReachabilityFlags()
        
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") else {
            return NetworkType.unknown
        }
        
        SCNetworkReachabilityGetFlags(reachability, &flags)
        
        if !isNetworkReachable(with: flags) {
            return NetworkType.unknown
        }
        
        if isUsingWiFi(with: flags) {
            return NetworkType.wifi
        }
        
        if let radioAccessTechnology = getCellularRadioAccessTechnology(),
            let networkType = getNetworkTypeFromRadioAccessTechnology(radioAccessTechnology) {
            return networkType
        }
        
        return NetworkType.unknown
    }
    
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }
    
    private func isUsingWiFi(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachableViaWiFi = flags.contains(.isWWAN)
        return !isReachableViaWiFi
    }
    
    private func getCellularRadioAccessTechnology() -> String? {
        let networkInfo = CTTelephonyNetworkInfo()
        return networkInfo.serviceCurrentRadioAccessTechnology?.values.first
    }
    
    private func getNetworkTypeFromRadioAccessTechnology(_ radioAccessTechnology: String) -> NetworkType? {
        switch radioAccessTechnology {
        case CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyEdge:
            return .g2
        case CTRadioAccessTechnologyWCDMA,
            CTRadioAccessTechnologyHSDPA,
            CTRadioAccessTechnologyHSUPA,
            CTRadioAccessTechnologyCDMA1x,
            CTRadioAccessTechnologyCDMAEVDORev0,
            CTRadioAccessTechnologyCDMAEVDORevA,
            CTRadioAccessTechnologyCDMAEVDORevB,
        CTRadioAccessTechnologyeHRPD:
            return .g3
        case CTRadioAccessTechnologyLTE:
            return .g4
        default:
            if #available(iOS 14.1, *), radioAccessTechnology == CTRadioAccessTechnologyNR {
                return .g5
            }
            
            return nil
        }
    }

    public static func getIPAddress() -> String? {
        var address: String?

        // Get list of all interfaces on the device
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0, let firstAddr = ifaddr else {
            return nil
        }

        // Iterate through interfaces
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ptr.pointee

            // Check for IPv4 or IPv6 interface
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // Check interface name
                let name = String(cString: interface.ifa_name)
                if name == "en0" { // Wi-Fi. Use "pdp_ip0" for cellular.

                    // Convert interface address to a human readable string
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if getnameinfo(
                        interface.ifa_addr,
                        socklen_t(interface.ifa_addr.pointee.sa_len),
                        &hostname,
                        socklen_t(hostname.count),
                        nil,
                        socklen_t(0),
                        NI_NUMERICHOST
                    ) == 0 {
                        address = String(cString: hostname)
                    }
                }
            }
        }

        freeifaddrs(ifaddr)
        return address
    }
}
