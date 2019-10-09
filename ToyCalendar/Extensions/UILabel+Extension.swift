//
//  UILabel+Extension.swift
//  ToyCalendar
//
//  Created by sangdon.kim on 2019/10/09.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

extension UILabel {
    @objc var kern: NSNumber? {
        get {
            var range = NSRange(location: 0, length: text?.count ?? 0)
            guard let kern = attributedText?.attribute(.kern, at: 0, effectiveRange: &range),
                let value = kern as? NSNumber
                else {
                    return 0
            }
            return value
        }
        set(newValue) {
            if let kerningPoint = newValue {
                let mutableText = attributedText?.mutableCopy() as? NSMutableAttributedString ?? NSMutableAttributedString(string: "")
                mutableText.addAttribute(.kern, value: kerningPoint, range: NSRange(location: 0, length: attributedText?.length ?? 0))
                attributedText = mutableText
            }
        }
    }
}
