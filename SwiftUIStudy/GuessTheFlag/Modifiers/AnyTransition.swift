//
//  AnyTransition.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-27.
//

import SwiftUI

extension AnyTransition {
    static var opacity25: AnyTransition {
        .modifier(active: Opacity(amount: 1), identity: Opacity(amount: 0.25))
    }
    static var rotate360y: AnyTransition {
        .modifier(active: Rotate(amount: 0), identity: Rotate(amount: 360))
    }
    static var greenBorder: AnyTransition {
        .modifier(active: BorderColor(color: .black, width: 0), identity: BorderColor(color: .green, width: 2))
    }
}
