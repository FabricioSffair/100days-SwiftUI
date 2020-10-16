//
//  AddView.swift
//  iExpense
//
//  Created by Fabricio Sperotto Sffair on 2020-08-04.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var type = ExpenseType.home
    @State private var amount = ""
    @State var expenseItem: ExpenseItem? = nil
    @State private var isPresentingAlert = false
    
    @ObservedObject var expenses: Expenses
    
    var body: some View {
        UITableView.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.3)
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .none
        return ZStack {
            LinearGradient(gradient: Gradient(colors: [Colors.lightBlue, Colors.cream]), startPoint: .bottomTrailing, endPoint: .topLeading)
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                Form {
                    TextField("Name", text: $name)
                    Picker("Type", selection: $type) {
                        ForEach(ExpenseType.allCases, id: \.self) {
                            Text($0.displayString)
                        }
                    }
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                }
                .background(Color.clear)
                .navigationBarTitle("Add new expense")
                .navigationBarItems(trailing: Button("Save") {
                    if let amount = Int(self.amount), !self.name.isEmpty {
                        let item = ExpenseItem(name: self.name, type: self.type, amount: amount)
                        if  let expenseItem = self.expenseItem,
                            let index = self.expenses.items.firstIndex(of: expenseItem) {
                            self.expenses.items[index] = item
                        } else {
                            self.expenses.items.append(item)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.isPresentingAlert = true
                    }
                })
            }
            .onAppear {
                if let expenseItem = self.expenseItem {
                    self.name = expenseItem.name
                    self.amount = "\(expenseItem.amount)"
                    self.type = expenseItem.type
                }
            }
            .alert(isPresented: $isPresentingAlert) {
                Alert(title: Text("\"\(amount)\" is not a valid amount."), message: Text("Please insert a valid amount spent"), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
