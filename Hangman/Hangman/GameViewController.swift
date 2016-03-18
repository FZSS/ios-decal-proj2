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
    var incorrectTryNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        secretWord = hangmanPhrases.getRandomPhrase()
        var length :  Int = secretWord.characters.count
        var dashes = ""
        for _ in 0..<length {
            dashes += "-"
        }
        GuessTextUI.text = dashes
        loadInterface()
    }
    
    
    func loadInterface() {
        GuessButton.addTarget(self, action:"guess", forControlEvents: .TouchUpInside)
        StartOverButton.addTarget(self, action:"startOver", forControlEvents: .TouchUpInside)
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
