//
//  ImagesGeometryReader.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-29.
//

import SwiftUI

struct ImagesGeometryReader: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                ForEach(0..<100) { _ in
                    Text("Test")
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ImagesGeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        ImagesGeometryReader()
    }
}
