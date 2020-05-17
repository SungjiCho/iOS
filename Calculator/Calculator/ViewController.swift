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
    
    var userIsInTheMiddleOfTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if let mathmaticalSymbol = sender.currentTitle{
            if mathmaticalSymbol == "π"{
                display.text = String(Double.pi)
            }
        }
        userIsInTheMiddleOfTyping = false
    }
}

