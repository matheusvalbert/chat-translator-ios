//
//  CTIconButton.swift
//  UIComponents
//
//  Created by Matheus Valbert on 11/08/23.
//

import UIKit

public class CTIconButton: UIButton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(image: UIImage, color: UIColor = Colors.purple) {
        self.init(frame: .zero)
        set(image: image, color: color)
    }
    
    private func configure() {
        configuration = .plain()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(image: UIImage, color: UIColor) {
        configuration?.image = image
        configuration?.baseForegroundColor = color
    }
}
