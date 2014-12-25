//
//  BYClosureWrapper.swift
//  brandyond
//
//  Created by ysq on 14/12/25.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

import UIKit


public class BYClosureWrapper <T> : NSObject {
    
    let _callback : [T]
    
    public init(_ callback : T ) {
        _callback = [callback]
    }
    
    public var call : T {
        get{
            return _callback[0]
        }
    }
    
}
