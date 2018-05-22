
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

    private var spendings: Spendings!
    private var spendingsView: SpendingsView!
    private var spendingsVC: SpendingsVC!

    private func setupSpendings()
    {
        // Create data controller.
        self.spendings = Spendings()

        // Create VC.
        self.spendingsView = UIView.loadFromNib()
        self.spendingsVC = SpendingsVC()
        self.spendingsVC.mainView = self.spendingsView
        let nc = UINavigationController(rootViewController: self.spendingsVC)
        self.rootVC = nc

        // Refresh displayed items when they change.
        self.spendings.itemsChanged = { [weak self] in
            guard let this = self else { return }
            this.spendingsView.items = this.spendings.items
        }

        // Setup stub items.
        self.setupStubSpendingsItems()
    }

    private func setupStubSpendingsItems()
    {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!

        var item = SpendingsItem()

        item.date = yesterday
        item.sum = 300
        item.categories = ["Products", "Work"]
        self.spendings.addItem(item)

        item.date = yesterday
        item.sum = 2900
        item.categories = ["Products", "Home"]
        self.spendings.addItem(item)

        item.date = today
        item.sum = 136
        item.categories = ["Products", "Home"]
        self.spendings.addItem(item)

        item.date = today
        item.sum = 56
        item.categories = ["Products", "Work"]
        self.spendings.addItem(item)

        item.date = tomorrow
        item.sum = 14
        item.categories = ["Products", "Work"]
        self.spendings.addItem(item)

        item.date = yesterday
        item.sum = 1515
        item.categories = ["Life", "Fine"]
        self.spendings.addItem(item)

        item.date = yesterday
        item.sum = 23230
        item.categories = ["Life", "Rent"]
        self.spendings.addItem(item)
    }

}

