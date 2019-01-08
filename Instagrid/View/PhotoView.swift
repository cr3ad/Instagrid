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
    @IBOutlet weak var MainTopRightView: UIView!
    @IBOutlet weak var MainBottomLeftView: UIView!
    @IBOutlet weak var MainBottomRightView: UIView!
    @IBOutlet weak var BottomLeftImage: UIView!
    @IBOutlet weak var BottomCenterImage: UIView!
    @IBOutlet weak var BottomRightImage: UIView!
    
    
    
    enum Style {
        case left, center, right
    }
    
    var style: Style = .right {
        didSet {
            setStyle(style)
        }
    }
    
    func setStyle(_ style: Style) {
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


