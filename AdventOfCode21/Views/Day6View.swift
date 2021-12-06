//
//  Day6View.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/6/21.
//

import SwiftUI

struct Day6View: View {
    static let tag = "Day6"

    @State private var inputText: String = ""
    @State private var numberOfDays: Int = 80

    @State private var fishCount: Int = 0

    var body: some View {
        VStack {
            TextEditor(text: $inputText)
                .font(.system(.body, design: .monospaced))
            Divider()
            HStack(spacing: 10) {
                Stepper(value: $numberOfDays) {
                    Text("Number of days: \(numberOfDays.ungroupedString())")
                }
                Button(action: runSim) { Text("Run Sim") }
            }
            Text("There will be \(fishCount.ungroupedString()) fish.").textSelection(.enabled)
        }
        .padding()
    }

    func runSim() {
        var lines = readLines(inputText)
        guard lines.count > 0 else { return }
        let fish = lines.removeFirst().split(separator: ",")
        let fishStates = fish.map({Int($0) ?? 0})
        guard numberOfDays > 0 else { return }
        var population = Array.init(repeating: 0, count: 9)
        for state in fishStates {
            population[state] += 1
        }
        let sim = LanternFishSim(maturityCounts: population)
        for _ in 1...numberOfDays {
            sim.step()
        }
        fishCount = sim.count
    }
}

struct Day6View_Previews: PreviewProvider {
    static var previews: some View {
        Day6View()
    }
}
