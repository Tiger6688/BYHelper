//
//  UIImagePickerControllerBlock.swift
//  brandyond
//
//  Created by ysq on 14/12/25.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

import UIKit

private var key : UInt8 = 0

public typealias BYUIImagePickerCompleteBlock = ( (UIImage) -> Void )?

extension UIImagePickerController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    public func showInViewController( vc : UIViewController , finish : BYUIImagePickerCompleteBlock ){
        
        if(finish != nil){
            self.delegate = self
            objc_setAssociatedObject(self, &key, BYClosureWrapper(finish!), UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
        self.allowsEditing = true
        
        self.sourceType = .PhotoLibrary
        vc.presentViewController(self, animated: true, completion: nil)
        
    }
    
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        let image: UIImage? = info[UIImagePickerControllerEditedImage] as? UIImage
        if image != nil{
            var block = objc_getAssociatedObject(self, &key) as? BYClosureWrapper<BYUIImagePickerCompleteBlock>
            block?.call?(image!)
        }
    }
    
}

