//
//  CTImageView.swift
//  UIComponents
//
//  Created by Matheus Valbert on 04/08/23.
//

import UIKit

public class CTImageView: UIImageView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(image: UIImage) {
        self.init(frame: .zero)
        set(image: image)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func set(image: UIImage) {
        self.image = image
    }
}
