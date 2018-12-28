//
//  PhotoView.swift
//  Instagrid
//
//  Created by Cr3AD on 16/12/2018.
//  Copyright © 2018 Cr3AD. All rights reserved.
//

import UIKit

class PhotoView: UIView {
   
    @IBOutlet weak var MainTopLeftView: PhotoView!
    @IBOutlet weak var MainTopRightView: PhotoView!
    @IBOutlet weak var MainBottomLeftView: PhotoView!
    @IBOutlet weak var MainBottomRightView: PhotoView!
    @IBOutlet weak var BottomLeftImage: UIImageView!
    @IBOutlet weak var BottomCenterImage: UIImageView!
    @IBOutlet weak var BottomRightImage: UIImageView!
    
    
    enum Style {
        case left, center, right
    }
    
    var style: Style = .right {
        didSet {
            setStyle(style)
        }
    }
    
    private func setStyle(_ style: Style) {
        switch style {
        case .left:
            MainTopLeftView.isHidden = false
            MainTopRightView.isHidden = true
            MainBottomLeftView.isHidden = false
            MainBottomRightView.isHidden = false
            BottomLeftImage.alpha = 0.4
            BottomCenterImage.alpha = 1
            BottomRightImage.alpha = 1
        case .center:
            MainTopLeftView.isHidden = false
            MainTopRightView.isHidden = true
            MainBottomLeftView.isHidden = false
            MainBottomRightView.isHidden = true
            BottomLeftImage.alpha = 1
            BottomCenterImage.alpha = 0.4
            BottomRightImage.alpha = 1
        case .right:
            MainTopLeftView.isHidden = false
            MainTopRightView.isHidden = false
            MainBottomLeftView.isHidden = false
            MainBottomRightView.isHidden = false
            BottomLeftImage.alpha = 1
            BottomCenterImage.alpha = 1
            BottomRightImage.alpha = 0.4
        }
    }
}


