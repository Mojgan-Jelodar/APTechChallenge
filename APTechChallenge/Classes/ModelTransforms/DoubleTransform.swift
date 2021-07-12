//
//  File.swift
//  APTechChallenge
//
//  Created by m.jelodar on 12/26/19.
//  Copyright © 2019 m.jelodar. All rights reserved.
//

import Foundation
import ObjectMapper
open class DoubleTransform: TransformType {
    public typealias Object = NSNumber
    public typealias JSON = String
    public init() {}
    open func transformFromJSON(_ value: Any?) -> NSNumber? {
        if let val = value as? String,let double = Double(val) {
            return NSNumber(value: double)
        }
        return nil
    }
    open func transformToJSON(_ value: NSNumber?) -> String? {
        if let number = value {
            return number.stringValue
        }
        return nil
    }
}
