//
//  CTTextField.swift
//  UIComponents
//
//  Created by Matheus Valbert on 30/07/23.
//

import UIKit

public class CTTitle: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience public init(title: String) {
        self.init(frame: .zero)
        text = title
    }
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textColor = Colors.purple
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
}
