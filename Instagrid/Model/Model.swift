//
//  PhotoEditing.swift
//  Instagrid
//
//  Created by Cr3AD on 16/12/2018.
//  Copyright © 2018 Cr3AD. All rights reserved.
//

import Foundation
import UIKit


// style image et sauvegarde des image

let view = ViewController()

class Model {

    enum Style {
        case left, center, right
    }
    enum BottomStyle {
        case left, center, right
    }

    var style: Style = .left
    var images = [UIImage(), UIImage(), UIImage(), UIImage()]
    
    var arrayOfImages: [[UIImage]] {
        switch style {
        case .left:
            
            return [ [images[0]            ] ,
                     [images[1], images[2] ] ]
        case .center:
            
            return [ [images[0], images[1] ] ,
                     [images[2]            ] ]
        case .right:
            
            return [ [images[0], images[1] ] ,
                     [images[2], images[3] ] ]
        }
    }
    
}

