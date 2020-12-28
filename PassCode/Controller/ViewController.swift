//
//  ViewController.swift
//  PassCode
//
//  Created by Leo on 2020/12/12.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageGuessBG: [UIView]!//用view當背景
    @IBOutlet var guessImage: [UIImageView]!//用image準備當mask view 跟 image都是設為collection
    var dataPassCode = DataPassCode()
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    func initialImage() {
        for i in 0...guessImage.count-1{
            let imageView = UIImageView(image: UIImage(named: "\(dataPassCode.guessImageName[i])"))
            imageView.contentMode = .scaleAspectFill
            imageView.frame = CGRect(x: 0, y: 0, width: 76, height: 76)//本身imageView 的寬高 位置
            let whiteView = UIView(frame: imageView.frame)
            whiteView.backgroundColor = UIColor.white
            imageGuessBG[i].mask = imageView
            imageGuessBG[i].addSubview(whiteView)//顯示還沒按的背景，可加或可不加因為view一開始的背景就是白色
            guessImage[i].isHidden = true //隱藏
           
        }
    }
    func checkPasscode(){
        var string = "剩下\(dataPassCode.count)機會" //用變數儲藏 alert最後一次的時候要改變字串名稱
        var string1 = "再試一次"
        if dataPassCode.guessPasscode == dataPassCode.correctPasscode{//比對答案！！
            initial()
            self.dataPassCode.count = 3 //主要是下一頁回到主頁時重新計算次數
            performSegue(withIdentifier: "correctPasscode", sender: self)
            //顯示算命那一頁
        }else{
            
            if dataPassCode.count == 0{//當最後一次還是按錯更改alert字串
                string = "你慘了！！你沒機會了進懲罰"
                string1 = "懲罰time!"
            }
            let alert = UIAlertController(title: "密碼錯誤", message:string , preferredStyle: .alert)
            let action = UIAlertAction(title:string1, style: .default) { (_) in
                self.initial()//每按一次跟新一開始畫面
                if self.dataPassCode.count >= 1 {
                    self.dataPassCode.count -= 1 //按錯遞減
                }else {
                    self.initial()//主要是下一頁回到主頁時重新計算次數與跟新一開始畫面
                    self.dataPassCode.count = 3
                    self.performSegue(withIdentifier: "faultPasscode", sender: self)
                    
                }
                
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
       // print(dataPassCode.count)
    }
    func initial(){
        //clear guessPassscode
        dataPassCode.guessPasscode  = []//重置陣列
        initialImage()
        
    }
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.tag
        dataPassCode.guessPasscode.append(number)//加入陣列的數字
        let guessIndex = dataPassCode.guessPasscode.count//每按一次陣列count + 1
        guessImage[guessIndex - 1].isHidden = false//第一次按guessIndex ＝1 ，－１是為了符合陣列一開始等於０
        if guessIndex >= 4{//當陣列超過第５個時候馬上比對答案且優先比對
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.checkPasscode()
            }
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        let guessIndex = dataPassCode.guessPasscode.count
        if guessIndex > 0{
            dataPassCode.guessPasscode.remove(at: guessIndex-1)
            guessImage[guessIndex-1].isHidden = true
        }//刪除陣列的值且圖片隱藏
    }
    
    
    
  
}

