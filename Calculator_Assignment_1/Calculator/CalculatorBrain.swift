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
    
    var description = " "
    var isPartialResult = false
    
    func setOperand(operand: Double) {
        accumlator = operand
        if isPartialResult == false {
            description = String(format: "%g",accumlator)
        }
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        //"±" : Operation.UnaryOperation({ -$0 }),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "sin" : Operation.UnaryOperation(sin),
        "ln" : Operation.UnaryOperation(log),
        "Rand" : Operation.Random,
        "%" : Operation.BinaryOperation({ $0 % $1 }),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "−" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals,
        "C" : Operation.Clear
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Random
        case Equals
        case Clear
    }
    
    func performOperation(symbol: String) {
        //API incase that symbol doesnot exit in dictionary
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumlator = value
                if isPartialResult == true {
                    description += symbol
                    isPartialResult = false
                } else {
                    description = symbol
                }
            case .UnaryOperation(let function):
                accumlator = function(accumlator)
                if isPartialResult == true {
                    description += symbol + String(format: "%g",accumlator)
                    isPartialResult = false
                } else {
                    description = symbol + "(\(description))"
                }
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumlator)
                description += " " + symbol + " "
                isPartialResult = true
            case .Random :
                srand48(Int(arc4random()))
                accumlator = drand48()
                if isPartialResult == true {
                    description += symbol
                    isPartialResult = false
                } else {
                    description = symbol
                }
            case .Equals:
                executePendingBinaryOperation()
            case .Clear:
                clear()
            }
        }
    }
    
    private func clear(){
        accumlator = 0.0
        pending = nil
        isPartialResult = false
        description = " "
    }
    
    private func executePendingBinaryOperation()
    {
        if  isPartialResult == true {
            description += String(format: "%g",accumlator)
            isPartialResult = false
        }
        if pending != nil {
            accumlator = pending!.binaryFunction(pending!.firstOperand, accumlator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double{
        get {
            return accumlator
        }
    }
}