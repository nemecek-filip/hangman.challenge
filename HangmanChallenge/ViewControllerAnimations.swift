//
//  ViewControllerAnimations.swift
//  HangmanChallenge
//
//  Created by Filip Němeček on 24/03/2019.
//  Copyright © 2019 Filip Němeček. All rights reserved.
//

import UIKit

extension ViewController {
    func animateHangmanLabel() {
        let rotationAngleRad : CGFloat = 0.11
        
        hangmanLabel.transform = CGAffineTransform(rotationAngle: -1.0 * rotationAngleRad)
        
        UIView.animate(withDuration: 0.9, delay: 0, options: [.curveEaseInOut, .autoreverse, .repeat], animations: {
            UIView.setAnimationRepeatCount(3)
            self.hangmanLabel.transform = CGAffineTransform(rotationAngle: 2 * rotationAngleRad)
        }) { (status) in
            UIView.animate(withDuration: 0.4, animations: {
                self.hangmanLabel.transform = CGAffineTransform.identity
            })
        }
    }
    
    func shakeGuessLabel() {
        // Credit: Sean Allen - https://gist.github.com/SAllen0400/a09754049fcdcc00695291b3a011fbbd
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: guessLabel.center.x - 5, y: guessLabel.center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: guessLabel.center.x + 5, y: guessLabel.center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        guessLabel.layer.add(shake, forKey: "position")
    }
}
