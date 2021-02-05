//
//  ViewController.swift
//  Calculator
//
//  Created by user186822 on 1/31/21.
//

import UIKit

class ViewController: UIViewController {

    
        @IBOutlet weak var buttonGrid: UIStackView!
    @IBOutlet weak var answer: UILabel!
    let regexExpression = "[\\+\\-x\\/^]{2}|(\\)\\()|([\\+\\-x\\/^]\\))$"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for row in buttonGrid.subviews{
            for b in row.subviews{
                b.layer.cornerRadius = 10
                let button = (b as? UIButton)
                button?.addTarget( self,action : #selector(buttonClicked(sender:)), for: .touchUpInside)
            }
        }
    }
    func isLastCharacterOperator(sample:String)->Bool{
        return !sample.last!.isNumber
    }
    func isLastCharacterBracket(sample:String)->Bool{
        return sample.last! == "(" || sample.last! == ")"
    }
    let bracketWarning = "brackets are not closed properly"
    func validate(a:Character,b:Character)->Bool{
        if(a==")" && b=="("){
            return false
        }
        if(a=="(" && b==")"){
            return false
        }
        if("+-x/^".contains(a) && b==")"){
            return false
        }
        if("+-x/^".contains(a) && "+-x/^".contains(b)){
            return false
        }
        if((a==")" && b.isNumber) || (b=="(" && a.isNumber)){
            return false
        }
        return true
    }
    @objc private func buttonClicked(sender:UIButton){
        
        let command:String? = sender.titleLabel!.text
        if(command==nil){
            answer.text = "Error"
        }else if(command=="="){
            if(answer.text == ""){
                return
            }
            var balance = 0
            for s in answer.text! {
                if(s=="("){
                    balance += 1
                }else if(s==")"){
                    balance -= 1
                    if(balance<0){
                        answer.text = bracketWarning
                        return
                    }
                }
            }
            if(balance != 0){
                answer.text = bracketWarning
                return
            }
            if(!isLastCharacterBracket(sample: answer.text!) && isLastCharacterOperator(sample: answer.text!)){
                answer.text = String(answer.text!.dropLast())
            }
            let expression = (answer.text!)
            .replacingOccurrences(of: "x", with: "*")
            .replacingOccurrences(of: "^", with: "**")
                .replacingOccurrences(of: "/", with: "/1.0/")
          
            print(expression)
            let value:NSNumber = NSExpression(format:expression)
                    .expressionValue(with: nil, context: nil) as! NSNumber
                answer.text = value.stringValue
        }
        
        else if(command=="CLR"){
            answer.text = ""
        }else if(command=="DEL"){
            if(answer.text==bracketWarning){
                answer.text = ""
                return
            }
            answer.text = String(answer.text!.dropLast())
        }else{
            if(answer.text=="0" || answer.text=="" || answer.text==bracketWarning){
                if(command!.first!.isNumber){
                    answer.text = command!
                }
            }else if(!validate(a: answer.text!.last!, b: command!.last!)){
                    return
                }
                else{
                    answer.text! += command!
                }
        }
        
    }


}

