//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var GuessTextUI: UILabel!
    @IBOutlet weak var InputTextField: UITextField!
    @IBOutlet weak var GuessButton: UIButton!
    @IBOutlet weak var HangmanImage: UIImageView!
    @IBOutlet weak var StartOverButton: UIButton!
    
    var secretWord : String = ""
    var wordLength :  Int!
    var maxTryNum : Int = 5

    var incorrectTryNum : Int!
    var guessedLetters : [Character]!
    var secretWordCharArray : [Character]!
    var displayStringArray : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incorrectTryNum = 0
        guessedLetters = []
        secretWordCharArray = []
        displayStringArray  = []

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        secretWord = hangmanPhrases.getRandomPhrase()
        print(secretWord)
        wordLength = secretWord.characters.count
        var dashes = ""
        for i in 0..<wordLength {
            dashes += "-"
            let index = secretWord.startIndex.advancedBy(i)
            secretWordCharArray.append(secretWord[index])
            displayStringArray.append("-")
        }
        GuessTextUI.text = dashes
        loadInterface()
    }
    
    
    func loadInterface() {
        GuessButton.addTarget(self, action:"guess", forControlEvents: .TouchUpInside)
        StartOverButton.addTarget(self, action:"startOver", forControlEvents: .TouchUpInside)
    }
    
    func guess() {
        print(secretWordCharArray)
        print(displayStringArray)

        let guessInput : String = (InputTextField.text?.uppercaseString)!
        if validInput(guessInput) {
            let guess : Character = guessInput.characters.first!
            if guessedBefore(guess) {
                let alertController = UIAlertController(title: "You guessed this letter before!", message: "Try anonther one!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                guessedLetters.append(guess)
                if secretWord.characters.contains(guess) {
                    revealCharacters(guess)
                } else {
                    incorrectTryNum = incorrectTryNum + 1
                    drawHangman()
                }
            }
        }
    }
    
    func drawHangman() {
        if incorrectTryNum > maxTryNum {
            let alertController = UIAlertController(title: "You lost!", message: "Incorrect tries exceeded max!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func revealCharacters(guess : Character) {
        
        var updatedDisplayText = ""
        for i in 0..<wordLength {
            if secretWordCharArray[i] == guess {
                displayStringArray[i] = "\(guess)"
            }
            updatedDisplayText += displayStringArray[i]
        }
        GuessTextUI.text = updatedDisplayText
        
        //check if win
        if !displayStringArray.contains("-") {
            let alertController = UIAlertController(title: "You win!", message: "You are so good!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Yay!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    func guessedBefore(guess: Character) -> Bool {
        return guessedLetters.contains(guess)
    }
    
    func validInput(guess : String) -> Bool {
        if guess == " "  {
            return true
        }
        if guess.characters.count > 1 {
            let alertController = UIAlertController(title: "More than one letter!", message: "Please guess one letter", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        else if guess.rangeOfCharacterFromSet(NSCharacterSet.letterCharacterSet()) == nil {
            let alertController = UIAlertController(title: "Not a number!", message: "Please provide a letter", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }

    func startOver() {
        viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
