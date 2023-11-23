//
//  ViewController.swift
//  zadanie1
//
//  Created by Przemek Pawlik on 21/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    var currentInput: String = ""
    var currentNumber: Double = 0.0
    var previousNumber: Double = 0.0
    var operation: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAllHelper()
    }
    
    func clearAllHelper(){
        resultsLabel.text=""
        currentInput = ""
        currentNumber = 0.0
        previousNumber = 0.0
        operation = ""
    }
    
    func performOperation() {
        switch operation {
        case "+":
            previousNumber += currentNumber
        case "-":
            previousNumber -= currentNumber
        case "*":
            previousNumber *= currentNumber
        case "/":
            if currentNumber != 0 {
                previousNumber /= currentNumber
            } else {
                clearAllHelper()
                resultsLabel.text = "Error"
                return
            }
        default:
            break
        }
        
        currentNumber = previousNumber
        
        
        let integerPart = Int(currentNumber)
        let decimalPart = currentNumber - Double(integerPart)
        
        if decimalPart != 0.0 {
            resultsLabel.text = String(currentNumber)
        } else{
            guard let dotIndex = String(currentNumber).firstIndex(of: ".") else { return }
            let integerPart = String(currentNumber)[..<dotIndex]
            resultsLabel.text = String(integerPart)
        }
    }
    
    func operationHandle(newOperation: String) {
        if !currentInput.isEmpty {
            currentNumber = Double(currentInput) ?? 0.0
            currentInput = ""
        }
        
        if operation.isEmpty {
            previousNumber = currentNumber
        } else {
            performOperation()
        }
        
        operation = newOperation
    }
    
    @IBAction func clearAll(_ sender: Any) {
        clearAllHelper()
    }
    
    @IBAction func addButton(_ sender: Any) {
        operationHandle(newOperation: "+")
    }
    
    @IBAction func minusButton(_ sender: Any) {
        operationHandle(newOperation: "-")
    }
    
    @IBAction func multiplyButton(_ sender: Any) {
        operationHandle(newOperation: "*")
    }
    
    @IBAction func divideButton(_ sender: Any) {
        operationHandle(newOperation: "/")
    }
    
    @IBAction func equalButton(_ sender: Any) {
        if !currentInput.isEmpty {
            currentNumber = Double(currentInput) ?? 0.0
            currentInput = ""
        }
        
        if operation.isEmpty{
            print(currentNumber)
            
            let integerPart = Int(currentNumber)
            let decimalPart = currentNumber - Double(integerPart)
            
            if decimalPart != 0.0 {
                resultsLabel.text = String(currentNumber)
            } else{
                guard let dotIndex = String(currentNumber).firstIndex(of: ".") else { return }
                let integerPart = String(currentNumber)[..<dotIndex]
                resultsLabel.text = String(integerPart)
            }
        } else{
            performOperation()
            operation = ""
        }
    }
    
    @IBAction func strokeButton(_ sender: Any) {
        if currentInput == ""{
            currentInput += "0."
            resultsLabel.text = currentInput
            return
        }
        if currentInput.contains(".") {
            return
        } else {
            currentInput += "."
            resultsLabel.text = currentInput
        }
    }
    
    @IBAction func changeSign(_ sender: Any) {
        if !currentInput.isEmpty{
            if currentInput.hasPrefix("-"){
                currentInput.remove(at: currentInput.startIndex)
            }else{
                currentInput = "-" + currentInput
            }
            resultsLabel.text = currentInput
        }
    }
    
    
    @IBAction func zeroButton(_ sender: Any) {
        if currentInput != "0"{
            currentInput += "0"
            resultsLabel.text = currentInput
        }
    }
    
    @IBAction func oneButton(_ sender: Any) {
        if currentInput != "0"{
            currentInput += "1"
            resultsLabel.text = currentInput
        }
    }
    
    @IBAction func twoButton(_ sender: Any) {
        if currentInput != "0"{
            currentInput += "2"
            resultsLabel.text = currentInput
        }
    }
    
    @IBAction func threeButton(_ sender: Any) {
        if currentInput != "0"{
            currentInput += "3"
            resultsLabel.text = currentInput
        }
    }
    
    @IBAction func fourButton(_ sender: Any) {
        if currentInput != "0"{
            currentInput += "4"
            resultsLabel.text = currentInput
        }
    }
    
    @IBAction func fiveButton(_ sender: Any) {
        if currentInput != "0"{
            currentInput += "5"
            resultsLabel.text = currentInput
        }
    }
    
    @IBAction func sixButton(_ sender: Any) {
        if currentInput != "0"{
            currentInput += "6"
            resultsLabel.text = currentInput
        }
    }
    
    @IBAction func sevenButton(_ sender: Any) {
        if currentInput != "0"{
            currentInput += "7"
            resultsLabel.text = currentInput
        }
    }
    
    @IBAction func eightButton(_ sender: Any) {
        if currentInput != "0"{
            currentInput += "8"
            resultsLabel.text = currentInput
        }
    }
    
    @IBAction func nineButton(_ sender: Any) {
        if currentInput != "0"{
            currentInput += "9"
            resultsLabel.text = currentInput
        }
    }
}

