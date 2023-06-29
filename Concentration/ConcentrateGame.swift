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

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
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
                faceUpCardIndex = nil
            } else {
                for index in 0..<cards.count {
                    if cards[index].isFaceUp {
                        cards[index].isFaceUp = false
                        cards[index].hasAlreadyBeenSeen = true
                    }
             
                }
                faceUpCardIndex = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }



    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()

        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }

    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasAlreadyBeenSeen = false
        var content: CardContent
        var id: Int
    }
}

 
