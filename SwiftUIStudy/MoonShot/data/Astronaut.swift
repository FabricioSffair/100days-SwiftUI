//
//  Astronaut.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-29.
//

import Foundation

struct Astronaut: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String
 
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
}
