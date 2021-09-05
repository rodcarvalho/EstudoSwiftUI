//
//  Array+Only.swift
//  EstudoSwiftUI
//
//  Created by Rodrigo Carvalho on 16/10/20.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil 
    }
}
