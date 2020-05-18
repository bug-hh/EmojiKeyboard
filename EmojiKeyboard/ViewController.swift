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
        self?.insertEmoticon(em: emoticon)
    }
    
    private func insertEmoticon(em: Emoticon) {
        print(em)
        // 空白表情
        if em.isEmpty {
            return
        }
        
        // 删除按钮
        if em.isRemoved {
            textView.deleteBackward()
            return
        }
        
        // emoji
        if let emoji = em.emoji {
            textView.replace(textView.selectedTextRange!, withText: emoji)
            return
        }
        
        insertImageEmoticon(em: em)
    }
    
    private func insertImageEmoticon(em: Emoticon) {
        print(em)
        
        // 图片属性文本
        let attachment = NSTextAttachment()
        attachment.image = UIImage(contentsOfFile: em.imagePath)
        // 线高，表示字的高度
        let lineHeight = textView.font!.lineHeight
        // frame = center + bounds * transform
        // bounds(x, y) = contentOffset
        // 当我们要局部设置某个控件的偏移位置时，可以改 bounds 的 x，y
        attachment.bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
        
        // 获得图片文本
        let imageString = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        // 给图片文本设置字体属性
        // NSFontAttributeName 在 UIKit framework 的第一个头文件中
        imageString.addAttribute(NSAttributedString.Key.font, value: textView.font!, range: NSRange(location: 0, length: 1))
        
        // 将 textView 原有内容转换成 可变内容
        let strM = NSMutableAttributedString(attributedString: textView.attributedText)
        
        // 插入图片文本
        strM.replaceCharacters(in: textView.selectedRange, with: imageString)
        
        // 记住光标位置
        let range = textView.selectedRange
        // 替换文本
        textView.attributedText = strM
        // 恢复光标位置
        textView.selectedRange = NSRange(location: range.location + 1, length: 0)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        demo()
        let manager = EmoticonManager.sharedManager
        print(manager)
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

