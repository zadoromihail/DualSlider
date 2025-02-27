//
//  String+Extensions.swift
//  DualSlider
//
//  Created by  Михаил on 27.02.2025.
//

import UIKit

public extension String {
    func regularString() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.minimumLineHeight = 16
        paragraphStyle.maximumLineHeight = 16

        let attributeString = NSMutableAttributedString(string: self, attributes: [
            .font: UIFont.custom(.regular, size: 16),
            .paragraphStyle: paragraphStyle
        ])
        return attributeString
    }
    
    func mediumString() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.minimumLineHeight = 20
        paragraphStyle.maximumLineHeight = 20

        let attributeString = NSMutableAttributedString(string: self, attributes: [
            .font: UIFont.custom(.medium, size: 16),
            .paragraphStyle: paragraphStyle
        ])
        return attributeString
    }
}


