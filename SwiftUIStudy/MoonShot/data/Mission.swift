//
//  Mission.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-29.
//

import Foundation

struct Mission: Decodable, Identifiable {
    struct Crew: Decodable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [Crew]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }

    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
}
