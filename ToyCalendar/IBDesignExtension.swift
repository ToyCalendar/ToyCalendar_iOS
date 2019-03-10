//
//  IBDesignExtension.swift
//  ToyCalendar
//
//  Created by 한상준 on 27/02/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation
import UIKit

// UIButton inspector에서 테두리를 컨트롤할 수 있도록 익스텐션 추가
@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
