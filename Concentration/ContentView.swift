//
//  ContentView.swift
//  Concentration
//
//  Created by yulias on 22/05/2023.

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiConcentrateGame
    
    
    var body: some View {
            VStack {
                Text("Concentration Game: \(viewModel.themeName)")
                    .font(.title)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                Text("Score: \(viewModel.score)").font(.largeTitle)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    viewModel.choose(card)
                                }
                        }
                    }
                }
                .foregroundColor(viewModel.themeColor)
                .padding()
                
                Button{
                    viewModel.newGame()
                } label: {
                    Text("New Game")
                        .font(.largeTitle)
                }
            }
            .padding()
        }
    }


 
struct CardView: View {

    let card: ConcentrateGame<String>.Card
    let shape = RoundedRectangle(cornerRadius: 25)


    var body: some View {
        ZStack {
            if card.isFaceUp {
                shape
                    .fill(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape
            }

        }
    }
}

 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiConcentrateGame()
        
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
