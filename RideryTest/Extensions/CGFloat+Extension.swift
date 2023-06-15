//
//  CGFloat+Extension.swift
//  RideryTest
//
//  Created by LuisGuerra on 15/6/23.
//

import Foundation

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
