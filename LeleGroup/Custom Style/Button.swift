//
//  Style.swift
//  LeleGroup
//
//  Created by Patya Pindo on 08/04/21.
//

import Foundation
import UIKit

class roundedButton: UIButton {
    
    open override func draw(_ rect: CGRect) {
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
    }
}
