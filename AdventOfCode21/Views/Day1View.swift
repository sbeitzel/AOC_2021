//
//  Day1View.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/4/21.
//

import SwiftUI

struct Day1View: View {
    static let tag = "Day1"

    @State private var inputText: String = ""

    var numbers: [Int] {
        stringsToInts(readNumericStrings(inputText))
    }

    var increasingPairs: Int {
        countIncreasingPairs(numbers)
    }

    var increasingTriplets: Int {
        countIncreasingTriplets(numbers)
    }

    var body: some View {
        VStack {
            TextEditor(text: $inputText)
                .font(.system(.body, design: .monospaced))
            Divider()
            Text("Increasing pairs: \(increasingPairs.ungroupedString())").textSelection(.enabled)
            Text("Increasing triplets: \(increasingTriplets.ungroupedString())").textSelection(.enabled)
        }
    }
}

struct Day1View_Previews: PreviewProvider {
    static var previews: some View {
        Day1View()
    }
}
