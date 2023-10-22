//
//  RegisterCell.swift
//  hackathonApp
//
//  Created by Юрий on 22.10.2023.
//

import Foundation
import UIKit
import OneGoLayoutConstraint

final class RegisterCell: UICollectionViewCell {
    
    private let infoToast = ToastView()
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(fieldTypes: [FieldType]) {
        configureStack(types: fieldTypes)
    }
    
}

private extension RegisterCell {
    func setup() {
        contentView.addSubview(infoToast)
        infoToast.pinToSuperView(sides: .topR, .left(20), .right(-20))
        infoToast.setDemission(.height(100))
        infoToast.configure(type: .info(.info))
        
        contentView.addSubview(stackView)
        stackView.pin(side: .top(26), to: .bottom(infoToast))
        stackView.pinToSuperView(sides: .left(20), .right(-20), .bottom(-20))
        stackView.axis = .vertical
        stackView.spacing = 16
    }
    
    func configureStack(types: [FieldType]) {
        for i in 0..<types.count {
            let view = RegisterField()
            view.configure(type: types[i])
            view.setDemission(.height(73))
            stackView.addArrangedSubview(view)
        }
    }
}
