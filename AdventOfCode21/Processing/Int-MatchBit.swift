//
//  Int-MatchBit.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/4/21.
//

import Foundation

extension Int {
    func matchesBitAtMask(mask: Int, bitValue: Int) -> Bool {
        let masked = self & mask
        if bitValue == 0 {
            return masked == 0
        } else {
            return masked != 0
        }
    }
}
