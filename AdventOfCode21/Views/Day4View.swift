//
//  Day4View.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/4/21.
//

import SwiftUI

struct Day4View: View {
    static let tag = "Day4"

    @State private var inputText = ""
    @State private var winningScore: Int = 0
    @State private var lastWinningScore: Int = 0

    var game: BingoGame? {
        readBingoGame(inputText)
    }

    var body: some View {
        VStack {
            TextEditor(text: $inputText)
                .font(.system(.body, design: .monospaced))
            Divider()
            Button(action: runGame) {
                Text("Run Game")
            }
            Text("The first winning score would be: \(winningScore.ungroupedString())").textSelection(.enabled)
            Text("The last winning score would be: \(lastWinningScore.ungroupedString())").textSelection(.enabled)
        }
    }

    func runGame() {
        winningScore = 0
        if let theGame = game {
            while !theGame.boards.isEmpty {
                theGame.singleTurn()
            }
            if theGame.haveAWinner {
                guard let firstTuple = theGame.winningBoards.first, let lastTuple = theGame.winningBoards.last else {
                    winningScore = 0
                    lastWinningScore = 0
                    return
                }
                winningScore = firstTuple.0.score * firstTuple.1
                lastWinningScore = lastTuple.0.score * lastTuple.1
            }
        }
    }
}

struct Day4View_Previews: PreviewProvider {
    static var previews: some View {
        Day4View()
    }
}
