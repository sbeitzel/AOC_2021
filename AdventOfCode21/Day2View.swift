//
//  Day2View.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/3/21.
//

import Algorithms
import SwiftUI

struct Day2View: View {
    @State private var xPos: Int = 0
    @State private var zPos: Int = 0
    @State private var aim: Int = 0

    @State private var isCalculated = false

    let fullInput: String

    init() {
        do {
            let contents = try String(contentsOfFile: Bundle.main.path(forResource: "day2Input", ofType: "txt") ?? "")
            self.fullInput = contents
        } catch {
            print("There was an error requesting the input!")
            self.fullInput = ""
        }
    }

    var body: some View {
        VStack {
            Button {
                calculate()
            }
        label: {
            Text("Calculate")
            }
            .disabled(isCalculated)
        Text("Ending at: (\(xPos), \(zPos), with product: \(xPos * zPos)")
        }
        .frame(minWidth: 300, idealWidth: 400, minHeight: 200, idealHeight: 450)
    }

    func calculate() {
        let commands = fullInput.split(separator: "\n")
        for command in commands {
            print("processing command: \(command)")
            let args = command.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
            var direction = args.first!
            direction.trim(while: \.isWhitespace)
            if let amount = Int(args.last!) {
                switch direction {
                case "down":
                    aim += amount
                case "up":
                    aim -= amount
                case "forward":
                    xPos += amount
                    zPos += aim * amount
                default:
                    print("Unexpected command: \(direction)")
                }
            } else {
                print("Unable to interpret quantity: \(args.last!)")
            }
        }
        print("position is (\(xPos), \(zPos))")
        isCalculated = true
    }
}

struct Day2View_Previews: PreviewProvider {
    static var previews: some View {
        Day2View()
    }
}
