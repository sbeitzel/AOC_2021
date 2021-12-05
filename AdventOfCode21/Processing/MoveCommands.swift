//
//  MoveCommands.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/4/21.
//

import Foundation

// swiftlint:disable:next large_tuple
func parseMoveCommand(_ command: String, _ aim: Int) -> (Int, Int, Int) {
    let args = command.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
    var deltaX = 0
    var deltaZ = 0
    var newAim = aim
    if let direction = args.first {
        if let amount = Int(args.last ?? "0") {
            switch direction {
            case "down":
                newAim = aim + amount
            case "up":
                newAim = aim - amount
            case "forward":
                deltaX = amount
                deltaZ = aim * amount
            default:
                print("Unexpected command: \(direction)")
            }

        }
    }
    return (deltaX, deltaZ, newAim)
}

// swiftlint:disable:next large_tuple
func processCommands(_ commands: [String]) -> (Int, Int, Int) {
    var xPos = 0
    var zPos = 0
    var aim = 0
    for command in commands {
        let deltas = parseMoveCommand(command, aim)
        xPos += deltas.0
        zPos += deltas.1
        aim = deltas.2
    }
    return (xPos, zPos, aim)
}
