//
//  ContentView.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/3/21.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedTab") private var selectedTab = Day1View.tag

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                Day1View()
                    .tabItem { Text("Day 1: Sonar Sweep") }
                    .tag(Day1View.tag)
                Day2View()
                    .tabItem { Text("Day 2: Dive!") }
                    .tag(Day2View.tag)
                Day3View()
                    .tabItem { Text("Day 3: Binary Diagnostic") }
                    .tag(Day3View.tag)
                Day4View()
                    .tabItem { Text("Day 4: Giant Squid") }
                    .tag(Day4View.tag)
                Day6View()
                    .tabItem { Text("Day 6: Lanternfish") }
                    .tag(Day6View.tag)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
