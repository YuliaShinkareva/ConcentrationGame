//
//  EmojiConcentrateGameView.swift
//  Concentration
//
//  Created by yulias on 22/05/2023.

import SwiftUI

struct EmojiConcentrateGameView: View {
    @ObservedObject var viewModel: EmojiConcentrateGame
    @Namespace private var dealingNamespace
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                HStack {
                    restart
                    Spacer()
                    shuffle
                }
                
                .padding(.horizontal)
            }
            deckBody
        }
        .padding()
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiConcentrateGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiConcentrateGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiConcentrateGame.Card) -> Animation {
        var delay = 0.0
        if let index = viewModel.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (CardConstants.totalDealDuration) / Double(viewModel.cards.count)
        }
        return Animation.easeOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiConcentrateGame.Card) -> Double {
        -Double(viewModel.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    var gameBody: some View {
        VStack {
            Text("Concentration Game: \(viewModel.themeName)")
                .font(.title)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            Text("Score: \(viewModel.score)").font(.largeTitle).foregroundColor(.red)
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .padding(4)
                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                        .zIndex(zIndex(of: card))
                        .onTapGesture {
                            withAnimation {
                                viewModel.choose(card)
                            }
                            
                        }
                }
            }
            .foregroundColor(viewModel.themeColor)
        }
    }
    
    var deckBody: some View {
            ZStack {
                ForEach(viewModel.cards.filter(isUndealt)) { card in
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                        .zIndex(zIndex(of: card))
            }
        }
            .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight)
            .foregroundColor(viewModel.themeColor)
            .onTapGesture {
                    for card in viewModel.cards {
                        withAnimation(dealAnimation(for: card)) {
                        deal(card)
                    }
                }
            }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
        
        var restart: some View {
            Button("Restart") {
                withAnimation {
                    dealt = []
                    viewModel.newGame()
                }
            }
    }
        
        
        private struct CardConstants {
            static let aspectRatio: CGFloat = 2/3
            static let dealDuration: Double = 0.5
            static let totalDealDuration: Double = 2
            static let undealHeight: CGFloat = 90
            static let undealWidth = undealHeight * aspectRatio
        }
    }
    
    
    struct CardView: View {
        
        let card: EmojiConcentrateGame.Card
        @State private var animatedBonusRemaning: Double = 0
        
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            CircleShape(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - animatedBonusRemaning) * 360 - 90))
                                .onAppear{
                                    animatedBonusRemaning = card.bonusRemaining
                                    withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                        animatedBonusRemaning = 0
                                    }
                                }
                        } else {
                            CircleShape(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90))
                        }
                    }
                        .padding(DrawingConstants.circlePadding)
                        .opacity(DrawingConstants.circleOpacity)
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                        .font(font(in: geometry.size))
                }
                .cardify(isFaceUp: card.isFaceUp)
                
            }
        }
        
        
        private func font(in size: CGSize) -> Font {
            Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
        }
        
        
        
        private struct DrawingConstants {
            static let fontScale: CGFloat = 0.7
            static let circlePadding: CGFloat = 4
            static let circleOpacity: CGFloat = 0.3
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = EmojiConcentrateGame()
            game.choose(game.cards.first!)
            return EmojiConcentrateGameView(viewModel: game)
        }
    }


 
