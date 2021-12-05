//
//  Int-NoGroup.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/4/21.
//

import Foundation

extension Int {
    func ungroupedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.groupingSeparator = ""
        return formatter.string(from: NSNumber(value: self))!
    }
}
