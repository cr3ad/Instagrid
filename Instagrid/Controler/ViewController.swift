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
        model.style = .left
        resetMainView()
    }
    @IBAction func didTapViewCenterMenu(_ sender: Any) {
        applyBottomStyle()
        model.style = .center
        resetMainView()
    }
    @IBAction func didTapViewRightMenu(_ sender: Any) {
        applyBottomStyle()
        model.style = .right
        resetMainView()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            model.images[1] = userImage
            resetMainView()
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //Mark: Button generation

    func generateButton(onPosition: Int) -> UIButton {
        let myButton = UIButton()
        myButton.tag = onPosition
        //myButton.setImage(backgroundButtonImage, for: .normal)
        myButton.backgroundColor = #colorLiteral(red: 0.9410743117, green: 0.9412353635, blue: 0.9410640597, alpha: 1)
        myButton.contentMode = .center
        myButton.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
        return myButton
    }
    
    @objc func tapOnButton(sender:UIButton){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
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
            mainViewTopStackView.addArrangedSubview(generateButton(onPosition: image.offset))
        }
        for image in bottom.enumerated() {
            mainViewBottomStackView.addArrangedSubview(generateButton(onPosition: image.offset + top.count))
        }
        applyBottomStyle()
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

    func resetBottomStyle() {
        leftStyleImage.isSelected = false
        centerStyleImage.isSelected = false
        rightStyleImage.isSelected = false
    }
    
    //Mark: View Modification
    
    @IBAction func mainViewGesture(_ sender: UIPanGestureRecognizer) {
      
        switch sender.state {
        case .began, .changed:
            transformPhotoView(gesture: sender)
        case .ended where model.viewStatut == .complete,
             .cancelled where model.viewStatut == .complete :
            sharePhoto()
        default:
            break
        }
    }
    
    private func transformPhotoView(gesture: UIPanGestureRecognizer) {
        
        if model.viewStatut == .complete {
            
            let translation = gesture.translation(in: self.view)
            if let view = gesture.view {
                view.center = CGPoint(x: view.center.x ,
                                      y: view.center.y + translation.y)
            }
            gesture.setTranslation(CGPoint.zero, in: self.view)
        }
            
        if model.viewStatut == .incomplete {
            
            shakeIncomplete()
        }
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
    
        // in case photoGrid is incomplete
    private func shakeIncomplete() {
        mainPhotoView.transform = CGAffineTransform(translationX: 0, y: 10)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.mainPhotoView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
        
    
}
