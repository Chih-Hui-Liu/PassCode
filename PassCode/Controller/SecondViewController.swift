//
//  SecondViewController.swift
//  PassCode
//
//  Created by Leo on 2020/12/12.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var showText: UITextView!
    @IBOutlet weak var questionText: UITextField!
    @IBOutlet weak var back: UIButton!
    var secondDataPassCode = DataPassCode()
    
    var dataBase = [//二維陣列儲存答案
        ["感情有時候只是一個人的事情。和任何人無關。愛，或者不愛，只能自行了斷。","真正的愛情是專一的，愛情有領域是非常的狹小，它狹到只能容下兩個人生存；如果同時愛上幾個人，那便不能稱偷情，它只是感情上的遊戲。","寂寞對望的靈魂，你是我，而我是你，你不是我，我也不是你。"],
        ["艱苦磨煉意志，逆境造就人才。","人生路上有阻擋你夢想的磚墻，那是有原因的。這些磚墻讓我們來證明我們究竟有多么想要得到我們所需要的。","如果我們想要更多的玫瑰花，就必須種植更多的玫瑰樹。"],
        ["自己不喜歡的人，可以報之以沉默微笑；自己喜歡的人，那就隨便怎么樣了，因為你的喜愛會擋也擋不住地流露出來。","沒有人在生活中能不與別人碰撞。他不得不以各種方式奮力擠過人群，冒犯別人的同時也忍受別人的冒犯。","不要做刺蝟 ，不與人結仇就不與人結仇 ，也不跟誰一輩子 ，些事情沒必要記在心上。"],
    ]
    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        //secondDataPassCode.count = 3
        }
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ifElseButton(_ sender: UIButton) {
        let number = Int.random(in: 0...2)
        if let text = questionText.text{
            if text.contains("愛情"){//字串包含愛情事業人際分別顯示隨機的答案
                showText.text = dataBase[0][number]
            }else if text.contains("事業"){
                showText.text = dataBase[1][number]
            }else if text.contains("人際"){
                showText.text = dataBase[2][number]
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(textShow), userInfo: nil, repeats: true)//重複呼叫function 讓字慢慢浮現
        view.endEditing(true)
    }
    @objc func textShow(){
        showText.alpha += 0.05
        back.alpha += 0.05
    }
    override func viewDidDisappear(_ animated: Bool) {
         // 將timer的執行緒停止
         if self.timer != nil {
              self.timer?.invalidate()
         }
    }
    
}
