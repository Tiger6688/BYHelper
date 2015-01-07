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
    
    
    private var __block : BYClosureWrapper<BYUIImagePickerCompleteBlock>? {
        get{
            return objc_getAssociatedObject(self, &key) as? BYClosureWrapper<BYUIImagePickerCompleteBlock>
        }
        set{
            objc_setAssociatedObject(self, &key, newValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC));
        }
    }
    
    public func showInViewController( vc : UIViewController , finish : BYUIImagePickerCompleteBlock ){
        
        if(finish != nil){
            self.delegate = self
            self.__block = BYClosureWrapper(finish)
        }
        self.allowsEditing = true
        
        var sheet = BYAlertController(title: "选择图片", message: nil, preferredStyle: .ActionSheet, cancelButtonTitle: "取消", otherButtonTitles: "拍照","相册")
        sheet.showAlertViewInViewController(vc, clickedCancelButton: nil) { (index) -> () in
            
            var sourceType : UIImagePickerControllerSourceType = .PhotoLibrary
            
            switch(index){
            case 0:
                sourceType = .Camera
            default:
                sourceType = .PhotoLibrary
            }
            
            self.sourceType = sourceType
            vc.presentViewController(self, animated: true, completion: nil)
            
        }
        
    }
    
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        let image: UIImage? = info[UIImagePickerControllerEditedImage] as? UIImage
        if image != nil{
            self.__block?.call?(image!)
        }
    }
    
}


