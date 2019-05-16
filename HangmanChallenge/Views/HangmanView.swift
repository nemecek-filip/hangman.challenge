//
//  HangmanView.swift
//  HangmanChallenge
//
//  Created by Filip Němeček on 24/03/2019.
//  Copyright © 2019 Filip Němeček. All rights reserved.
//

import UIKit

class HangmanView: UIView {   
    
    let firstImageView = UIImageView()
    let secondImageView = UIImageView()
    
    private var imageViewToUse : UIImageView!
    
    private var currentStep: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        firstImageView.contentMode = .scaleAspectFit
        firstImageView.frame = frame
        secondImageView.contentMode = .scaleAspectFit
        secondImageView.frame = frame
        
        let baseImageView = UIImageView(image: UIImage(named: "base.png"))
        baseImageView.contentMode = .scaleAspectFit
        baseImageView.frame = frame
        self.addSubview(baseImageView)
        
        self.addSubview(firstImageView)
        self.addSubview(secondImageView)
        
        imageViewToUse = firstImageView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func reset() {
        currentStep = 0
        imageViewToUse = firstImageView
        firstImageView.image = nil
        secondImageView.image = nil
    }
    
    func advanceOneStep() {
        guard currentStep < 7 else {
            return
        }
        
        currentStep += 1
        let newImage = UIImage(named: "step\(currentStep).png")
        
        let imageViewUpdate = imageViewToUse == firstImageView ? firstImageView : secondImageView
        
        imageViewUpdate.image = newImage
        imageViewUpdate.alpha = 0
        
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            imageViewUpdate.alpha = 1
        }
        
        // Flip image view to use so animation works
        imageViewToUse = imageViewToUse == firstImageView ? secondImageView : firstImageView
        
        animator.startAnimation()
    }

}
