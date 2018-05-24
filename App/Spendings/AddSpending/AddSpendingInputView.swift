
import UIKit

protocol AddSpendingInputViewDelegate
{
    func setInputValue(_ value: Int, forId id: String)
}

class AddSpendingInputView: UIView
{

    // MARK: - SETUP

    var delegate: AddSpendingInputViewDelegate?

    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    // MARK: - ID

    // Used for delegation.
    var id: String = "Undefined"

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
    
    @IBAction func valueTextChanged(_ sender: Any)
    {
        self.delegate?.setInputValue(self.value, forId: self.id)
    }

    // MARK: - FOCUS

    func focus()
    {
        self.valueTextField.becomeFirstResponder()
        // Select all text.
        self.valueTextField.selectAll(nil)
    }
    
}

