//
//  Cardify.swift
//  Concentration
//
//  Created by yulias on 11/07/2023.


import SwiftUI

struct Cardify: AnimatableModifier {
    let shape = RoundedRectangle(cornerRadius: DrawingConstants.conrnerRadius)
   
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double
    
    func body(content: Content) -> some View {
        ZStack {
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }

       private struct DrawingConstants {
           static let conrnerRadius: CGFloat = 10
           static let lineWidth: CGFloat = 3
       }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
