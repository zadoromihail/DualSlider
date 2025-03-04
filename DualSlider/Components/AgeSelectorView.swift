//
//  AgeSelectorView.swift
//  DualSlider
//
//  Created by  Михаил on 27.02.2025.
//

import UIKit

final class AgeSelectorView: UIView {
    
    // MARK: Constants
    private enum Constants {
        static let height: CGFloat = 104
        static let cornerRadius: CGFloat = 16
        static let baseLabelText = "Предпочтения по возрасту"
    }
    
    // MARK: Private properties
    private var minValue = 0
    private var maxValue = 0
    
    private lazy var dualSlider = DualSliderView()
    
    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var baseTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private lazy var fromLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    private lazy var toLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    
    // MARK: Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: Public methods
    public func configure(_ config: Configuration) {
        dualSlider.configure(config)
        minValue = config.minSliderInitialValue
        maxValue = config.maxSliderInitialValue
        updateUI()
    }
    
    // MARK: Private methods
    private func setupUI() {
        backgroundColor = .white
        heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        layer.cornerRadius = Constants.cornerRadius

        addSubview(labelsStackView)
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        labelsStackView.addArrangedSubview(baseTextLabel)
        labelsStackView.addArrangedSubview(fromLabel)
        labelsStackView.addArrangedSubview(toLabel)
        
        setupBaseTextLabel()
        
        addSubview(dualSlider)
        dualSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dualSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            dualSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dualSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dualSlider.heightAnchor.constraint(equalToConstant: 56)
        ])
        dualSlider.delegate = self
        feedbackGenerator.prepare()
    }
    
    private func setupBaseTextLabel() {
        baseTextLabel.attributedText = Constants.baseLabelText.mediumString()
    }
    
    private func updateUI() {
        fromLabel.attributedText = "от \(minValue)".regularString()
        toLabel.attributedText = "до \(maxValue)".regularString()
    }
}

// MARK: CustomRangeSliderDelegate
extension AgeSelectorView: DualSliderViewDelegate {
    func didChangeValue(_ minValue: CGFloat, _ maxValue: CGFloat) {
        let newMinValue = Int(minValue)
        let newMaxValue = Int(maxValue)

        guard self.minValue != newMinValue || self.maxValue != newMaxValue else { return }

        self.minValue = newMinValue
        self.maxValue = newMaxValue

        updateUI()

        feedbackGenerator.impactOccurred()
    }
}
