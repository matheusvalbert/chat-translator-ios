//
//  CTButton.swift
//  UIComponents
//
//  Created by Matheus Valbert on 02/08/23.
//

import UIKit

public class CTButton: UIButton {

    final var image: UIImage?
    final var text: String?
    let activityIndicator = UIActivityIndicatorView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(title: String, image: UIImage? = nil, style: UIButton.Configuration = UIButton.Configuration.filled(), activityIndicatorStyle: UIActivityIndicatorView.Style = .large, customTextColor: UIColor? = nil) {
        self.init(frame: .zero)
        set(title: title, image: image, style: style, activityIndicatorStyle: activityIndicatorStyle, customTextColor: customTextColor)
    }
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
        configureActivityIndicator()
    }
    
    private func set(title: String, image: UIImage?, style: UIButton.Configuration, activityIndicatorStyle: UIActivityIndicatorView.Style, customTextColor: UIColor?) {
        self.image = image
        self.text = title
        configuration = style
        configuration?.baseBackgroundColor = Colors.purple
        let buttonColor = style == .filled() ? .white : Colors.purple
        configuration?.baseForegroundColor = customTextColor == nil ? buttonColor : customTextColor
        configuration?.title = self.text
        configuration?.image = self.image
        activityIndicator.style = activityIndicatorStyle
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    public func startLoading() {
        configuration?.image = nil
        configuration?.title = " "
        activityIndicator.startAnimating()
    }
    
    public func stopLoading() {
        configuration?.image = image
        configuration?.title = text
        activityIndicator.stopAnimating()
    }
    
    public func enable() {
        isEnabled = true
    }
    
    public func disable() {
        isEnabled = false
    }
}
