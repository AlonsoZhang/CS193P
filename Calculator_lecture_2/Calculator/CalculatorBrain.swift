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
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "±" : Operation.UnaryOperation({ -$0 }),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" :Operation.BinaryOperation({ $0 * $1 }),
        "÷" :Operation.BinaryOperation({ $0 / $1 }),
        "+" :Operation.BinaryOperation({ $0 + $1 }),
        "−" :Operation.BinaryOperation({ $0 - $1 }),
        "=" :Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumlator = value
            case .UnaryOperation(let function):
                accumlator = function(accumlator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumlator)
            case .Equals: executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation()
    {
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