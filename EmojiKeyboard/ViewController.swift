//
//  ViewController.swift
//  EmojiKeyboard
//
//  Created by 彭豪辉 on 2020/5/16.
//  Copyright © 2020 彭豪辉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 表情键盘视图
    /*
     这个调用的是 无参构造函数，底层是 init()，而 init() 会调用 init(frame:) 这个构造函数
     */
    private lazy var emojiView: EmojiView = EmojiView { [weak self] (emoticon) in
        self?.textView.insertEmoticon(em: emoticon)
    }
    
    
    @IBAction func sendText(_ sender: UIBarButtonItem) {
        print(textView.emoticonText)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        demo()
//        let manager = EmoticonManager.sharedManager
    }

    func demo() {
        // 自定义输入键盘
        textView.inputView = emojiView
        textView.becomeFirstResponder()
        
//        输入的辅助视图
//        textView.inputAccessoryView = UIButton(type: .contactAdd)
    }

    @IBOutlet weak var textView: UITextView!
}

