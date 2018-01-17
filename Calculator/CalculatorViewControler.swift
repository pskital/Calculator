//
//  ViewController.swift
//  Calculator
//
//  Created by Witchcraft-11 on 16.01.2018.
//  Copyright © 2018 Witchcraft-11. All rights reserved.
//

import UIKit

class CalculatorViewControler: UIViewController {

    @IBOutlet weak var UILabelDisplay: UILabel!
    var isUserTyping = false
    var calculatorEngine = CalculatorEngine()

    @IBAction func onDigitPressed(_ sender: UIButton) {
        let digit = sender.currentTitle!
        print("\(digit) touched")

        if isUserTyping {
            UILabelDisplay.text = UILabelDisplay.text! + digit
        } else {
            UILabelDisplay.text = digit
            isUserTyping = true
        }
    }

    var displayValue: Double {
        get {
            return Double(UILabelDisplay.text!)!
        }
        set {
            UILabelDisplay.text = String(newValue)
        }
    }

    @IBAction func performOperation(_ sender: UIButton) {
        if isUserTyping {
            calculatorEngine.setOperand(displayValue)
            isUserTyping = false
        }

        if let symbol = sender.currentTitle {
            calculatorEngine.performOperation(symbol)
        }

        if let result = calculatorEngine.result {
            displayValue = result
        }
    }
}

