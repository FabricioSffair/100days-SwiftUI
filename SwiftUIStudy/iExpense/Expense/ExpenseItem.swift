//
//  Expense.swift
//  iExpense
//
//  Created by Fabricio Sperotto Sffair on 2020-08-04.
//  Copyright © 2020 Fabricio Sperotto Sffair. All rights reserved.
//

import Foundation

extension StringProtocol {
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

enum ExpenseType: Int, CaseIterable {
    case home = 0, shopping, groceries, phone, memberships, food, liquor

    var displayString: String {
        "\(self)".firstCapitalized
    }
}

struct ExpenseItem: Identifiable {
    let id = UUID()
    var name: String
    var type: ExpenseType
    var amount: Int
}

extension ExpenseItem: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
