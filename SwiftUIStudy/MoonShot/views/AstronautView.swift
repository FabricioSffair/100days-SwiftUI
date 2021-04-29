//
//  AstronautView.swift
//  SwiftUIStudy
//
//  Created by Fabrício Sperotto Sffair on 2021-04-29.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    Spacer(minLength: 25)
                    ForEach(missions, id: \.id) { mission in
                        MissionView(mission: mission)
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(astronaut.name, displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission] = Mission.missions) {
        self.astronaut = astronaut
        self.missions = missions.filter {
            $0.crew.contains { crew -> Bool in
                crew.name == astronaut.id
            }
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static var previews: some View {
        AstronautView(astronaut: Astronaut.astronauts[0], missions: Mission.missions)
    }
}
