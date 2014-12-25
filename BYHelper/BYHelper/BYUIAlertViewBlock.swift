//
//  UIAlertViewBlock.swift
//  brandyond
//
//  Created by ysq on 14/12/25.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

import UIKit

private var key : UInt8 = 0

public typealias BYAlertCompleteBlock = ( ( NSInteger) -> Void )?

extension UIAlertView : UIAlertViewDelegate{
    
    public func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        var block = objc_getAssociatedObject(self, &key) as? BYClosureWrapper<BYAlertCompleteBlock>
        block?.call?(buttonIndex)
    }
    
    public func show(finish : BYAlertCompleteBlock){
        
        if finish != nil{
            self.delegate = self
            objc_setAssociatedObject(self, &key, BYClosureWrapper(finish!), UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC));
        }
        self.show()
        
    }
    
}

