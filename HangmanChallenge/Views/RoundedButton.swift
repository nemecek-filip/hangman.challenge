//
//  RoundedButton.swift
//  HangmanChallenge
//
//  Created by Filip Němeček on 15/03/2019.
//  Copyright © 2019 Filip Němeček. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    let disableAnimationDuration : TimeInterval = 0.4
    let disabledButtonScale : CGFloat = 0.7
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }
    
    override var isHighlighted: Bool {
        didSet {
            highlightAnimation()
        }
    }   
}

extension RoundedButton {
    func highlightAnimation() {
        guard self.isUserInteractionEnabled else { return }
        UIView.animate(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
            self.alpha = self.isHighlighted ? 0.5 : 1
        }, completion: nil)
    }
    
    func animateToDisable() {
        self.isUserInteractionEnabled = false
        
        let animator = UIViewPropertyAnimator(duration: disableAnimationDuration, curve: .easeInOut) {
            
            //self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            // Because transform messes up the corner radius
            let newWidth = self.frame.width * self.disabledButtonScale
            let newHeight = self.frame.height * self.disabledButtonScale
            self.frame = CGRect(x: self.center.x - newWidth / 2, y: self.center.y - newHeight / 2, width: newWidth, height: newHeight)
        }
        
        animator.addAnimations({
            self.layer.cornerRadius = (self.frame.height * 0.7) / 2
            self.layer.opacity = 0.3
        }, delayFactor: CGFloat(disableAnimationDuration))
        
        animator.startAnimation()
    }
}
