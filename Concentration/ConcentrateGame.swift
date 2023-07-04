//
//  ConcentrateGame.swift
//  Concentration
//
//  Created by yulias on 26/05/2023.


import Foundation

struct ConcentrateGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score = 0

    private var faceUpCardIndex: Int?
        {
            get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
            set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
        }


    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let matchCardIndex = faceUpCardIndex {
                if cards[chosenIndex].content == cards[matchCardIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[matchCardIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].hasAlreadyBeenSeen || cards[matchCardIndex].hasAlreadyBeenSeen {
                        score -= 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].hasAlreadyBeenSeen = true
            } else {
                faceUpCardIndex = chosenIndex
            }
  
        }
        }


    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []

        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }

    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var hasAlreadyBeenSeen = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return first
        } else {
            return nil
        }
    }
}
