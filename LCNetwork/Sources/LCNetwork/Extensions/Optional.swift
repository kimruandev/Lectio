//
//  Optional.swift
//  LCNetwork
//
//  Created by Kim Lopes on 10/09/26.
//

public extension Optional where Wrapped == String {
    var isBlank: Bool {
        if let unwrapped = self {
            return unwrapped.isBlank
        } else {
            return true
        }
    }
    
    var orEmpty: String {
        if let unwrapped = self {
            return unwrapped
        } else {
            return ""
        }
    }
}
