//
//  EstudoSwiftUIApp.swift
//  EstudoSwiftUI
//
//  Created by Rodrigo Carvalho on 24/09/20.
//

import SwiftUI

@main
struct EstudoSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
