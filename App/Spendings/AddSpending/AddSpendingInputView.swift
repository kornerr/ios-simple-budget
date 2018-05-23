
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

