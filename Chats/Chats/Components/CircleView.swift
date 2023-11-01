//
//  CircleView.swift
//  Chats
//
//  Created by Matheus Valbert on 10/10/23.
//

import UIKit
import UIComponents

class CircleNumberView: UIView {
    private let circleLayer = CAShapeLayer()
    private let numberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        circleLayer.fillColor = Colors.purple.cgColor
        circleLayer.strokeColor = Colors.purple.cgColor
        layer.addSublayer(circleLayer)
        
        numberLabel.textAlignment = .center
        numberLabel.textColor = .white
        numberLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
    }
    
    func set(number: Int) {
        if number >= 100 {
            circleLayer.lineWidth = 14
            numberLabel.text = "99+"
        } else if number >= 10 {
            circleLayer.lineWidth = 10
            numberLabel.text = String(number)
        } else {
            circleLayer.lineWidth = 5
            numberLabel.text = String(number)
        }
    }
}
