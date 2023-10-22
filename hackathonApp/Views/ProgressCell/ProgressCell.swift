//
//  ProgressCell.swift
//  hackathonApp
//
//  Created by Юрий on 22.10.2023.
//

import Foundation
import UIKit
import OneGoLayoutConstraint

final class ProgressCell: UICollectionViewCell {
    
    private let stackView = UIStackView()
    private let checkLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(lastFilled: Int) {
        for i in 0..<3 {
            let view = ProgressView()
            view.configure(
                isFilled: i <= lastFilled,
                text: "Регистрация пользователя",
                number: i
            )
            stackView.addArrangedSubview(view)
        }
    }
    
}

private extension ProgressCell {
    func setup() {
        contentView.addSubview(stackView)
        stackView.pinToSuperView(sides: .topR, .left(20), .right(-20))
        stackView.spacing = 0
        stackView.axis = .horizontal
        
        contentView.addSubview(checkLabel)
        checkLabel.pin(side: .top(32), to: .bottom(stackView))
        checkLabel.pinToSuperView(sides: .left(20), .bottomR, .right(-20))
        checkLabel.text = "Проверьте данные и внесите изменения при необходимости"
        checkLabel.numberOfLines = 0
    }
}
