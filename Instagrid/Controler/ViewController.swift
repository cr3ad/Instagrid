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
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        resetMainView()
    }
    
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
    
    
    // image picker
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any], sender: UIButton) {
        if let userImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            model.images[sender.tag] = userImage
            resetMainView()
            print(sender.tag)
        }
        picker.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    /*func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any], sender: UIButton) {
        if let userImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            model.images[sender.tag] = userImage
            resetMainView()
            print(sender.tag)
        }
        picker.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    */
    var backgroundButtonImage = UIImage(imageLiteralResourceName: "blueCross")

    func generateButton(onPosition: Int) -> UIButton {
        let myButton = UIButton()
        myButton.tag = onPosition
        myButton.setImage(backgroundButtonImage, for: .normal)
        myButton.backgroundColor = #colorLiteral(red: 0.9410743117, green: 0.9412353635, blue: 0.9410640597, alpha: 1)
        myButton.contentMode = .center
        myButton.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
        return myButton
    }
    
    @objc func tapOnButton(sender:UIButton){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
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
}

