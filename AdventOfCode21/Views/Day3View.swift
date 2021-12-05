//
//  Day3View.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/3/21.
//

import SwiftUI

struct Day3View: View {
    static let tag = "Day3"

    @State private var inputText = ""

    var countingStruct: BitCounting {
        do {
            return try BitCounting(readLines(inputText))
        } catch {
            return BitCounting()
        }
    }

    var oxygenRate: Int {
        countingStruct.oxygen(startingPlace: countingStruct.fieldWidth - 1)
    }

    var carbonDioxide: Int {
        countingStruct.carbonDioxide(startingPlace: countingStruct.fieldWidth - 1)
    }

    var body: some View {
        VStack {
            TextEditor(text: $inputText)
                .font(.system(.body, design: .monospaced))
            Divider()
            Text("Gamma rate: \(countingStruct.computeGamma().ungroupedString())")
            Text("Epsilon rate: \(countingStruct.computeEpsilon().ungroupedString())")
            // swiftlint:disable:next line_length
            Text("Power consumption: \((countingStruct.computeGamma() * countingStruct.computeEpsilon()).ungroupedString())")
                .textSelection(.enabled)
            Text("Oxygen generator: \(oxygenRate)")
            Text("CO2 scrubber: \(carbonDioxide)")
            Text("Life support rating: \((oxygenRate * carbonDioxide).ungroupedString())")
                .textSelection(.enabled)
        }
    }
}

struct Day3View_Previews: PreviewProvider {
    static var previews: some View {
        Day3View()
    }
}
