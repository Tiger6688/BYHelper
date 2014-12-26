//
//  BYUIActionSheetBlock.swift
//  brandyond
//
//  Created by ysq on 14/12/26.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

import UIKit

private var key : UInt8 = 0

public typealias BYActionSheetCompleteBlock = ( ( NSInteger) -> Void )?

extension UIActionSheet : UIActionSheetDelegate{
    
    private var __block : BYClosureWrapper<BYActionSheetCompleteBlock>? {
        get{
            return objc_getAssociatedObject(self, &key) as? BYClosureWrapper<BYActionSheetCompleteBlock>
        }
        set{
            objc_setAssociatedObject(self, &key, newValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC));
        }
    }
    
    public func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        self.__block?.call?(buttonIndex)
    }
    
    public func showInView(view: UIView! , finish : BYActionSheetCompleteBlock){
        
        if finish != nil{
            self.delegate = self
            self.__block = BYClosureWrapper(finish)
        }
        self.showInView(view)
        
    }
    
}
