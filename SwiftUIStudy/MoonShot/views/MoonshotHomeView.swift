//
//  MoonshotHomeView.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-29.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    
    var body: some View {
        NavigationLink(destination: MissionDetailsView(mission: mission)) {
            HStack(alignment: .center) {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                VStack(alignment: .leading) {
                    Text(mission.displayName)
                        .font(.headline)
                    Text(mission.formattedLaunchDate)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct MoonshotHomeView: View {
    
    let astronauts: [Astronaut] = Astronaut.astronauts
    let missions: [Mission] = Mission.missions
    
    var body: some View {
        List(missions) { mission in
            MissionView(mission: mission)
        }
        .navigationTitle("Moonshot")
    }
}

struct MoonshotHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MoonshotHomeView()
    }
}
