//
//  ContentView.swift
//  iExpense
//
//  Created by Fabricio Sperotto Sffair on 2020-08-04.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import SwiftUI

struct Colors {
    static let lightBlue = Color(red: 43/255, green: 192/255, blue: 228/255)
    static let cream = Color(red: 234/255, green: 236/255, blue: 198/255)
}

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
        .listRowBackground(Color.clear)
    }
}

struct ContentView: View {
    @ObservedObject private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var expenseItem: ExpenseItem? = nil
    
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.3)
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .none
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Colors.lightBlue, Colors.cream]), startPoint: .bottomTrailing, endPoint: .topLeading)
            .edgesIgnoringSafeArea(.all)
                List {
                    ForEach(expenses.items, id: \.id) { item in
                        ExpenseRow(item: item)
                            .onTapGesture {
                                self.expenseItem = item
                                self.showingAddExpense = true
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                .background(Color.clear)
                .navigationBarTitle("iExpense")
                .navigationBarItems(leading: EditButton(), trailing:
                    HStack {
                        Button(action: {
                            self.expenseItem = nil
                            self.showingAddExpense = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                )
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenseItem: self.expenseItem, expenses: self.expenses)
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
