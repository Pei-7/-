//
//  ViewController.swift
//  心理測驗
//
//  Created by 陳佩琪 on 2023/4/29.
//

import UIKit
import AVFAudio

class ViewController: UIViewController , UITextViewDelegate {
    
    let speaker = AVSpeechSynthesizer()

    @IBOutlet weak var segmentedControlBar: UISegmentedControl!
    
    //view 1
    @IBOutlet weak var upperTitle: UILabel!
    
    @IBOutlet weak var word1: UIButton!
    
    @IBOutlet weak var word2: UIButton!
    
    @IBOutlet weak var word3: UIButton!
    
    @IBOutlet weak var word4: UIButton!
    
    @IBOutlet weak var semiFunctionButton: UIButton!
    
    @IBOutlet weak var mainFunctionButton: UIButton!
    
    @IBOutlet weak var inputSentence: UITextView!
    
    //view 2
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var resultTextView: UITextView!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var resetAllButton: UIButton!
    
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var explanationTextview: UITextView!
    
    //view 3
    
    @IBOutlet weak var view3: UIView!
    
    
    var word1String = ["我","我","我","我"]
    var word2String = ["橋","天氣","馬","鮮花"]
    var word3String = ["兔子","窗戶","草原","城堡"]
    var word4String = ["鑰匙","衣服","帳篷","王子"]
    
    
    var changeWord1String = ["我","我","我","我"]
    var changeWord2String = ["人生路","情緒","野心","愛情"]
    var changeWord3String = ["伴侶","內心","自由","歸宿"]
    var changeWord4String = ["財富","社交","舒適區","權力"]
    
    var index = 0
    
    
    var explanationString = ["句子當中的單字我即是「本人」，鑰匙指代「財富」，兔子指代「伴侶」、橋指代「人生」。\n\n你的造句可以看出你潛意識中對於財富及伴侶的態度、並暗示他們什麼時間點會出現。","句子當中的單字我即是「本人」，天氣是「情緒」，窗戶指代「內心」、衣服指代「社交」。\n\n你的造句可以看出你當前狀態的情感投射。","句子當中的單字我即是「本人」，馬指代「野心」，草原指代「自由」、蒙古包指代「舒適區」。\n\n你的造句可以看出你對於野心的態度以及對成功的預感。","句子當中的單字我即是「本人」，鮮花指代「愛情」，城堡指代「歸宿」、王子指代「權力」。\n\n你的造句可以看出你潛意識中對於歸宿的定義以及對權力及愛情的看法。"]
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //keyboard dismiss when press return
        inputSentence.delegate = self
        
        //segmented control
        segmentedControlBar.setTitle("1", forSegmentAt: 0)
        segmentedControlBar.setTitle("2", forSegmentAt: 1)
        segmentedControlBar.setTitle("3", forSegmentAt: 2)
        segmentedControlBar.setTitle("4", forSegmentAt: 3)
        segmentedControlBar.backgroundColor = UIColor(red: 250/255, green: 246/255, blue: 215/255, alpha: 1)
        segmentedControlBar.selectedSegmentTintColor = UIColor(red: 244/255, green: 156/255, blue: 32/255, alpha:0.8)
        segmentedControlBar.tintColor = UIColor.white
        
        //view1
        
        //add word 1-4 buttons
        
        word1.setTitle(word1String[index], for: .normal)
        word2.setTitle(word2String[index], for: .normal)
        word3.setTitle(word3String[index], for: .normal)
        word4.setTitle(word4String[index], for: .normal)
        
        // redo & submit
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .small)
        semiFunctionButton.setImage(UIImage(systemName: "arrow.uturn.backward", withConfiguration: symbolConfiguration), for: .normal)
        semiFunctionButton.layer.cornerRadius = 20
        semiFunctionButton.clipsToBounds = true
        
        
        mainFunctionButton.setTitle("送出", for: .normal)
        mainFunctionButton.layer.cornerRadius = 20
        mainFunctionButton.clipsToBounds = true
        
        //view2
        
        //explanation
        explanationTextview.text = explanationString[index]
        explanationTextview.font = UIFont(name: "Helvetica", size: 16)
        

        
        
        // share & reset
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up", withConfiguration: symbolConfiguration), for: .normal)
        shareButton.layer.cornerRadius = 20
        shareButton.clipsToBounds = true
        
        
        resetAllButton.setTitle("重測", for: .normal)
        resetAllButton.layer.cornerRadius = 20
        resetAllButton.clipsToBounds = true
        
        view2.isHidden = true
        
        }

    func updateIndex() {
        index = segmentedControlBar.selectedSegmentIndex
    }
    
    @IBAction func changeWord1(_ sender: Any) {
        updateIndex()
        inputSentence.insertText(word1String[index])
        word1.isEnabled = false
    }
    
    @IBAction func changeWord2(_ sender: Any) {
        updateIndex()
        inputSentence.insertText(word2String[index])
        word2.isEnabled = false
    }
    
    @IBAction func changeWord3(_ sender: Any) {
        updateIndex()
        inputSentence.insertText(word3String[index])
        word3.isEnabled = false
    }
    
    @IBAction func changeWord4(_ sender: Any) {
        updateIndex()
        inputSentence.insertText(word4String[index])
        word4.isEnabled = false
    }
    
    
    //submit or again
    @IBAction func mainFunction(_ sender: Any) {
    }
    
    //redo or share
    func redo() {
        inputSentence.text = ""
        word1.isEnabled = true
        word2.isEnabled = true
        word3.isEnabled = true
        word4.isEnabled = true
    }
    
    @IBAction func semiFunction(_ sender: Any) {
        redo()
    }
    
    //點擊 enter 收回鍵盤
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
   
    @IBAction func submitResult(_ sender: Any) {
        
        updateIndex()
        
        resultTextView.text = inputSentence.text.replacingOccurrences(of: word1String[index], with: changeWord1String[index]).replacingOccurrences(of: word2String[index], with: changeWord2String[index]).replacingOccurrences(of: word3String[index], with: changeWord3String[index]).replacingOccurrences(of: word4String[index], with: changeWord4String[index])
        
        explanationTextview.text = explanationString[index]

        view2.isHidden = false

    }
    
    
    @IBAction func resetToView1(_ sender: Any) {
        view2.isHidden = true
        resultTextView.text = ""
        redo()
    }
    
    
    
    //切換頁面
    @IBAction func switchSegment(_ sender: Any) {
        updateIndex()
    
        word1.setTitle(word1String[index], for: .normal)
        word2.setTitle(word2String[index], for: .normal)
        word3.setTitle(word3String[index], for: .normal)
        word4.setTitle(word4String[index], for: .normal)
        
        view2.isHidden = true
        resultTextView.text = ""
        redo()
        
    }
    
    

    //發音
    @IBAction func audiolizeSentence(_ sender: Any) {
        //audiolize
        updateIndex()
        let audioSentence = AVSpeechUtterance(string: resultTextView.text)
        audioSentence.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        speaker.speak(audioSentence)
    }
    
    @IBAction func shareTheSentence(_ sender: Any) {
        // activityItems 陣列中放入我們想要使用的元件，這邊我們放入使用者圖片、使用者名稱及個人部落格。
        // 這邊因為我們確認裡面有值，所以使用驚嘆號強制解包。
        
        let activityVC = UIActivityViewController(activityItems: [resultTextView.text!], applicationActivities: nil)
        // 顯示出我們的 activityVC。
        self.present(activityVC, animated: true, completion: nil)
        
    }
}

