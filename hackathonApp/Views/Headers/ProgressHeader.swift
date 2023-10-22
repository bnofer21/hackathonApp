//
//  ProgressHeader.swift
//  hackathonApp
//
//  Created by Юрий on 22.10.2023.
//

import Foundation
import UIKit
import OneGoLayoutConstraint

final class ProgressHeader: UICollectionReusableView {
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.pinToSuperView(sides: .top(58), .left(20), .right(-20), .bottom(-23))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(text: String, font: UIFont, color: UIColor) {
        label.text = text
        label.font = font
        label.textColor = color
    }
}
