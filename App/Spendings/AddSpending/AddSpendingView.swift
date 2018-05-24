
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

class AddSpendingView:
    UIView,
    UITableViewDataSource,
    AddSpendingCategoryViewDelegate,
    AddSpendingInputViewDelegate
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupTableView()
    }

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

        cell.itemView.delegate = self
        // Do not highlight cell selection.
        cell.selectionStyle = .none

        // 0. Day.
        if (indexPath.row == 0)
        {
            cell.itemView.id = "Day"
            cell.itemView.title = NSLocalizedString("AddSpending.Day", comment: "")
            let calendar = Calendar.current
            let day = calendar.component(.day, from: self.item.date)
            cell.itemView.value = day
        }
        // 1. Sum.
        else
        {
            cell.itemView.id = "Sum"
            cell.itemView.title = NSLocalizedString("AddSpending.Sum", comment: "")
            cell.itemView.value = self.item.sum

            // Mark this input view as focusable one.
            self.focusableInputView = cell.itemView
        }

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
        cell.itemView.isSelected = self.item.hasCategory(category)
        cell.itemView.delegate = self

        // Do not highlight cell selection.
        cell.selectionStyle = .none

        return cell
    }

    // MARK: - EDITED ITEM

    var item = SpendingsItem()

    func selectCategory(_ category: String, state: Bool)
    {
        let isSelected = self.item.hasCategory(category)
        // Deselect.
        if (isSelected && !state)
        {
            self.item.removeCategory(category)
        }
        // Select.
        else if (!isSelected && state)
        {
            self.item.addCategory(category)
        }

        // TODO REMOVE after testing
        NSLog("selected categories:")
        for category in self.item.categories
        {
            NSLog("category '\(category)'")
        }
    }

    func setInputValue(_ value: Int, forId id: String)
    {
        // TODO REMOVE after testing
        NSLog("setInputValue '\(value)' for id '\(id)'")

        if (id == "Day")
        {
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.item.date)
            components.day = value
            if let date = calendar.date(from: components)
            {
                self.item.date = date
            }
            else
            {
                // TODO Introduce log instance/protocol to report errors upwards.
                // TODO Restrict max day value during input or simply use picker to select day
                NSLog("AddSpendingView. ERROR: could not change item's date")
            }
        }
        else if (id == "Sum")
        {
            self.item.sum = value
        }
    }

    // MARK: - FOCUSABLE INPUT VIEW

    private weak var focusableInputView: AddSpendingInputView?

    func focusIntoFocusableInputView()
    {
        self.focusableInputView?.focus()
    }

}

