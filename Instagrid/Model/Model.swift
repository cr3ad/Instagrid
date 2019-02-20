//
//  PhotoEditing.swift
//  Instagrid
//
//  Created by Cr3AD on 16/12/2018.
//  Copyright © 2018 Cr3AD. All rights reserved.
//

import Foundation
import UIKit

let view = ViewController()


class Model {

    enum Style {
        case left, center, right
    }

    enum ViewStatut {
        case incomplete, complete
    }
    // default style
    var style: Style = .left
    
    // default grid
    var images = [UIImage(imageLiteralResourceName: "blueCross"),
                  UIImage(imageLiteralResourceName: "blueCross"),
                  UIImage(imageLiteralResourceName: "blueCross"),
                  UIImage(imageLiteralResourceName: "blueCross")]
    
    // list of images displayed in stackView
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
    
    // switch of viewStatut
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

