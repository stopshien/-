//
//  ViewController.swift
//  終極密碼
//
//  Created by stopshien on 2022/7/7.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var num1Label: UILabel!
    
    @IBOutlet weak var num2Label: UILabel!
    
    @IBOutlet weak var myNumView: UILabel!
    
    @IBOutlet weak var txtGuess: UITextField!
    
    @IBOutlet weak var decideButtonView: UIButton!
    
    @IBOutlet weak var BoomImage: UIImageView!
    
    var insideGuessNum = Int.random(in: 2...99)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myNumView.text = "0"
        num1Label.text = "1"
        num2Label.text = "100"
        progressView.progress = 0
        ButtonSet()
        txtGuess.resignFirstResponder()
        
        
        BoomImage.isHidden = true
        addDoneBtn()
    }
    
    //點擊空白處收合鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func ButtonSet(){
        
//        decideButtonView.tintColor = .white
//        decideButtonView.backgroundColor = .black
//        decideButtonView.layer.cornerRadius = 20
    }
 
    
    @IBAction func decideButton(_ sender: Any) {
    
        if txtGuess.text != "" {
            //先設定一個變數為txtGuess的Int才能夠與隱藏數字做比較
            let nowNumber : Int = Int(txtGuess.text!)!
            //將label區間的數字轉換成Int才有辦法做比較
            let num1 : Int = Int(num1Label.text!)!
            let num2 : Int = Int(num2Label.text!)!
            if nowNumber > num1 && nowNumber < num2{
               
            myNumView.text = txtGuess.text
            
            
            if insideGuessNum > nowNumber{
                num1Label.text = txtGuess.text
            progressView.progress = 1 - (Float(abs(num2 - nowNumber)) / 100)
                txtGuess.text = ""
            }else if insideGuessNum < nowNumber{
                num2Label.text = txtGuess.text
            progressView.progress = 1 - (Float(abs(nowNumber - num1)) / 100)
                txtGuess.text = ""
            }else{
                
                myNumView.text = "Boom!"
                BoomImage.isHidden = false
                progressView.progress = 1
                self.decideButtonView.isEnabled = false
                txtGuess.text = ""
            }

            }
        }
      
    }
    @IBAction func againButton(_ sender: Any) {
        myNumView.text = "0"
        insideGuessNum = Int.random(in: 2...99)
        num1Label.text = "1"
        num2Label.text = "100"
        myNumView.text = "0"
        progressView.progress = 0
        BoomImage.isHidden = true
        decideButtonView.isEnabled = true
    }
    
  

    func addDoneBtn() {
        
        let toolBar = UIToolbar()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,
                                      target: self,
                                      action: #selector(doneBtnPressed))
        // push done btn to right   不加的話Button會在toobar左邊
        let flexibeSpace = UIBarButtonItem(
                                     barButtonSystemItem:.flexibleSpace,
                                     target: nil,
                                     action: nil)
        toolBar.sizeToFit() //如果沒加這行toolBar不會出來，DoneBtn也不能按
        toolBar.setItems([flexibeSpace,doneBtn], animated: false)
        txtGuess.inputAccessoryView = toolBar
    }
   @objc func doneBtnPressed() {
            view.endEditing(true)
        }
}

//extension ViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else { return true }
//        // text為目前textField的字串，string為使用者輸入字串，newLength為使用者按下數字後整個字串新的長度
//        let newLength = text.count + string.count
//        // 當newLength不超過二字元時，回傳true，更新textField字串
//        if newLength <= 2 {
//            return true
//        // 反之若是newLength超過二字元時，則回傳false，無論使用者按了什麼按鈕都不會更新textField
//        } else {
//            return false
//        }
//    }
//}
