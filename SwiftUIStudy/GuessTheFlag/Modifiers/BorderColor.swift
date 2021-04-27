//
//  BorderColor.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-27.
//

import SwiftUI

struct BorderColor: ViewModifier {
    let color: Color
    let width: CGFloat
    func body(content: Content) -> some View {
        content.overlay(Capsule().stroke(color, lineWidth: width))
            .shadow(color: .green, radius: 5)
    }
}
