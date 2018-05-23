
import UIKit

protocol AddSpendingCategoryViewDelegate
{
    func selectCategory(_ category: String, state: Bool)
}

class AddSpendingCategoryView: UIView
{

    // MARK: - SETUP

    var delegate: AddSpendingCategoryViewDelegate?

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupSelection()
    }

    // MARK: - TITLE

    @IBOutlet private var titleLabel: UILabel!

    var title: String
    {
        get
        {
            return self.titleLabel.text ?? ""
        }
        set
        {
            self.titleLabel.text = newValue
        }
    }

    // MARK: - SELECTION

    @IBOutlet private var checkmarkView: UIView!
    @IBOutlet private var selectionButton: UIButton!

    private var _isSelected = false
    var isSelected: Bool
    {
        get
        {
            return _isSelected
        }
        set
        {
            _isSelected = newValue
            self.updateSelection()
        }

    }

    private func setupSelection()
    {
        // Create internal UITableViewCell to display selection checkmark.
        let checkmark = UITableViewCell()
        checkmark.frame = self.checkmarkView.bounds
        checkmark.accessoryType = .checkmark
        self.checkmarkView.embeddedView = checkmark

        // Diselect by default.
        self.isSelected = false
    }

    private func updateSelection()
    {
        self.checkmarkView.isHidden = !self.isSelected
    }
    
    @IBAction func toggleSelection(_ sender: Any)
    {
        self.isSelected = !self.isSelected
        if let delegate = self.delegate
        {
            delegate.selectCategory(self.title, state: self.isSelected)
        }
    }
    
}

