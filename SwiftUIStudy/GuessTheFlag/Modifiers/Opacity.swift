//
//  Opacity.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-27.
//

import SwiftUI

struct Opacity: ViewModifier {
    let amount: Double
    func body(content: Content) -> some View {
        content.opacity(amount)
    }
}
