
import UIKit

class SpendingsItemView: UIView
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupSum()
    }

    // MARK: - DAY

    @IBOutlet private var dayLabel: UILabel!
    
    func setDay(_ day: Int)
    {
        self.dayLabel.text = String(describing: day)
    }

    // MARK: - SUM

    @IBOutlet private var sumLabel: UILabel!

    private func setupSum()
    {
        // TODO Set bold font.
        //self.dayLabel.font = .tbWishlistSizesItem
    }
    
    func setSum(_ sum: Int)
    {
        self.sumLabel.text = String(describing: sum)
    }
    
    // MARK: - CATEGORIES

    @IBOutlet private var categoriesLabel: UILabel!
    
    func setCategories(_ categories: [String])
    {
        let categoriesString = categories.joined(separator: ", ")
        self.categoriesLabel.text = categoriesString
    }

}

