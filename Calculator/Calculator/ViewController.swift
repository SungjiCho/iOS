//
//  ViewController.swift
//  Calculator
//
//  Created by 조성지 on 2020/05/14.
//  Copyright © 2020 조성지. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var currentlyInMiddleOfTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchedDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if currentlyInMiddleOfTyping{
            display.text = display.text! + digit
        }else {
            display.text = digit
        }
        
        currentlyInMiddleOfTyping = true
    }
    
}

