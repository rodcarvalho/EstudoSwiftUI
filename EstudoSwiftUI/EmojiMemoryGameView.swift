//
//  EmojiMemoryGameView.swift
//  EstudoSwiftUI
//
//  Created by Rodrigo Carvalho on 24/09/20.
//

import SwiftUI

//Essa Struct Funciona como uma View
struct EmojiMemoryGameView: View {
    //@ObservedObject é responsável por ficar de olho nas mudanças enviadas pelo ViewModel e redesenha a view
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)){
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            Button(action: {
                withAnimation(.easeInOut(duration: 2)) {
                    self.viewModel.resetGamee()
                }
            }, label: { Text("Novo Jogo") })
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func starBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    var body: some View{
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isCosumingBonusTime {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                                .onAppear {
                                    self.starBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                        }
                    }
                    .padding(5).opacity(0.4)
                    .transition(.identity)
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 :0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default) 
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
                .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
            }
        }
    }
    // MARK: - Drawing Constants
    
    private let fontScaleFactor: CGFloat = 0.7
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[3])
        return EmojiMemoryGameView(viewModel: game)
    }
}

