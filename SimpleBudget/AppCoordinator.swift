
import UIKit

class AppCoordinator
{

    // MARK: - SETUP

    var rootVC: UIViewController!
    var rootVCChanged: SimpleCallback?

    init()
    {
        self.setupMainVC()
    }

    // MARK: - MAIN VC

    private var mainVC: MainVC!

    private func setupMainVC()
    {
        self.mainVC = MainVC()
        let nc = UINavigationController(rootViewController: self.mainVC)
        self.rootVC = nc
    }

}

