//
//  ViewController.swift
//  DualSlider
//
//  Created by  Михаил on 26.02.2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .lightGray
        let ageSelectorView = AgeSelectorView()
        view.addSubview(ageSelectorView)
        ageSelectorView.translatesAutoresizingMaskIntoConstraints = false
        ageSelectorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        ageSelectorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        ageSelectorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ageSelectorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let configuration = Configuration(minValue: 14, maxValue: 80, minSliderInitialValue: 30, maxSliderInitialValue: 40)
        ageSelectorView.configure(configuration)
    }
}
