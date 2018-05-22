
import UIKit

class SpendingsItemView: UIView
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupSum()
    }

    // MARK: - HEIGHT

    /*

    NOTE Height of 60 is used by TableView by default,
    NOTE so no need to do anything.

    class func height() -> Float
    {
        return 60
    }
    */
    
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
    
    func setSum(_ sum: Float)
    {
        self.sumLabel.text = String(describing: Int(sum))
    }
    
    // MARK: - CATEGORIES

    @IBOutlet private var categoriesLabel: UILabel!
    
    func setCategories(_ categories: [String])
    {
        let categoriesString = categories.joined(separator: ", ")
        self.categoriesLabel.text = categoriesString
    }

}

