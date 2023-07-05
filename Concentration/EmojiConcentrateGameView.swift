//
//  EmojiConcentrateGameView.swift
//  Concentration
//
//  Created by yulias on 22/05/2023.

import SwiftUI

struct EmojiConcentrateGameView: View {
    @ObservedObject var viewModel: EmojiConcentrateGame
    
    
    var body: some View {
            VStack {
                Text("Concentration Game: \(viewModel.themeName)")
                    .font(.title)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                Text("Score: \(viewModel.score)").font(.largeTitle).foregroundColor(.red)
                AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                    .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
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
        }
    }


 
struct CardView: View {

  let card: EmojiConcentrateGame.Card
    let shape = RoundedRectangle(cornerRadius: DrawingConstants.conrnerRadius)

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    shape
                        .fill(.white)
                    shape
                        .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape
                }
                
            }
    }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let conrnerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}

 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiConcentrateGame()
        
        EmojiConcentrateGameView(viewModel: game)
            .preferredColorScheme(.dark)
        EmojiConcentrateGameView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
