//
//  ConcentrationApp.swift
//  Concentration
//
//  Created by yulias on 22/05/2023.
//

import SwiftUI

@main
struct ConcentrationApp: App {
    private let game = EmojiConcentrateGame()
    var body: some Scene {
        WindowGroup {
            EmojiConcentrateGameView(viewModel: game)
        }
    }
}

 
