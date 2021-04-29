//
//  Missionview.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-29.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct CrewMemberView: View {
    
    let crewMember: CrewMember
    
    var body: some View {
        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
            HStack {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .frame(width: 83, height: 60)
                    .clipShape(Capsule())
                VStack(alignment: .leading) {
                    Text(crewMember.astronaut.name)
                        .font(.headline)
                    Text(crewMember.role)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
        }
    }
}

struct MissionDetailsView: View {

    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)
                        .padding(.top)
                    Text(mission.formattedLaunchDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                    Text(mission.description)
                        .padding()
                    Spacer(minLength: 25)
                    ForEach(astronauts, id: \.role) { crewMember in
                        CrewMemberView(crewMember: crewMember)
                    }
                }
            }
        }
        .navigationBarTitle(mission.displayName, displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut] = Astronaut.astronauts) {
        self.mission = mission

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
}

struct Missionview_Previews: PreviewProvider {
    
    static var previews: some View {
        MissionDetailsView(mission: Mission.missions[0], astronauts: Astronaut.astronauts)
    }
}
