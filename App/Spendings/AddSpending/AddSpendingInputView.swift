
import UIKit

protocol AddSpendingInputViewDelegate
{

    func setInput(key: String, value: Int)

}

class AddSpendingInputView: UIView
{

    // MARK: - SETUP

    var delegate: AddSpendingInputViewDelegate?


    CONTINUE should cells delegate at all??? Doesn't this break parent-child relationship?
    CONTINUE think about it, this looks terribly wrong

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

