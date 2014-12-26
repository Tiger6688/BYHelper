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
    
    private var __block : BYClosureWrapper<BYAlertCompleteBlock>? {
        get{
            return objc_getAssociatedObject(self, &key) as? BYClosureWrapper<BYAlertCompleteBlock>
        }
        set{
            objc_setAssociatedObject(self, &key, newValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC));
        }
    }
    
    public func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.__block?.call?(buttonIndex)
    }
    
    public func show(finish : BYAlertCompleteBlock){
        
        if finish != nil{
            self.delegate = self
            self.__block = BYClosureWrapper(finish)
        }
        self.show()
        
    }
    
}
