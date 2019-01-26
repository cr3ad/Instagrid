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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        resetMainView()
    }
 
    @IBOutlet weak var mainPhotoView: UIView!
    @IBOutlet weak var mainViewTopStackView: UIStackView!
    @IBOutlet weak var mainViewBottomStackView: UIStackView!
    @IBOutlet weak var leftStyleImage: UIButton!
    @IBOutlet weak var centerStyleImage: UIButton!
    @IBOutlet weak var rightStyleImage: UIButton!
    
    @IBAction func didTapViewLeftMenu(_ sender: Any) {
        applyBottomStyle()
        if model.style == .left {
            resetImages()
        } else {
        model.style = .left
        }
        resetMainView()
    }
    @IBAction func didTapViewCenterMenu(_ sender: Any) {
        applyBottomStyle()
        if model.style == .center {
            resetImages()
        } else {
            model.style = .center
        }
        resetMainView()
    }
    @IBAction func didTapViewRightMenu(_ sender: Any) {
        applyBottomStyle()
        if model.style == .right {
            resetImages()
        } else {
            model.style = .right
        }
        resetMainView()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            model.images[positionImageButton] = userImage
            positionImageButton = -1
            resetMainView()
        }
        dismiss(animated: true, completion: nil)
    }

    //Mark: Button generation

    func generateButton(onPosition: Int, image: UIImage) -> UIButton {
        
        let myButton = UIButton()
        myButton.tag = onPosition
        //myButton.contentMode = .scaleAspectFit
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
    
    func resetImages() {
        for i in 0...model.images.count - 1 {
            model.images[i] = backgroundImage
        }
    }
    
    func resetStackViews() {
        for view in mainViewTopStackView.subviews {
            view.removeFromSuperview()
        }
        for view in mainViewBottomStackView.subviews {
            view.removeFromSuperview()
        }
    }
    
    func resetMainView() {
        resetStackViews()
        let mainView = model.arrayOfImages
        let top = mainView[0]
        let bottom = mainView[1]
        for image in top.enumerated() {
            mainViewTopStackView.addArrangedSubview(generateButton(onPosition: image.offset, image: image.element))
            
        }
        for image in bottom.enumerated() {
            mainViewBottomStackView.addArrangedSubview(generateButton(onPosition: image.offset + top.count, image: image.element))
        }
        applyBottomStyle()
    }
    
    func resetBottomStyle() {
        leftStyleImage.isSelected = false
        centerStyleImage.isSelected = false
        rightStyleImage.isSelected = false
    }
    
    func applyBottomStyle() {
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
    
    //Mark: Gesture
    
    @IBAction func mainViewGesture(_ sender: UIPanGestureRecognizer) {
      
        switch sender.state {

            
        case .began, .changed:
            photoGridAnimationManager(gesture: sender)
            
            
        case .cancelled, .ended:
            backToOriginalPosition()
            
            
        default:
            break
        }
    }
    
    
    // animate imageGrid
    
    private func photoGridAnimationManager(gesture: UIPanGestureRecognizer) {
        shake()
        let position = mainPhotoView.center.y
        let translation = gesture.translation(in: self.view).y
        
        
        if gridIsComplete() {
            if let view = gesture.view {
                view.center = CGPoint(x: view.center.x ,
                                      y: view.center.y + translation*2)
            }
            
            gesture.velocity(in: self.mainPhotoView)
            gesture.setTranslation(CGPoint.zero, in: self.view)
            
            print(position)
            if position <= 0 {
                
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .transitionFlipFromTop, animations: {
                    self.mainPhotoView.transform = CGAffineTransform(translationX: 0, y: -150)
                }, completion: nil)
                sharePhoto()
                mainPhotoView.alpha = 0
            }
            
        } else {
            print("shake")
            shake()
        }
    }
    
    private func backToOriginalPosition() {
        let screenHeightCenter = UIScreen.main.bounds.height * 0.5
        mainPhotoView.center.y = screenHeightCenter
        mainPhotoView.alpha = 1
        shake()
    }
    
    
    // check if the grid is complete
    private func gridIsComplete() -> Bool {
        var gridIsComplete = true
        /**/
        for images in model.arrayOfImages[0] {
            if images == UIImage(imageLiteralResourceName: "blueCross") {
                gridIsComplete = false
            }
        }
        for images in model.arrayOfImages[1] {
            if images == UIImage(imageLiteralResourceName: "blueCross") {
                gridIsComplete = false
            }
        }/**/
        return gridIsComplete
    }

    private func sharePhoto() {
        
        // renderer UIView to UIImage
        UIGraphicsBeginImageContext(mainPhotoView.frame.size)
        mainPhotoView.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func shake() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.mainPhotoView.transform = CGAffineTransform(translationX: 0, y: 10)
        }, completion: nil)
    }
    
    
 
    
}
