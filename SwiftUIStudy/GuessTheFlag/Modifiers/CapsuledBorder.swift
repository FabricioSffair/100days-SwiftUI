//
//  CapsuledBorder.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-27.
//

import SwiftUI

struct CapsuledBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 0.5))
            .shadow(color: .black, radius: 5)
    }
}

extension View {
    func capsuledWithBorder() -> some View {
        self.modifier(CapsuledBorder())
    }
}
