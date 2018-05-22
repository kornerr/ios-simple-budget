
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

class SpendingsView: UIView, UITableViewDataSource
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupTableView()
    }

    // MARK: - ITEMS

    private var _items = [SpendingsItem]()
    var items: [SpendingsItem]
    {
        get
        {
            return _items
        }
        set
        {
            _items = newValue
            self.updateItems()
        }
    }

    private func updateItems()
    {
        NSLog("updateItems")
        self.tableView.reloadData()
    }

    // MARK: - TABLE VIEW
    

    @IBOutlet private var tableView: UITableView!
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.register(
            CellSpendingsItem.self,
            forCellReuseIdentifier: CellSpendingsItemId
        )
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.items.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = self.cellSpendingsItem(at: indexPath)
        return cell
    }

    // MARK: - SPENDINGS ITEM CELL

    private let CellSpendingsItemId = "CellSpendingsId"
    private typealias CellSpendingsItemView = SpendingsItemView
    private typealias CellSpendingsItem = UITableViewCellTemplate<CellSpendingsItemView>

    private func cellSpendingsItem(at indexPath: IndexPath) -> CellSpendingsItem {
        let cell =
            self.tableView.dequeueReusableCell(
                withIdentifier: CellSpendingsItemId,
                for: indexPath
            )
            as! CellSpendingsItem

        let item = self.items[indexPath.row]

        // Day.
        let calendar = Calendar.current
        let day = calendar.component(.day, from: item.date)
        cell.itemView.setDay(day)
        // Sum.
        cell.itemView.setSum(item.sum)
        // Categories.
        cell.itemView.setCategories(item.categories)

        return cell
    }

}

