//
//  RegisterField.swift
//  hackathonApp
//
//  Created by Юрий on 22.10.2023.
//

import Foundation
import UIKit
import OneGoLayoutConstraint

final class RegisterField: UIView {
    
    private let label = UILabel()
    private let icon = UIButton()
    private let field = UITextField()
    private let errorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(type: FieldType) {
        field.placeholder = type.placeholder
        label.text = type.placeholder
        icon.isHidden = !type.needHelp
    }
    
    private func setup() {
        addSubview(label)
        label.pinToSuperView(sides: .topR, .leftR)
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        addSubview(icon)
        icon.setEqualSize(constant: 16)
        icon.pinToSuperView(sides: .topR, .rightR)
        let image = #imageLiteral(resourceName: "question")
        icon.setImage(image, for: .normal)
        
        let stack = UIStackView(arrangedSubviews: [field, errorLabel])
        addSubview(stack)
        stack.pin(side: .top(6), to: .bottom(label))
        stack.pinToSuperView(sides: .leftR, .rightR, .bottomR)
        
        field.setDemission(.height(51))
        field.layer.cornerRadius = 12
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 1
        field.leftView = UIView(frame: .init(x: 0, y: 0, width: 16, height: 0))
        field.leftViewMode = .always
        
        errorLabel.textColor = .red
        errorLabel.font = .systemFont(ofSize: 9, weight: .regular)
        errorLabel.isHidden = true
        errorLabel.numberOfLines = 0
    }
}
