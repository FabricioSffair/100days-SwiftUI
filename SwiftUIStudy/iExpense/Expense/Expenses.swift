//
//  Expenses.swift
//  iExpense
//
//  Created by Fabricio Sperotto Sffair on 2020-08-04.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
