//
//  ViewController.swift
//  Instagrid
//
//  Created by Cr3AD on 13/12/2018.
//  Copyright © 2018 Cr3AD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let model = Model()
    var imagePicker = UIImagePickerController()
    var positionImageButton = -1
    let backgroundImage = UIImage(imageLiteralResourceName: "blueCross")
    var deviceOrientation: UIDeviceOrientation {
        let orientation = UIDevice.current.orientation
        return orientation
    }
    var origineCenteViewWidth: CGFloat {
        let width = UIScreen.main.bounds.width / 2
        return width
    }
    var origineCenterViewHeight: CGFloat {
        let height = UIScreen.main.bounds.height / 2
        return height
    }
//    var textSwipeToShare: UILabel {
//        if deviceOrientation == .portrait {
//            return self.swipeToShare.text = " ^ Swipe up to share"
//        } else if deviceOrientation == .landscapeLeft || deviceOrientation == .landscapeRight {
//            return self.swipeToShare.text = " < Swipe left to share"
//        }
//    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        createMainView()
        
    }
 
    // Interface connection //
    
    @IBOutlet weak var mainPhotoGrid: UIView!
    @IBOutlet weak var mainViewTopStackView: UIStackView!
    @IBOutlet weak var mainViewBottomStackView: UIStackView!
    @IBOutlet weak var leftStyleImage: UIButton!
    @IBOutlet weak var centerStyleImage: UIButton!
    @IBOutlet weak var rightStyleImage: UIButton!
    @IBOutlet weak var swipeToShare: UILabel!
    @IBAction func didTapViewLeftMenu(_ sender: Any) {
        refreshBottomStyle()
        if model.style == .left {
            resetImagesToBackground()
        } else {
        model.style = .left
        }
        createMainView()
    }
    @IBAction func didTapViewCenterMenu(_ sender: Any) {
        refreshBottomStyle()
        if model.style == .center {
            resetImagesToBackground()
        } else {
            model.style = .center
        }
        createMainView()
    }
    @IBAction func didTapViewRightMenu(_ sender: Any) {
        refreshBottomStyle()
        if model.style == .right {
            resetImagesToBackground()
        } else {
            model.style = .right
        }
        createMainView()
    }
    @IBAction func photoGridManager(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began, .changed:
            photoGridAnimationManager(gesture: sender)
        case .cancelled, .ended:
            resetGridPosition()
        default:
            break
        }
    }
    
    // Image picker //
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            model.images[positionImageButton] = userImage
            positionImageButton = -1
            createMainView()
        }
        dismiss(animated: true, completion: nil)
    }

    // PhotoGrid's button creation
    func generateButton(onPosition: Int, image: UIImage) -> UIButton {
        let myButton = UIButton()
        myButton.tag = onPosition
        myButton.imageView?.contentMode = .scaleAspectFill
        myButton.setImage(image, for: .normal)
        myButton.backgroundColor = #colorLiteral(red: 0.9410743117, green: 0.9412353635, blue: 0.9410640597, alpha: 1)
        myButton.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
        return myButton
    }
    
    @objc func tapOnButton(sender:UIButton){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        positionImageButton = sender.tag
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    //Mark: Reset Views
    
    // remove the photos to put back the background image
    func resetImagesToBackground() {
        for i in 0...model.images.count - 1 {
            model.images[i] = backgroundImage
        }
    }
    
    // remove the buttons
    func removeStackViews() {
        for view in mainViewTopStackView.subviews {
            view.removeFromSuperview()
        }
        for view in mainViewBottomStackView.subviews {
            view.removeFromSuperview()
        }
    }
    
    // create the main view
    func createMainView() {
        removeStackViews()
        let mainView = model.arrayOfImages
        let top = mainView[0]
        let bottom = mainView[1]
        for image in top.enumerated() {
            mainViewTopStackView.addArrangedSubview(generateButton(onPosition: image.offset, image: image.element))
            
        }
        for image in bottom.enumerated() {
            mainViewBottomStackView.addArrangedSubview(generateButton(onPosition: image.offset + top.count, image: image.element))
        }
        refreshBottomStyle()
    }
    
    // put the photoGrid view in the center of the screen
    func resetGridPosition() {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { self.mainPhotoGrid.transform = .identity },
                       completion: nil)
        createMainView()
        mainPhotoGrid.alpha = 1
    }
    
    // show the selection of the bottom button
    func refreshBottomStyle() {
        resetBottomStyle()
        switch model.style {
        case .left:
            leftStyleImage.isSelected = true
        case .center:
            centerStyleImage.isSelected = true
        case .right:
            rightStyleImage.isSelected = true
        }
    }
    
    // remove the selection mark on the bottom buttons
    func resetBottomStyle() {
        leftStyleImage.isSelected = false
        centerStyleImage.isSelected = false
        rightStyleImage.isSelected = false
    }
    
    // check if the grid is complete
    private func gridIsComplete() -> Bool {
        var gridIsComplete = true
        //        for images in model.arrayOfImages[0] {
        //            if images == UIImage(imageLiteralResourceName: "blueCross") {
        //                gridIsComplete = false
        //            }
        //        }
        //        for images in model.arrayOfImages[1] {
        //            if images == UIImage(imageLiteralResourceName: "blueCross") {
        //                gridIsComplete = false
        //            }
        //        }
        return gridIsComplete
    }
    
    //    Shake the view
    private func shake() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.mainPhotoGrid.transform = CGAffineTransform(translationX: 0, y: 10)
        }, completion: nil)
        resetGridPosition()
    }
    
    //    share photoGrid
    func sharePhotoGrid() {
        
        // renderer UIView to UIImage
        UIGraphicsBeginImageContext(mainPhotoGrid.frame.size)
        mainPhotoGrid.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    // animation manager
    func photoGridAnimationManager(gesture: UIPanGestureRecognizer) {
      
        if gridIsComplete() {
            if deviceOrientation == .portrait {
                let position = mainPhotoGrid.center.y
                let translation = gesture.translation(in: self.view).y
                if let view = gesture.view {
                        view.center = CGPoint(x: view.center.x , y: view.center.y + translation*2)
                }
                
                gesture.velocity(in: self.mainPhotoGrid)
                gesture.setTranslation(CGPoint.zero, in: self.view)
                
                if position <= 0 {
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .transitionFlipFromTop, animations: {
                            self.mainPhotoGrid.transform = CGAffineTransform(translationX: 0, y: -150)
                        }, completion: nil)
                    sharePhotoGrid()
                    mainPhotoGrid.alpha = 0
                    resetGridPosition()
                    
                }
            } else if deviceOrientation == .landscapeRight || deviceOrientation == .landscapeLeft {
                let position = mainPhotoGrid.center.x
                let translation = gesture.translation(in: self.view).x
                if let view = gesture.view {
                    view.center = CGPoint(x: view.center.x  + translation*2 , y: view.center.y)
                }
                
                gesture.velocity(in: self.mainPhotoGrid)
                gesture.setTranslation(CGPoint.zero, in: self.view)
                
                if position <= 0 {
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .transitionFlipFromTop, animations: {
                            self.mainPhotoGrid.transform = CGAffineTransform(translationX: -150, y: 0)
                        }, completion: nil)
                    sharePhotoGrid()
                    mainPhotoGrid.alpha = 0
                    resetGridPosition()
                }
            }
        } else {
            shake()
            
            
        }
        
    }
    
 

    

    
    
 
    
}
