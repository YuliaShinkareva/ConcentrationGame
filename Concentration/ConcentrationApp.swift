//
//  ConcentrationApp.swift
//  Concentration
//
//  Created by yulias on 22/05/2023.
//

import SwiftUI

@main
struct ConcentrationApp: App {
    let game = EmojiConcentrateGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}

 
