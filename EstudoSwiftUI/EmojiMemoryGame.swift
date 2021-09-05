//
//  EmojiMemoryGame.swift
//  EstudoSwiftUI
//
//  Created by Rodrigo Carvalho on 09/10/20.
//

import SwiftUI


//Essa classe funciona como um ViewModel
class EmojiMemoryGame: ObservableObject {
    
    //@Published faz com que a função .send() do nosso objeto observável seja chamada automaticamente a cada modificação do nosso modelo
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["🥋","🚲","🥊"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Acess to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    // MARK: - Intents(s)
    // A partir desse ponto ficam as intenções de interação da view com o modelo
    
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
    
    func resetGamee() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
