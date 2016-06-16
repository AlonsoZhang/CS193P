//
//  ViewController.swift
//  Calculator
//
//  Created by Alonso Zhang on 16/6/11.
//  Copyright © 2016年 Alonso Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    @IBOutlet private weak var display: UILabel!
    @IBOutlet private weak var formula: UILabel!
    
    private var userIsInTheMiddleOfTyping: Bool = false
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            var textCurrentIndisplay = display.text! + digit
            if let pos = textCurrentIndisplay.rangeOfString("."){
                textCurrentIndisplay = textCurrentIndisplay.stringByReplacingOccurrencesOfString(".", withString: "", options: NSStringCompareOptions.LiteralSearch, range: pos.endIndex..<textCurrentIndisplay.endIndex)
            }
            display.text = textCurrentIndisplay
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain: CalculatorBrain = CalculatorBrain()
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == sender.currentTitle  {
                brain.performOperation(mathematicalSymbol)
            }
            displayValue = brain.result
        }
        
        formula.text = brain.description
        if formula.text == " " {
            return
        }
        if brain.isPartialResult == true {
            formula.text! += "..."
        } else {
            formula.text! += " ="
        }
        
        print(brain.description)
    }
}