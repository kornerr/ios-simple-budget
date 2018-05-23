
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

class AddSpendingView: UIView, UITableViewDataSource, AddSpendingCategoryViewDelegate
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupTableView()
    }

    // MARK: - EDITED ITEM

    var item = SpendingsItem()

    // MARK: - CATEGORIES

    private var _categories = [String]()
    var categories: [String]
    {
        get
        {
            return _categories
        }
        set
        {
            _categories = newValue
            self.tableView.reloadData()
        }
    }

    // MARK: - TABLE VIEW
    
    @IBOutlet private var tableView: UITableView!
    // Use standard row height.
    private let rowHeight: CGFloat = 44
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.rowHeight = self.rowHeight
        self.registerCellInput()
        self.registerCellCategory()
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        // Sections:
        // * input
        // * categories
        return 2
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if (section == 0)
        {
            // Items:
            // * day
            // * sum
            return 2
        }
        // Categories count otherwise.
        return self.categories.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        // Input.
        if (indexPath.section == 0)
        {
            return self.cellInput(at: indexPath)
        }
        // Category.
        return self.cellCategory(at: indexPath)
    }

    // MARK: - INPUT CELL

    private let cellInputId = "CellInputId"
    private typealias CellInputView = AddSpendingInputView
    private typealias CellInput = UITableViewCellTemplate<CellInputView>

    private func registerCellInput()
    {
        self.tableView.register(
            CellInput.self,
            forCellReuseIdentifier: self.cellInputId
        )
    }

    private func cellInput(at indexPath: IndexPath) -> CellInput {
        let cell =
            self.tableView.dequeueReusableCell(
                withIdentifier: self.cellInputId,
                for: indexPath
            )
            as! CellInput
        // 0. Day.
        if (indexPath.row == 0)
        {
            cell.itemView.title = NSLocalizedString("AddSpending.Day", comment: "")
            let calendar = Calendar.current
            let day = calendar.component(.day, from: self.item.date)
            cell.itemView.value = day
        }
        // 1. Sum.
        else
        {
            cell.itemView.title = NSLocalizedString("AddSpending.Sum", comment: "")
            cell.itemView.value = self.item.sum
        }
        // Do not highlight cell selection.
        cell.selectionStyle = .none

        return cell
    }

    // MARK: - CATEGORY CELL

    private let cellCategoryId = "CellCategoryId"
    private typealias CellCategoryView = AddSpendingCategoryView
    private typealias CellCategory = UITableViewCellTemplate<CellCategoryView>

    private func registerCellCategory()
    {
        self.tableView.register(
            CellCategory.self,
            forCellReuseIdentifier: self.cellCategoryId
        )
    }

    private func cellCategory(at indexPath: IndexPath) -> CellCategory {
        let cell =
            self.tableView.dequeueReusableCell(
                withIdentifier: self.cellCategoryId,
                for: indexPath
            )
            as! CellCategory
        
        let category = self.categories[indexPath.row]
        cell.itemView.title = category
        cell.itemView.isSelected = self.isCategorySelected(category)
        cell.itemView.delegate = self

        // Do not highlight cell selection.
        cell.selectionStyle = .none

        return cell
    }

    // MARK: - SELECTED CATEGORIES
    // TODO Consider extracting SelectedCategories model to manage
    // TODO adding/removing/selecting in a separate file, outside the view

    private var _selectedCategories = [String]()
    var selectedCategories: [String]
    {
        get
        {
            return _selectedCategories
        }
        set
        {
            _selectedCategories = newValue
            self.tableView.reloadData()
        }
    }

    private func isCategorySelected(_ category: String) -> Bool
    {
        return self.selectedCategories.contains(where: { $0 == category })
    }

    func selectCategory(_ category: String, state: Bool)
    {
        let isSelected = self.isCategorySelected(category)
        // Deselect.
        if (isSelected && !state)
        {
            // NOTE We access private underscored variable to skip table refresh.
            self._selectedCategories = self.selectedCategories.filter { $0 != category }
        }
        // Select.
        else if (!isSelected && state)
        {
            // NOTE This does not lead to table refresh.
            self.selectedCategories.append(category)
        }

        // DEBUG
        NSLog("selected categories:")
        for category in self.selectedCategories
        {
            NSLog("category '\(category)'")
        }

    }

}

