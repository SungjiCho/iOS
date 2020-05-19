//
//  ViewController.swift
//  Calculator
//
//  Created by 조성지 on 2020/05/14.
//  Copyright © 2020 조성지. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction private func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    /*프로퍼티는 클래스, 구조체, 열거형과 연관된 값으로, 타입과 관련된 값을 저장할 수도, 연산할 수도 있다. 이는 클래스, 구조체, 열거형 내부에 구현할 수 있는데, 다만 열거형 내부에는 연산 프로퍼티만 구현할 수 있다.
     연산 프로퍼티는 var 키워드로만 선언할 수 있으며, 읽기와 쓰기 모두 가능하게 하려면 get 블록과 set 블록을 모두 구현하면 된다. set 블록에서 암시적 매개변수인 newValue를 사용할 수 있다.
     */
    
    private var displayValue: Double{
        get{
            return Double(display.text!)!
        }set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping{
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathmaticalSymbol = sender.currentTitle{
            
            brain.setOperand(operand: displayValue)
            brain.performOperation(symbol: mathmaticalSymbol)
            displayValue = brain.result

        }
        
    }
}

