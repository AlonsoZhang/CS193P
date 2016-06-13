//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Alonso Zhang on 16/6/13.
//  Copyright © 2016年 Alonso Zhang. All rights reserved.
//

import Foundation
class CalculatorBrain {
    private var accumlator = 0.0
    func setOperand(operand: Double) {
        accumlator = operand
    }
    
    var operations: Dictionary<String,Double> = [
        "π" : M_PI,
        "e" : M_E
    
    ]
    func performOperation(symbol: String) {
        let constant = operations[symbol]
        accumlator = constant!
        
    }
    var result: Double{
        get {
            return accumlator
        }
    }
}