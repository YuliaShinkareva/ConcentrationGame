//
//  Theme.swift
//  Concentration
//
//  Created by yulias on 28/06/2023.


import Foundation

struct Theme {
    var name: String
    var emojis: Array<String>
    var numberOfPairsOfCards: Int {
        return emojis.count
    }
    var color: String

    init(name: String, emojis: Array<String>, color: String) {
        self.name = name
        self.emojis = emojis
        self.color = color
    }
}
 
