//
//  Configuration.swift
//  DualSlider
//
//  Created by  Михаил on 27.02.2025.
//

import Foundation

struct Configuration {
    /// Минимальное значение поля слайдера
    let minValue: Int
    /// Максимальное  значение поля слайдера
    let maxValue: Int
    /// Начальное положение ползунка с ограничителем минимального значения
    let minSliderInitialValue: Int
    /// Начальное положение ползунка с ограничителем максимального значения
    let maxSliderInitialValue: Int
    
    static let zero = Configuration(minValue: 0, maxValue: 0, minSliderInitialValue: 0, maxSliderInitialValue: 0)
}

