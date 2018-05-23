
import UIKit

class AddSpendingInputView: UIView
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    // MARK: - TITLE

    @IBOutlet private var titleLabel: UILabel!

    private var _title = ""
    var title: String
    {
        get
        {
            return _title
        }
        set
        {
            _title = newValue
            self.updateTitle()
        }
    }

    private func updateTitle()
    {
        self.titleLabel.text = self.title
    }

    // MARK: - VALUE
    
    @IBOutlet private var valueTextField: UITextField!

    var value: Int
    {
        get
        {
            if
                let text = self.valueTextField.text,
                let val = Int(text)
                {
                    return Int(val)
                }
            else
            {
                return 0
            }
        }
        set
        {
            self.valueTextField.text = String(describing: newValue)
        }
    }
}

