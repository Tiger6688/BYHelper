//
//  BYAlertViewController.swift
//  brandyond
//
//  Created by ysq on 14/12/26.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

import UIKit

let DeviceVersion  =   (UIDevice.currentDevice().systemVersion as NSString).floatValue
let IOS7 = ( DeviceVersion >= 7 && DeviceVersion < 8 )

public typealias BYAlertControllerCancelAction = (()->())?
public typealias BYAlertControllerOtherAction = ((NSInteger)->())?

public class BYAlertController: NSObject {
   
    private var cancelAction : BYAlertControllerCancelAction
    private var otherAction : BYAlertControllerOtherAction
    
    private var alert : UIAlertView?
    private var sheet : UIActionSheet?
    private var alertController : UIAlertController?
    
    private var preferredStyle : UIAlertControllerStyle = .Alert
    
    public init( title : String? , message : String?  ,preferredStyle : UIAlertControllerStyle , cancelButtonTitle : String? , otherButtonTitles : String? , _ moreButtonTitles : String?...) {
        
        super.init()
        
        self.preferredStyle = preferredStyle
        
        var otherTitles : [String] = []
        if otherButtonTitles != nil { otherTitles.append(otherButtonTitles!) }
        for t in moreButtonTitles{
            otherTitles.append(t!)
        }
        
        if IOS7{
            
            self.setupInIOS7(title: title, message: message, preferredStyle: preferredStyle, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: otherTitles)
            
        }else{
            
            self.setupInIOS7After(title, message: message, preferredStyle: preferredStyle, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: otherTitles)
        }
        
    }
    
    private func setupInIOS7(title : String? = "" , message : String? = ""  ,preferredStyle : UIAlertControllerStyle , cancelButtonTitle : String? = "" , otherButtonTitles : [String] ){
        
        if preferredStyle == .Alert{
            alert = UIAlertView(title: title!, message: message!, delegate: nil, cancelButtonTitle: cancelButtonTitle)
            
            for t in otherButtonTitles{
                alert!.addButtonWithTitle(t)
            }
            
        }else{
            
            sheet = UIActionSheet(title: title, delegate: nil, cancelButtonTitle: cancelButtonTitle, destructiveButtonTitle: nil)
            
            for t in otherButtonTitles{
                sheet!.addButtonWithTitle(t)
            }
        }
        
    }
    
    private func setupInIOS7After(title : String? , message : String?  ,preferredStyle : UIAlertControllerStyle , cancelButtonTitle : String? , otherButtonTitles : [String] ){
        
        alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if cancelButtonTitle != nil{
            var cancel = UIAlertAction(title: cancelButtonTitle!, style: .Cancel, handler: {(_) -> Void in
                self.cancelAction?()
                return
            })
            alertController?.addAction(cancel)
        }
        for (index,t) in enumerate(otherButtonTitles){
            var other = UIAlertAction(title: t, style: .Default, handler: { (_) -> Void in
                self.otherAction?(index)
                return
            })
            alertController?.addAction(other)
        }
        
    }
    
    public func showAlertViewInViewController( vc : UIViewController? ,clickedCancelButton: BYAlertControllerCancelAction , clickedOtherButtonAtIndex : BYAlertControllerOtherAction  ){
        
        self.cancelAction = clickedCancelButton
        self.otherAction = clickedOtherButtonAtIndex
        
        if IOS7{
            if self.preferredStyle == .Alert{

                self.alert?.show({(index) -> Void in
                    if index == self.alert!.cancelButtonIndex {
                        self.cancelAction?()
                    }else{
                        self.otherAction?(index - self.alert!.cancelButtonIndex - 1)
                    }
                })
                
            }else{
                self.sheet?.showInView(vc?.view, finish: {(index) -> Void in
                    if index == self.sheet!.cancelButtonIndex{
                        self.cancelAction?()
                    }else{
                        self.otherAction?(index - self.sheet!.cancelButtonIndex - 1)
                    }
                })
            }
        }else{
            vc?.presentViewController(self.alertController!, animated: true, completion: nil)
        }
        
    }
    
}
