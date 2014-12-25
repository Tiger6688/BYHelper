//
//  BYClosureWrapper.swift
//  brandyond
//
//  Created by ysq on 14/12/25.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

import UIKit


internal class BYClosureWrapper <T> : NSObject {
    
    let _callback : [T]
    
    internal init(_ callback : T ) {
        _callback = [callback]
    }
    
    internal var call : T {
        get{
            return _callback[0]
        }
    }
    
}
