//
//  CTScrollViewController.swift
//  UIComponents
//
//  Created by Matheus Valbert on 14/08/23.
//

import UIKit

open class CTScrollViewController: UIViewController {
    
    public let scrollView = UIScrollView()
    public let contentView = UIView()

    open override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
    }
    
    private func configureViewController() {
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        scrollView.alwaysBounceVertical = true
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 500),
        ])
    }
}
