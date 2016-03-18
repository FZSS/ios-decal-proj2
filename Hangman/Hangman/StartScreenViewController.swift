//
//  StartScreenViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    @IBOutlet weak var guessInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startGame" {
            let viewController = segue.destinationViewController as! GameViewController
            let tries = Int(guessInput.text!)!
            //once i learned to handle erros I will handle them

        viewController.maxTryNum = tries
        }
    }

}
