//
//  InstantPanGestureRecognizer.swift
//  DualSlider
//
//  Created by  Михаил on 03.03.2025.
//

import UIKit

final class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
}
