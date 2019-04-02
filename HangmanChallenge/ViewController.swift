//
//  ViewController.swift
//  HangmanChallenge
//
//  Created by Filip Němeček on 13/03/2019.
//  Copyright © 2019 Filip Němeček. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HangmanGameDelegate {

    @IBOutlet var guessLabel: UILabel!
    @IBOutlet var hangmanLabel: UILabel!
    
    @IBOutlet var hangmanViewContainer: UIView!
    
    @IBOutlet var firstButtonStack: UIStackView!
    @IBOutlet var secondButtonStack: UIStackView!
    @IBOutlet var thirdButtonStack: UIStackView!
    @IBOutlet var fourthButtonStack: UIStackView!
    
    var buttonsAnimators = [UIViewPropertyAnimator]()
    
    var game: HangmanGame!
    
    var hangmanView: HangmanView!
    
    let words = ["POMELO", "SPARROW", "OX", "DOMINO", "PLANT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButtons()
        
        hangmanView = HangmanView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        hangmanViewContainer.addSubview(hangmanView)
        
        game = HangmanGame()
        game.delegate = self
        game.startGame(with: words.randomElement()!)
    }
    
    func hangmanGame(game: HangmanGame, didUpdateGuessText text: String) {
        self.guessLabel.text = text
        self.guessLabel.addCharacterSpacing(kernValue: 5)
    }
    
    func hangmanGame(game: HangmanGame, didEnded result: HangmaGameResult) {
        
        let title: String
        let message: String
        
        if result == .win {
            title = "Nice job!"
            message = "You found the correct word."
        } else {
            title = "Game Over!"
            message = "Better luck next time"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: { [weak self] (action) in
                self?.newGame()
        }))
        self.present(ac, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateHangmanLabel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func newGame() {
        reset()
        game.startGame(with: words.randomElement()!)
    }
    
    func reset() {
        clearButtons()
        hangmanView.reset()
        initButtons()
        animateHangmanLabel()
    }
    
    private func clearButtons() {
        for stack in [firstButtonStack, secondButtonStack, thirdButtonStack, fourthButtonStack] {
            for subview in stack!.arrangedSubviews.compactMap({ $0 as? RoundedButton }) {
                stack!.removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
        }
    }
    
    private func initButtons() {        
        let letters = Character.alphabet
        
        let rangesStacksDict = [
            0..<7   : firstButtonStack,
            7..<13  : secondButtonStack,
            13..<20 : thirdButtonStack,
            20..<26 : fourthButtonStack
        ]
        
        for rangeStack in rangesStacksDict {
            for i in rangeStack.key {
                rangeStack.value!.addArrangedSubview(createLetterButton(letter: letters[i]))
            }
        }
        
        buttonsAnimators.forEach {
            $0.startAnimation()
        }
        
//        for i in 0..<7 {
//            firstButtonStack.addArrangedSubview(createLetterButton(letter: letters[i]))
//        }
//
//        for i in 7..<13 {
//            secondButtonStack.addArrangedSubview(createLetterButton(letter: letters[i]))
//        }
        
//        for i in 13..<20 {
//            thirdButtonStack.addArrangedSubview(createLetterButton(letter: letters[i]))
//        }
//
//        for i in 20..<26 {
//            fourthButtonStack.addArrangedSubview(createLetterButton(letter: letters[i]))
//        }
    }
    
    @objc func letterButtonTapped(_ sender: RoundedButton) {
        let titleChar = Character(sender.title(for: .normal)!)

        if !game.guessCharacter(titleChar) {
            shakeGuessLabel()
            hangmanView.advanceOneStep()
        }
        
        sender.animateToDisable()
    }
    
    private func createLetterButton(letter: Character) -> RoundedButton {
        let button = RoundedButton()
        button.backgroundColor = UIColor.accent
        button.addTarget(self, action: #selector(letterButtonTapped), for: .touchUpInside)
        
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1.0).isActive = true
        button.setTitleColor(UIColor.background, for: .normal)
        button.setTitle(String(letter), for: .normal)
        
        button.layer.opacity = 0.1
        button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        buttonsAnimators.append(UIViewPropertyAnimator(duration: 0.9, curve: .easeInOut, animations: {
            button.layer.opacity = 1
            button.transform = CGAffineTransform.identity
        }))
        
        return button
    }
}

