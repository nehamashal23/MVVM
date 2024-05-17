//
//  ProductCell_TVC.swift
//  MVVM
//
//  Created by SMIT iMac27 on 17/05/24.
//

import UIKit

class ProductCell_TVC: UITableViewCell {
    
    @IBOutlet var productBG_View: UIView!
    @IBOutlet var product_img: UIImageView!
    @IBOutlet var title_lbl: UILabel!
    @IBOutlet var category_lbl: UILabel!
    @IBOutlet var rating_Btn: UIButton!
    @IBOutlet var description_lbl: UILabel!
    @IBOutlet var price_lbl: UILabel!
    
    var product : Product? {
        didSet { // Property Observer (when the value od product change than called didset
            productDetailConfigration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productBG_View.clipsToBounds = false
        productBG_View.layer.cornerRadius = 15
        product_img.layer.cornerRadius = 10
        productBG_View.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfigration(){
        title_lbl.text = product?.title
        category_lbl.text = product?.category
        description_lbl.text = product?.description
        price_lbl.text = "$\(product?.price ?? 0)"
        rating_Btn.setTitle("\(product?.rating.rate ?? 0.0)", for: .normal)
        product_img.setImage(with: product?.image ?? "")
    }
}
