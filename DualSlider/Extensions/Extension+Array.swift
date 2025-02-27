//
//  Extension+Array.swift
//  DualSlider
//
//  Created by  Михаил on 27.02.2025.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
