//
//  ProductTableViewCell.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/02.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "ProductTableViewCell"
    
    @IBOutlet weak var productimageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productLocationLabel: UILabel!
    @IBOutlet weak var productTimeLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productLikeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setProductData(_ productData: ProductDataModel) {
        if productData.image != nil {
            productimageView.load(imgURL: productData.image)
        }
        productTitleLabel.text = productData.title
        productLocationLabel.text = productData.region
        productPriceLabel.text = "\(productData.price)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
