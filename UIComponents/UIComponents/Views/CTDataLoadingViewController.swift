//
//  CTDataLoadingViewController.swift
//  UIComponents
//
//  Created by Matheus Valbert on 03/11/23.
//

import UIKit

public class CTDataLoadingViewController: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
