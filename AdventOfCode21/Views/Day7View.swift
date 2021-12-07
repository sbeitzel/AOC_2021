//
//  Day7View.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/7/21.
//

import SwiftUI

struct Day7View: View {
    static let tag = "Day7"

    @State private var inputText: String = ""
    @State private var target: Int = -1
    @State private var cost: Int = Int.max
    @State private var computer: CrabSubMover?

    var body: some View {
        VStack {
            TextEditor(text: $inputText)
                .font(.system(.body, design: .monospaced))
            Divider()
            HStack(spacing: 10) {
                Button(action: parse) { Text("Parse") }
                Button(action: compute) { Text("Find Out") }
                Spacer()
            }
            Text("The most frequent position is: \(computer?.mostFrequentPosition ?? -1)")
            // swiftlint:disable:next line_length
            Text("Min/Max/Total positions: \(computer?.minPosition ?? -1) / \(computer?.maxPosition ?? -1) / \(computer?.totalSubs ?? 0)")
            Text("The cheapest target is \(target.ungroupedString()), with cost \(cost.ungroupedString())")
                .textSelection(.enabled)
        }
    }

    func parse() {
        var lines = readLines(inputText)
        guard lines.count > 0 else {
            target = -1
            cost = Int.max
            return
        }
        let subs = lines.removeFirst().split(separator: ",").map({Int($0)!})
        computer = CrabSubMover(subPositions: subs)
    }

    func compute() {
        if let bestTuple = computer?.bestPositionAndCost {
            target = bestTuple.0
            cost = bestTuple.1
        }
    }
}

struct Day7View_Previews: PreviewProvider {
    static var previews: some View {
        Day7View()
    }
}
