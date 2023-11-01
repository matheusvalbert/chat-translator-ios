//
//  UIBarButtonActivityIndicator.swift
//  UIComponents
//
//  Created by Matheus Valbert on 30/10/23.
//

import UIKit

public class UIBarButtonActivityIndicator: UIBarButtonItem {
    
    private let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override init() {
        super.init()
        configure()
    }
    
    private func configure() {
        contentView.addSubview(activityIndicator)
        activityIndicator.center = contentView.center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, style: UIBarButtonItem.Style, target: AnyObject, action: Selector) {
        self.init()
        set(title: title, style: style, target: target, action: action)
    }
    
    private func set(title: String, style: UIBarButtonItem.Style, target: AnyObject, action: Selector) {
        self.title = title
        self.style = style
        self.target = target
        self.action = action
    }
    
    public func startLoading() {
        customView = contentView
        activityIndicator.startAnimating()
    }
    
    public func stopLoading() {
        customView = nil
        activityIndicator.stopAnimating()
    }
}
