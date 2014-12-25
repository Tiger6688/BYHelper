//
//  BYDelay.swift
//  brandyond
//
//  Created by ysq on 14/12/22.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

import UIKit

public typealias BYTask = (cancel : Bool) -> ()

/**
延迟执行

:param: time 时间
:param: task 任务

:returns: 任务实例
*/
public func delay(time:NSTimeInterval, task:()->()) -> BYTask? {
    
    func dispatch_later(block:()->()) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
    }
    
    //GCD 和延时调用
    var closure: dispatch_block_t? = task
    var result: BYTask?
    
    let delayedClosure: BYTask = { cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                dispatch_async(dispatch_get_main_queue(), internalClosure);
            }
        }
        closure = nil
        result = nil
    }

    result = delayedClosure
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(cancel: false)
        }
    }
    return result
}
/**
取消一个任务实例

:param: task 任务实例
*/
public func cancel(task:BYTask?) {
    task?(cancel: true)
}

