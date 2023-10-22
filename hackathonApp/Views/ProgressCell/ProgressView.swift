//
//  ProgressView.swift
//  hackathonApp
//
//  Created by Юрий on 22.10.2023.
//

import Foundation
import UIKit
import OneGoLayoutConstraint

final class ProgressView: UIView {
    
    private let circle = UIImageView()
    private let label = UILabel()
    private let numberLabel = UILabel()
    private let line = UIView()
    
    private var isFilled = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isFilled {
            createDottedBorder()
        }
    }
    
    func configure(isFilled: Bool, text: String, number: Int) {
        self.isFilled = isFilled
        if isFilled {
            circle.backgroundColor = .red
            line.backgroundColor = .red
            numberLabel.textColor = .white
        } else {
            numberLabel.textColor = .gray
        }
        line.isHidden = number == 2
        numberLabel.text = "\(number + 1)"
        label.text = text
    }
}

private extension ProgressView {
    func setup() {
        addSubview(circle)
        circle.pinToSuperView(sides: .topR, .leftR)
        circle.setEqualSize(constant: 31)
        circle.layer.cornerRadius = 15.5
        circle.clipsToBounds = true
        
        circle.addSubview(numberLabel)
        numberLabel.pinToSuperView(sides: .centerXR, .centerYR)
        numberLabel.textAlignment = .center
        numberLabel.font = .systemFont(ofSize: 10, weight: .bold)
        
        addSubview(line)
        line.pin(side: .leftR, to: .right(circle))
        line.pinToSuperView(sides: .rightR)
        line.setDemission(.height(1))
        line.setDemission(.width(99))
        line.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true
        
        addSubview(label)
        label.pin(side: .top(8), to: .bottom(circle))
        label.pinToSuperView(sides: .leftR, .bottomR)
        label.setDemission(.width(69))
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 2
        label.textColor = .black
    }
    
    func createDottedBorder() {
        circle.image = #imageLiteral(resourceName: "Ellipse")
        let shapeLayer = CAShapeLayer()
        let color = #colorLiteral(red: 0.5780992508, green: 0.64701581, blue: 0.7541982532, alpha: 1)
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [1.5, 2] // 7 is the length of dash, 3 is length of the gap.
        
        let path = CGMutablePath()
        let start = CGPoint(x: line.bounds.minX, y: line.bounds.minY)
        let end = CGPoint(x: line.bounds.maxX, y: line.bounds.minY)
        path.addLines(between: [start, end])
        shapeLayer.path = path
        line.layer.addSublayer(shapeLayer)
    }
}
