//
//  addImageSlider.swift
//  Fleber
//
//  Created by haya habbous on 11/3/18.
//  Copyright © 2018 khlaed. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


protocol AddFlebImageSlider {
    func didUserPressedDeleteImage(_ cell: UICollectionViewCell)
}

class addImageSlider: UICollectionViewCell {
    
    var cellDelegate: AddFlebImageSlider?
    @IBOutlet var deleteImage: UIButton!
    @IBOutlet var descButton: UIButton!
    @IBOutlet var descTextField: UITextField!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //img.sd_setShowActivityIndicatorView(true)
        //img.sd_setIndicatorStyle(.gray)
    }
    
    @IBAction func deleteImgAction(_ sender: Any) {
        cellDelegate?.didUserPressedDeleteImage(self)
    }
}
