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

    enum ViewStatut {
        case incomplete, complete
    }

    var style: Style = .left
    var images = [UIImage(imageLiteralResourceName: "blueCross"),
                  UIImage(imageLiteralResourceName: "blueCross"),
                  UIImage(imageLiteralResourceName: "blueCross"),
                  UIImage(imageLiteralResourceName: "blueCross")]
    
    
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
    
    var viewStatut: ViewStatut = .incomplete
    var mainImageViewStatut: ViewStatut {
    switch viewStatut {
    case .incomplete:
        break
    case .complete:
        break
    }
        return viewStatut
    }
    
}

