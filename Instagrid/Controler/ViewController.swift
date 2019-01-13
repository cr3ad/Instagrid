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
    
    @IBOutlet weak var mainViewTopStackView: UIStackView!
    @IBOutlet weak var mainViewBottomStackView: UIStackView!
    @IBOutlet weak var leftStyleImage: UIButton!
    @IBOutlet weak var centerStyleImage: UIButton!
    @IBOutlet weak var rightStyleImage: UIButton!
    
    @IBAction func didTapViewLeftMenu(_ sender: Any) {
        model.setStyle = .left
        resetMainView()
    }
    @IBAction func didTapViewCenterMenu(_ sender: Any) {

        model.setStyle = .center
        resetMainView()
    }
    @IBAction func didTapViewRightMenu(_ sender: Any) {

        model.setStyle = .right
        resetMainView()
    }
    
    
    // image picker
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any], sender: UIButton) {
        if (info[UIImagePickerController.InfoKey.editedImage] as? UIImage) != nil {
            generateButton(onPosition: sender.tag).imageView  // ??
           
        }
        
        picker.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)

    }
    
    
    // comment acceder aux boutons?
    // le modele comporte des Image? different de bouton? pourquoi ne pas creer des boutons dans les grilles?
    
    
    
    
    
    
    // button generation
    
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
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
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
    }

    
    

}

