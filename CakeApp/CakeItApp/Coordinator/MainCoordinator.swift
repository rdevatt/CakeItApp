//  Created by Roy DeVatt on 06/25/21.

import Foundation
import UIKit

protocol Coordinator:AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    func goToCakeDetails(cakeDetails: (title: String,
                                     desc: String,
                                     imageStr: String))
}

class MainCoordinator: Coordinator {
    
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CakeListViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = CakeListViewModel(delegate:vc)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToCakeDetails(cakeDetails: (title: String, desc: String, imageStr: String)) {
        let vc = CakeDetailViewController.instantiate()
        vc.viewModel = CakeDetailsViewModel(cakeDetails: cakeDetails)
        navigationController.pushViewController(vc, animated: false)
    }
}
