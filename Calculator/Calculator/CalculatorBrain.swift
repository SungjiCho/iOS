//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 조성지 on 2020/05/19.
//  Copyright © 2020 조성지. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    init() {
        
    }
    
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    
    func setOperand(operand: Double){
        self.accumulator = operand
        internalProgram.append(operand as NSNumber)
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : .Constant(Double.pi),
        "e" : .Constant(M_E),
        "√" : .UnaryOperation(sqrt),
        "±" : .UnaryOperation({ -$0 }),
        "cos" : .UnaryOperation(cos),
        "✕" : .BinaryOperation({ $0 * $1 }),
        "÷" : .BinaryOperation({ $0 / $1 }),
        "+" : .BinaryOperation({ $0 + $1 }),
        "-" : .BinaryOperation({ $0 - $1 }),
        "=" : .Equals
    ]
    
    private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String){
        internalProgram.append(symbol as NSString)
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let associatedConstantValue): accumulator = associatedConstantValue
            case .UnaryOperation(let associatedFunction): accumulator = associatedFunction(accumulator)
            case .BinaryOperation(let associatedFunctiom):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInto(binaryfunction: associatedFunctiom, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation(){
        if pending != nil{
            accumulator = pending!.binaryfunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInto?
    
    private struct PendingBinaryOperationInto {
        var binaryfunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    typealias PropertyList = AnyObject
    var program: PropertyList{
        get{
           return internalProgram as NSArray
        }
        set{
            clear()
            if let arrayOfOps = newValue as? [AnyObject]{
                for op in arrayOfOps{
                    if let operand = op as? Double{
                        setOperand(operand: operand)
                    }else if let operation = op as? String{
                        performOperation(symbol: operation)
                    }
                }
            }
        }
    }
    
    func clear(){
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    var result: Double {
        get{
            return self.accumulator
        }
    }
}
