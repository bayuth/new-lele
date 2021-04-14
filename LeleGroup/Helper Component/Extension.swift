//
//  Extension.swift
//  LeleGroup
//
//  Created by Delvina Janice on 07/04/21.
//

import Foundation
import UIKit


extension Double {
   var toString: String {
      return NSNumber(value: self).stringValue
   }
}

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
