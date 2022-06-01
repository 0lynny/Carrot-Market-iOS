//
//  NSobject+.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/02.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
