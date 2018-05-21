
/*
This file is part of ios-simple-budget:
    http://github.com/kornerr/ios-simple-budget

Copyright (C) 2018 Michael Kapelko <kornerr@gmail.com>

This software is provided 'as-is', without any express or implied
warranty.  In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
*/

import UIKit

class SpendingsCoordinator
{

    // MARK: - SETUP

    var rootVC: UIViewController!
    var rootVCChanged: SimpleCallback?

    init()
    {
        self.setupSpendings()
    }

    // MARK: - SPENDINGS

    private var spendingsView: SpendingsView!

    private func setupSpendings()
    {
        self.spendingsView = UIView.loadFromNib()
        let vc = UIViewControllerTemplate<SpendingsView>(mainView: self.spendingsView)
        vc.title = NSLocalizedString("Spendings.Title", comment: "")
        let nc = UINavigationController(rootViewController: vc)
        self.rootVC = nc
    }

}

