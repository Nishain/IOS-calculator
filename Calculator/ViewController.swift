//
//  ViewController.swift
//  Calculator
//
//  Created by user186822 on 1/31/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var buttonGrid: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for row in buttonGrid.subviews{
            for b in row.subviews{
                b.layer.cornerRadius = 7
                let button = (b as? UIButton)
                button?.addTarget( self,action : #selector(buttonClicked(sender:)), for: .touchUpInside)
            }
        }
    }
    func isLastCharacterOperator(sample:String)->Bool{
        return !sample.last!.isNumber
    }
    @objc private func buttonClicked(sender:UIButton){
        let command:String? = sender.titleLabel!.text
        if(command==nil){
            answer.text = "Error"
        }else if(command=="="){
            if(answer.text == ""){
                return
            }
            if(isLastCharacterOperator(sample: answer.text!)){
                answer.text = String(answer.text!.dropLast())
            }
            let value:NSNumber = NSExpression(format:(answer.text!).replacingOccurrences(of: "x", with: "*")) .expressionValue(with: nil, context: nil) as! NSNumber
            answer.text = value.stringValue
        }
        else if(command=="CLS"){
            answer.text = ""
        }else if(command=="BACKSPACE"){
            answer.text = String(answer.text!.dropLast())
        }else{
            if(answer.text=="0" || answer.text==""){
                answer.text = command!
            }else
                if(!command!.last!.isNumber && isLastCharacterOperator(sample: answer.text!)){
                return
            }
            else{
                answer.text! += command!
            }
        }
        
    }


}

