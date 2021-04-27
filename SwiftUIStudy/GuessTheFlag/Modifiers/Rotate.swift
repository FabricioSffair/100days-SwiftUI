//
//  Rotate.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-27.
//

import SwiftUI

struct Rotate: ViewModifier {
    let amount: Double
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(amount), axis: (x: 0, y: 1, z: 0))
            .modifier(BorderColor(color: .green, width: 2))
    }
}
