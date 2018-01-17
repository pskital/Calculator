//
//  File.swift
//  Calculator
//
//  Created by Witchcraft-11 on 16.01.2018.
//  Copyright © 2018 Witchcraft-11. All rights reserved.
//

import Foundation

func changeSigne(operand: Double) -> Double {
    return -operand
}

func multiply(op1: Double, opt2: Double) -> Double {
    return op1 * opt2
}

func divide(op1: Double, opt2: Double) -> Double {
    return op1 / opt2
}

func plus(op1: Double, opt2: Double) -> Double {
    return op1 + opt2
}

func minus(op1: Double, opt2: Double) -> Double {
    return op1 - opt2
}

struct CalculatorEngine {

    private var accumulator: Double?

    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binarOperation((Double, Double) -> Double)
        case equals

    }

    private var operations: Dictionary<String, Operation> =
        [
            "𝝅": Operation.constant(Double.pi),
            "e": Operation.constant(M_E),
            "√": Operation.unaryOperation(sqrt),
            "cos": Operation.unaryOperation(cos),
            "±": Operation.unaryOperation(changeSigne),
            "*": Operation.binarOperation(multiply),
            "-": Operation.binarOperation(minus),
            "÷": Operation.binarOperation(divide),
            "+": Operation.binarOperation(plus),
            "=": Operation.equals
        ]

    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case Operation.constant(let value):
                accumulator = value
                break
            case Operation.unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
                break
            case Operation.binarOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperant: accumulator!)
                }
                break

            case Operation.equals:
                performPendingBinaryOperation()
                break
            }
        }
    }

    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(witch: accumulator!)
        }
    }

    private var pendingBinaryOperation: PendingBinaryOperation?

    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperant: Double

        func perform(witch secondOperand: Double) -> Double {
            return function(firstOperant, secondOperand)
        }
    }

    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }

    var result: Double? {
        get {
            return accumulator
        }
    }
}

