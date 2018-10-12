//
//  PaddedTextView.swift
//  StackoverflowSearch
//
//  Created by Josue on 2018/10/12.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class PaddedTextView : UITextView
{
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
