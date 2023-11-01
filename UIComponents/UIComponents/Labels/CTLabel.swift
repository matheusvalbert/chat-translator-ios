//
//  CTUsername.swift
//  UIComponents
//
//  Created by Matheus Valbert on 04/08/23.
//

import UIKit

public class CTLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience public init(text: String = "", numberOfLines: Int, font: UIFont.TextStyle, textColor: UIColor = .label) {
        self.init(frame: .zero)
        set(text: text, numberOfLines: numberOfLines, font: font, textColor: textColor)
    }
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .headline)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func set(text: String, numberOfLines: Int, font: UIFont.TextStyle, textColor: UIColor) {
        self.text = text
        self.numberOfLines = numberOfLines
        self.font = UIFont.preferredFont(forTextStyle: font)
        self.textColor = textColor
    }
    
    public func set(text: String) {
        self.text = text
    }
}
