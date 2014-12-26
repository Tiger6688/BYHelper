//
//  BYArrayExt.swift
//  brandyond
//
//  Created by ysq on 14/12/26.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

import UIKit

extension Array{
    
    func contains<T : Equatable>(obj: T) -> Bool {
        let filtered = self.filter {$0 as? T == obj}
        
        return filtered.count > 0
    }
    
    //移除匹配的第一个元素
    mutating func remove<T : Equatable>(obj : T){
        for (index,element) in enumerate(self){
            if element as? T == obj{
                self.removeAtIndex(index)
                break
            }
        }
    }
    
}


