//
//  View.swift
//  Lectio
//
//  Created by Kim Lopes on 08/09/26.
//

import SwiftUI

// Placeholder for modifier
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
