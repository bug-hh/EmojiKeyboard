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
    private lazy var emojiView: EmojiView = EmojiView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        demo()
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

