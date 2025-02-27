//
//  UIFont+Extensions.swift
//  DualSlider
//
//  Created by  Михаил on 27.02.2025.
//

import UIKit

public extension UIFont {
    enum CustomFont: String {
        case regular = "SFProDisplay-Regular"
        case medium = "SFProDisplay-Medium"
    }
    
    static func custom(_ font: CustomFont, size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
