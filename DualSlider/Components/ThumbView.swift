//
//  ThumbView.swift
//  DualSlider
//
//  Created by  Михаил on 27.02.2025.
//

import UIKit

final class ThumbView: UIView {
    
    private enum Constants {
        static let thumbSize: CGFloat = 28
        static let tapArea: CGFloat = 56
        static let extraSpaceForTap: CGFloat = -(tapArea - thumbSize)
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Constants.thumbSize / 2
        backgroundColor = UIColor.primary
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: Constants.thumbSize),
            heightAnchor.constraint(equalToConstant: Constants.thumbSize),
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        /// Расширенная область
        let extendedBounds = bounds.insetBy(dx: Constants.extraSpaceForTap, dy: Constants.extraSpaceForTap)
        /// Проверяем, внутри ли расширенной зоны
        let isInsideExtended = extendedBounds.contains(point)
        /// Проверяем, внутри ли основной области
        let isInsideOriginal = bounds.contains(point)
        
        /// Если даже в расширенной области нет — отклоняем
        guard isInsideExtended else { return false }
        
        if !isInsideOriginal, let superview = superview {
            for subview in superview.subviews {
                if subview != self, subview.bounds.contains(convert(point, to: subview)) {
                    /// Отдаем приоритет другой UIView, если она в своей основной области
                    return false
                }
            }
        }
        
        return true
    }
}
