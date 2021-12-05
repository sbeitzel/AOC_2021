//
//  Day2View.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/3/21.
//

import Algorithms
import SwiftUI

struct Day2View: View {
    static let tag = "Day2"

    @State private var inputText: String = ""

    var commands: [String] {
        readLines(inputText)
    }

    // swiftlint:disable:next large_tuple
    var positionTuple: (Int, Int, Int) {
        processCommands(commands)
    }

    var body: some View {
        VStack {
            TextEditor(text: $inputText)
                .font(.system(.body, design: .monospaced))
            Divider()
            Text("Horizontal position: \(positionTuple.0.ungroupedString())")
            Text("Depth: \(positionTuple.1.ungroupedString())")
            Text("Product: \((positionTuple.0 * positionTuple.1).ungroupedString())").textSelection(.enabled)
        }
    }
}

struct Day2View_Previews: PreviewProvider {
    static var previews: some View {
        Day2View()
    }
}
