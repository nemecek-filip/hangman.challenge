//
//  CharacterExt.swift
//  HangmanChallenge
//
//  Created by Filip Němeček on 24/03/2019.
//  Copyright © 2019 Filip Němeček. All rights reserved.
//

import Foundation

extension Character {
    static var alphabet: [Character] {
        let scalars = "A".unicodeScalars
        let unicodeCode = scalars[scalars.startIndex].value
        
        return (0..<26).map {
            i in Character(UnicodeScalar(unicodeCode + i)!)
        }
    }
}
