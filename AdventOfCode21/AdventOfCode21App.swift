//
//  AdventOfCode21App.swift
//  AdventOfCode21
//
//  Created by Stephen Beitzel on 12/3/21.
//

import SwiftUI

@main
struct AdventOfCode21App: App {
    // swiftlint:disable:next weak_delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
