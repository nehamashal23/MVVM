//
//  UIImage + Extension.swift
//  MVVM
//
//  Created by SMIT iMac27 on 17/05/24.
//

import UIKit
import Kingfisher


extension UIImageView {
   
    func setImage(with urlString: String) {
      guard let url = URL(string: urlString) else {
        return
      }
        kf.indicatorType = .activity
        kf.setImage(with: url)

    }

}

