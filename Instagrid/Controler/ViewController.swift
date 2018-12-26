//
//  ViewController.swift
//  Instagrid
//
//  Created by Cr3AD on 13/12/2018.
//  Copyright © 2018 Cr3AD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var TLView: UIView!
    @IBOutlet weak var TRView: UIView!
    @IBOutlet weak var BLView: UIView!
    @IBOutlet weak var BRView: UIView!

    @IBOutlet weak var mainTopLeftButton: UIButton!
    @IBOutlet weak var mainTopRightButton: UIButton!
    @IBOutlet weak var mainBottomLeftButton: UIButton!
    @IBOutlet weak var mainBottomRightButton: UIButton!
    
    @IBOutlet weak var mainTopLeftImage: UIImageView!
    @IBOutlet weak var mainTopRightImage: UIImageView!
    @IBOutlet weak var mainBottomLeftImage: UIImageView!
    @IBOutlet weak var mainBottomRightImage: UIImageView!
    
    @IBOutlet weak var BottomViewLeftView: UIView!
    @IBOutlet weak var BottomViewCenterView: UIView!
    @IBOutlet weak var BottomViewRightView: UIView!
    @IBOutlet weak var bottomButtonLeft: UIButton!
    @IBOutlet weak var bottomButtonCenter: UIButton!
    @IBOutlet weak var bottomButtonRight: UIButton!
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    ////
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        dismiss(animated: true, completion: nil)
        mainTopLeftImage.image = selectedImage
    }


    ///

    @IBAction func didTapTopLeftImg(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
  
    @IBAction func didTapTopRightImg(_ sender: Any) {
        let imagePickerController2 = UIImagePickerController()
        imagePickerController2.sourceType = .photoLibrary
        imagePickerController2.delegate = self
        present(imagePickerController2, animated: true, completion: nil)
        
    }
    @IBAction func didTapBottomLeftImg(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func didTapBottomRightImg(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)

        
    }
    
    @IBAction func didTapViewLeftMenu(_ sender: Any) {
        userChooseLeftView()
    }
    @IBAction func didTapViewCenterMenu(_ sender: Any) {
        userChooseCenterView()
    }
    @IBAction func didTapViewRightMenu(_ sender: Any) {
        userChooseRight()
    }
    
// test


   
// test
    
    func userChooseLeftView() {
        TLView.isHidden = false
        TRView.isHidden = true
        BRView.isHidden = false
        BLView.isHidden = false
        bottomButtonLeft.alpha = 0.4
        bottomButtonRight.alpha = 1
        bottomButtonCenter.alpha = 1
        
        
    }
    
    func userChooseCenterView() {
        TLView.isHidden = false
        TRView.isHidden = false
        BRView.isHidden = true
        BLView.isHidden = false
        bottomButtonLeft.alpha = 1
        bottomButtonRight.alpha = 1
        bottomButtonCenter.alpha = 0.4
    }
    
    func userChooseRight() {
        TLView.isHidden = false
        TRView.isHidden = false
        BRView.isHidden = false
        BLView.isHidden = false
        bottomButtonLeft.alpha = 1
        bottomButtonRight.alpha = 0.4
        bottomButtonCenter.alpha = 1
    }
}

