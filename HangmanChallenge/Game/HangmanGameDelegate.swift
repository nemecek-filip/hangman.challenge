//
//  HangmanGameDelegate.swift
//  HangmanChallenge
//
//  Created by Filip Němeček on 25/03/2019.
//  Copyright © 2019 Filip Němeček. All rights reserved.
//

import Foundation

enum HangmaGameResult {
    case win
    case loss
}

protocol HangmanGameDelegate: class {
    func hangmanGame(game: HangmanGame, didEnd result: HangmaGameResult)
    func hangmanGame(game: HangmanGame, didUpdateGuessText text: String)
}
