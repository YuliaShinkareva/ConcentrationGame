//
//  EmojiConcentrationGame.swift
//  Concentration
//
//  Created by yulias on 26/05/2023.


import SwiftUI
 

class EmojiConcentrateGame: ObservableObject  {
    
    
    @Published private var model: ConcentrateGame<String>
    private var theme: Theme
    
    init() {
        theme = EmojiConcentrateGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiConcentrateGame.createConcentrateGame(theme: theme)
    }
    
    static var themes: Array<Theme> = [
    Theme(
        name: "Animals",
        emojis: ["🐶", "🐱", "🐭", "🐹", "🦊", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🦉", "🦄", "🦋", "🐌", "🐜", "🐢"],
//        numberOfPairsOfCards: 10,
        color: "orange"
    ),
    Theme(
        name: "Games",
        emojis: ["⚽️", "🥎", "🏸", "🛼", "🏹", "🏒", "🏉", "🏓"],
        color: "mint"
    ),
    Theme(
        name: "Meal",
        emojis: ["🍏", "🫐", "🍆", "🥦", "🥨", "🍇", "🍑" ,"🍒"],
        color: "blue"
    ),
    Theme(
        name: "Vehicles",
        emojis: ["🚗", "🚕", "🚌", "🚎", "🚑", "🛺", "✈️", "🛶", "🚢", "🚁"],
        color: "pink"
    ),
    Theme(
        name: "Flags",
        emojis: ["🇧🇪", "🇧🇷", "🇨🇩", "🇧🇬", "🇨🇰", "🇬🇪", "🇱🇧", "🇹🇬"],
        color: "green"
    ),
    Theme(
        name: "Emojis",
        emojis: ["🥳", "😜", "🤯", "🫣", "🫥", "🥴", "🥶", "🥰", "😂"],
        color: "indigo"

    )]
    

    static func createConcentrateGame(theme: Theme) ->  ConcentrateGame<String> {
        ConcentrateGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            theme.emojis[pairIndex]

        }
    }
    
    var themeColor: Color {
        switch theme.color {
        case "orange":
            return .orange
        case "mint":
            return .mint
        case "blue":
            return .blue
        case "pink":
            return .pink
        case "green":
            return .green
        case "indigo":
            return .indigo
        default:
            return .gray
        }
    }
    var themeName: String {
        theme.name
    }
    
  
    var score: Int {
        model.score
    }
    
 
    var cards: Array<ConcentrateGame<String>.Card> {
           model.cards
        }
    // MARK: - Intent(s)

    func choose(_ card: ConcentrateGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        theme = EmojiConcentrateGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiConcentrateGame.createConcentrateGame(theme: theme)
    }
    }


