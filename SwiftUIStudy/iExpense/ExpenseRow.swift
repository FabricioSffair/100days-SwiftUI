//
//  ExpenseRow.swift
//  iExpense
//
//  Created by Fabrício Sperotto Sffair on 2021-04-27.
//  Copyright © 2021 Fabricio Sperotto Sffair. All rights reserved.
//

import Foundation
import SwiftUI

struct ExpenseRow: View {

    @State var item: ExpenseItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type.displayString)
            }
            Spacer()
            Text("$\(item.amount)")
        }
        .listRowBackground(Color(red: 245/255, green: 245/255, blue: 245/255))
    }
}
