//
//  Coordinator.swift
//  ChatTranslator
//
//  Created by Matheus Valbert on 02/08/23.
//

import UIKit

public protocol Coordinator {

    var childCoordinators: [Coordinator] { get set }

    init(navigationController: UINavigationController)

    func start()
}
