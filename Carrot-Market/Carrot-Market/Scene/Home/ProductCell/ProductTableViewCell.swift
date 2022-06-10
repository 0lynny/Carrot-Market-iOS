//
//  ProductTableViewCell.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/02.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "ProductTableViewCell"
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productLocationLabel: UILabel!
    @IBOutlet weak var productTimeLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productLikeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Functions
    func setProductData(_ productData: ProductDataModel) {
        if productData.image != nil {
            productImageView.setImage(productData.image)
        }
        productTitleLabel.text = productData.title
        productLocationLabel.text = productData.region
        productTimeLabel.text = productData.createdAt
        productPriceLabel.text = "\(numberFormatter(Int(productData.price)))원"
    }

    func numberFormatter(_ number: Int)->String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: number)!
    }
}
