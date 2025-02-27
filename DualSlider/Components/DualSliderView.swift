//
//  DualSliderView.swift
//  DualSlider
//
//  Created by  Михаил on 27.02.2025.
//

import UIKit

protocol DualSliderViewDelegate: AnyObject {
    func didChangeValue(_ minValue: CGFloat, _ maxValue: CGFloat)
}

final class DualSliderView: UIControl {

    // MARK: Private properties
    private let trackLayer = CALayer()
    private let segmentView = UIView()

    /// Ползунки
    private let minThumb = ThumbView()
    private let maxThumb = ThumbView()
    
    private var configuration: Configuration = .zero

    private var minThumbCenterX: CGFloat = 0.0
    private var maxThumbCenterX: CGFloat = 0.0
    
    private var lastMinValue: CGFloat = 0
    private var lastMaxValue: CGFloat = 0
    
    /// Массив возможных значений (если значения будут начинаться не с 0)
    private var valuesArray = [Int]()

    private var startTouchPoint: CGPoint?
    private var activeThumb: UIView?
    
    /// Флаг, отвечающий за начальную настройку UI
    private var isViewPrepared = false
    
    private var thumbSize: CGFloat {
        minThumb.bounds.width
    }

    weak var delegate: DualSliderViewDelegate?
    
    // MARK: Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isViewPrepared {
            prepareUI()
            isViewPrepared = true
        }

        updateUI()
    }
    
    // MARK: Public methods
    public func configure(_ config: Configuration) {
        self.configuration = config
        self.lastMaxValue = CGFloat(config.maxSliderInitialValue)
        self.lastMinValue = CGFloat(config.minSliderInitialValue)
        self.valuesArray = Array(configuration.minValue...configuration.maxValue)
    }

    // MARK: Private methods
    private func setupUI() {
        trackLayer.backgroundColor = UIColor.secondary.cgColor
        layer.addSublayer(trackLayer)

        addSubview(segmentView)
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.backgroundColor = UIColor.primary

        setupThumb(minThumb)
        setupThumb(maxThumb)
    }

    private func setupThumb(_ thumb: UIView) {
        addSubview(thumb)
        thumb.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
    }
    
    private func prepareUI() {
        let fullWidth = bounds.width - thumbSize
        let point = fullWidth / CGFloat(configuration.maxValue - configuration.minValue)

        if let index = valuesArray.firstIndex(of: configuration.minSliderInitialValue) {
            minThumbCenterX = point * CGFloat(index)
        }
        
        if let index = valuesArray.firstIndex(of: configuration.maxSliderInitialValue) {
            maxThumbCenterX = point * CGFloat(index)
        }
    }
    
    private func calculateChanges(in thumb: Thumb) {
        /// Если оба ползунка указывают одно значение
        let isOnePoint = abs(maxThumbCenterX - minThumbCenterX) == thumbSize

        switch thumb {
        case .min:
            let point = (maxThumbCenterX - thumbSize) / (lastMaxValue - CGFloat(configuration.minValue))
            let value = minThumbCenterX / point
            if let safeValue = valuesArray[safe: Int(value)] {
                lastMinValue = isOnePoint ? lastMaxValue : CGFloat(safeValue)
            }
            
        case .max:
            let fullWidth = bounds.width - thumbSize
            let point = (fullWidth - minThumbCenterX - thumbSize) / (CGFloat(configuration.maxValue) - lastMinValue)
            let value = abs(((fullWidth - maxThumbCenterX) / point) - (CGFloat(configuration.maxValue) - lastMinValue)) + lastMinValue
            lastMaxValue = isOnePoint ? lastMinValue : value
        }
    }

    private func updateUI() {
        let trackHeight: CGFloat = 2
        trackLayer.frame = CGRect(x: 0, y: bounds.midY - trackHeight / 2, width: bounds.width, height: trackHeight)
        trackLayer.cornerRadius = trackHeight / 2

        minThumb.frame = CGRect(x: minThumbCenterX, y: bounds.midY - thumbSize / 2, width: thumbSize, height: thumbSize)
        maxThumb.frame = CGRect(x: maxThumbCenterX, y: bounds.midY - thumbSize / 2, width: thumbSize, height: thumbSize)
        
        let segmentLayerWidth = maxThumbCenterX - minThumbCenterX
        segmentView.frame = CGRect(x: minThumbCenterX, y: bounds.midY - trackHeight / 2, width: segmentLayerWidth, height: trackHeight)
        segmentView.layer.cornerRadius = trackHeight / 2
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: self)

        switch gesture.state {
        case .began:
            startTouchPoint = touchPoint
            /// Запоминаем активный ползунок
            activeThumb = gesture.view

        case .changed:
            guard let _ = startTouchPoint,
                  let _ = activeThumb else {
                return
            }

            var newX = touchPoint.x

            if gesture.view == minThumb {
                newX = max(newX, 0)
                newX = min(newX, maxThumbCenterX - thumbSize)
                minThumbCenterX = newX
                calculateChanges(in: .min)
            } else if gesture.view == maxThumb {
                newX = min(newX, bounds.width - thumbSize)
                newX = max(newX, minThumbCenterX + thumbSize)
                maxThumbCenterX = newX
                calculateChanges(in: .max)
            }

            delegate?.didChangeValue(lastMinValue, lastMaxValue)
            setNeedsLayout()

        case .ended, .cancelled:
            startTouchPoint = nil
            activeThumb = nil

        default:
            break
        }
    }
}

extension DualSliderView {
    private enum Thumb {
        case min
        case max
    }
}
