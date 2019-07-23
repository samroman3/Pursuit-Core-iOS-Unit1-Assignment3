//
//  main.swift
//  Calculator
//
//  Created by Sam Roman on 07/20/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

//i used the function given in the original calculator fork on git hub because i wasnt sure how to incorporate the operations func on README.me

//var operations: ([String: (Double, Double) -> Double]) = ["+": { $0 + $1 },
//"-": { $0 - $1 },
//"*": { $0 * $1 },
//"/": { $0 / $1 }]

func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
    switch opString {
    case "+":
        return {x, y in x + y }
    case "-":
        return {x, y in x - y }
    case "*":
        return {x, y in x * y }
    case "/":
        return {x, y in x / y }
    default:
        return {x, y in x + y }
    }
}
//randomguess function takes two arguments of double, a random operator from operatorarray and assigns it to "random" variable, calls mathstufffactory for random and assigns it to randomOperation. result is calculated with user input, if equal to user input it prints a confirmation and asks to calculate again
func randomGuess(x:Double, y:Double) {
    let operatorArray = ["+","-","*","/"]
    print("Guess the Operator")
    if let random = operatorArray.randomElement() {
        let randomOperation = mathStuffFactory(opString: random)
        let result = randomOperation(x, y)
        print ("\(x) ? \(y) = \(result)")
        let userInput = readLine()
        if userInput == random {
            print("You got it baby!")
            calculate()
        } else {
            print("Wrong. Tsk tsk.")
            calculate()
        }
        
        
        
    }
    
}
//calculate function prints first message, creates two empty Doubles. unwraps user response and assigns them to array using components function seperated by a space. operation variable calls mathstufffactory to create operation using components. if operator provided with user response is not equal to operators given it prints an error message. if operator is equal to ? randomGuess function is called. Else if user response first and second number have no value or are valued at zero, user is given an error. Else opperation is called with arguments given in userResponse and prints user calculation with result in a concaphaneted string. User is given option to calculate again.
func calculate() {
    print("Enter a calculation in this format: 5 + 5")
    var x = Double()
    var y = Double()
    let response = readLine()
    let responseUnwrapped = response ?? ""
    var components = responseUnwrapped.components(separatedBy: " ")
    //print(components)
    let operation = mathStuffFactory(opString: components[1])
    if components[1] != "*" && components[1] != "+" && components[1] != "/" && components[1] != "-" && components[1] != "?" {
        print("INVALID OPERATOR")
        if components[1] == "?" {
            randomGuess(x: x, y: y)
        }
    } else {
        //calculate result using closure returned from mathStuffFactory()
        if let firstNumber = Double(components[0]) {
            x = Double(firstNumber)
        } else {
            x = 0.0
            print("INVALID INPUT. ABORT. Just kidding.")
            calculate()
        }
        if let secondNumber = Double(components[2]) {
            y = Double(secondNumber)
        } else {
            y = 0.0
            print("INVALID INPUT. ABORT. Just kidding.")
            calculate()
        }
        let result = operation(x,y)
        
        print("\(responseUnwrapped) = \(result)")
        
        let operand = components[1]
        if operand == "?" {
            randomGuess(x: x, y: y)
        }
    }
    print("Would you like to calculate again? y/n")
    let answer = readLine() ?? ""
    switch answer {
    case "y":
        calculate()
    default:
        print("Self-destruct sequence initiated. Good Bye.")
    }
}

//func firstMenu() {
//    print("Enter type of calculation, 1 (regular) or 2 (high order)")
//    let userInput = readLine() ?? ""
//    switch userInput {
//    case "1" :
//        calculate()
//    case "2":
//        print("I can't do that yet :(")
//        firstMenu()
//    default:
//        firstMenu()
//    }
//}
//Struggling with filter and map for high order functions - will get back to this
calculate()
