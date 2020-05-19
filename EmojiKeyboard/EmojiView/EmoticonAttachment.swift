//
//  EmoticonAttachment.swift
//  EmojiKeyboard
//
//  Created by bughh on 2020/5/19.
//  Copyright © 2020 彭豪辉. All rights reserved.
//

import UIKit

class EmoticonAttachment: NSTextAttachment {
    var emoticon: Emoticon
    
    init(emoticon: Emoticon) {
        self.emoticon = emoticon
        super.init(data: nil, ofType: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
