//
//  ToastView.swift
//  hackathonApp
//
//  Created by Юрий on 22.10.2023.
//

import Foundation
import UIKit
import OneGoLayoutConstraint

final class ToastView: UIView {
    
    private let progressView = UIProgressView()
    private let icon = UIImageView()
    private let mainlabel = UILabel()
    private let subLabel = UILabel()
    
    private var leftConstaint: NSLayoutConstraint?
    
    private lazy var stackView = UIStackView(arrangedSubviews: [progressView, mainlabel, subLabel])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        guard !progressView.isHidden else { return }
        startProgress()
    }
    
    func configure(type: ToastType) {
        if type.isIconHidden {
            icon.isHidden = true
            progressView.isHidden = false
            progressView.progressTintColor = type.infoType.progressColor
            leftConstaint = stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
            leftConstaint?.isActive = true
        } else {
            icon.isHidden = false
            progressView.isHidden = true
            icon.image = type.infoType.icon
            leftConstaint = stackView.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 12)
            leftConstaint?.isActive = true
        }
        setNeedsLayout()
        mainlabel.text = type.infoType.mainText
        subLabel.text = type.infoType.subText
        backgroundColor = type.infoType.backgroundColor
        layer.borderColor = type.infoType.borderColor.cgColor
    }
    
    private func setup() {
        layer.borderWidth = 1
        layer.cornerRadius = 12
        
        addSubview(icon)
        icon.setEqualSize(constant: 20)
        icon.pinToSuperView(sides: .top(16), .left(16))
        
        addSubview(stackView)
        stackView.pinToSuperView(sides: .top(16), .right(-16))
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.setCustomSpacing(8, after: mainlabel)
        
        progressView.setDemission(.height(3))
        progressView.setDemission(.width(321))
        progressView.layer.cornerRadius = 1.5
        progressView.progress = 1.0
        progressView.trackTintColor = .clear
        
        mainlabel.textColor = .black
        mainlabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        subLabel.textColor = .black
        subLabel.font = .systemFont(ofSize: 12, weight: .regular)
        subLabel.numberOfLines = 2
    }
    
    private func startProgress() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let progress = self.progressView.progress - 0.02
            self.progressView.setProgress(progress, animated: true)
        }
    }
}
