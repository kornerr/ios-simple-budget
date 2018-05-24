
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

class AddSpendingVC: UIViewController
{

    // MARK: - SETUP

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupTitle()
        self.setupCancel()
        self.setupSave()
    }


    // MARK: - APPEARANCE

    var appearReport: SimpleCallback?

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        if let report = self.appearReport
        {
            report()
        }
    }

    // MARK: - TITLE

    private func setupTitle()
    {
        self.navigationItem.title = NSLocalizedString("AddSpending.Title", comment: "")
    }

    // MARK: - MAIN VIEW

    var mainView: UIView?
    {
        get
        {
            return self.view.embeddedView
        }

        set
        {
            self.view.embeddedView = newValue
        }
    }

    // MARK: - CANCEL

    var cancelReport: SimpleCallback?

    private func setupCancel()
    {
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self,
                action: #selector(cancel(_:))
            )
    }

    @objc func cancel(_ button: UIBarButtonItem)
    {
        if let report = self.cancelReport
        {
            report()
        }
    }

    // MARK: - SAVE

    var saveReport: SimpleCallback?

    func setSavingEnabled(_ state: Bool)
    {
        self.navigationItem.rightBarButtonItem?.isEnabled = state
    }

    private func setupSave()
    {
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(
                barButtonSystemItem: .save,
                target: self,
                action: #selector(save(_:))
            )
        // Disable saving by default.
        self.setSavingEnabled(false)
    }

    @objc func save(_ button: UIBarButtonItem)
    {
        if let report = self.saveReport
        {
            report()
        }
    }

}

