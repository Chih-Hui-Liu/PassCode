//
//  ThirdViewController.swift
//  PassCode
//
//  Created by Leo on 2020/12/12.
//

import UIKit

class ThirdViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var changeImage: UIImageView!
    @IBOutlet weak var answerUitextView: UITextView!
    @IBOutlet weak var guessCount: UILabel!
    @IBOutlet weak var backButtonShow: UIButton!
    var correct = ""
    var countGuess = 0
    var thirdDataPassCode = DataPassCode()
    override func viewDidLoad() {
        super.viewDidLoad()
        //thirdDataPassCode.count = 3
        numberTextField.delegate = self
        backButtonShow.isHidden = true
    }
    @IBAction func compareButton(_ sender: UIButton) {
        if let number = numberTextField.text{
            if number.count == 4 {
                compare()
                reclean()
            }else{//少於４位數 會通知需要補
                let alert = UIAlertController(title: "安安你好", message: "請輸入四位數歐 啾咪！", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
        }
        view.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func compare(){
        var a = 0 , b = 0
        var numberString = [Int]()//儲存舊的數字
        for  i in numberTextField.text!{//數入答案
            thirdDataPassCode.guessPasscode.append(Int("\(i)")!)//這邊直接用！是因為在按compareButton已經用if let 判斷裡面是會有數字的
            numberString.append(Int("\(i)")!)
        }
        for i in 0...3{//比對陣列的答案雙for來逐一比對！！這不懂可以上網看２為陣列的９＊9表
            if thirdDataPassCode.guessPasscode[i] == thirdDataPassCode.correctPasscode[i]{
                a+=1
            }
            for j in 0...3{
               if thirdDataPassCode.guessPasscode[i] == thirdDataPassCode.correctPasscode[j]{
                    b+=1
                }
            }
        }
        correct = "\(a)A\(b)B"//存進比對後的數字
       
        if a == 4 {
            countGuess += 1
            answerUitextView.text! = "恭喜答對！！！正確為\(thirdDataPassCode.correctPasscode)"
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                self.answerUitextView.text! = ""
                self.countGuess = 0
            }//主要讓"恭喜答對！！！正確為"持續３秒後然後再清除畫面
           
            backButtonShow.isHidden = false
        }else{
            answerUitextView.text! += "\(numberString)" + ":" + correct + "\n"
            countGuess += 1
            guessCount.text = "目前猜第\(countGuess)次"
        }//使用UITextView 持續增加字串且用"/n"當換行件
        
           
        
        
    }
    func reclean(){
        thirdDataPassCode.guessPasscode = [Int]()
        numberTextField.text = ""
    }
    
    //delegate 讓字母限制在４個字以內
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 4
    }
    
}
