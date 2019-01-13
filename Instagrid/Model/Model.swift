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

    var setStyle: Style = .left
    
    var images = [UIImage(), UIImage(), UIImage(), UIImage()]
    
    var arrayOfImages: [[UIImage]] {
        switch setStyle {
        case .left:
            view.leftStyleImage.alpha = 0.4
            view.centerStyleImage.alpha = 1
            view.rightStyleImage.alpha = 1
            return [ [images[0]            ] ,
                     [images[1], images[2] ] ]
            
        case .center:
            view.leftStyleImage.alpha = 1
            view.centerStyleImage.alpha = 0.4
            view.rightStyleImage.alpha = 1
            return [ [images[0], images[1] ] ,
                     [images[2]            ] ]
        case .right:
            view.leftStyleImage.alpha = 1
            view.centerStyleImage.alpha = 1
            view.rightStyleImage.alpha = 0.4
            return [ [images[0], images[1] ] ,
                     [images[2], images[3] ] ]
        }
    }
}
