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
        imagePicker1.delegate = self
        imagePicker2.delegate = self
        imagePicker3.delegate = self
        imagePicker4.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var photoView = PhotoView()

    
    let imagePicker1 = UIImagePickerController()
    let imagePicker2 = UIImagePickerController()
    let imagePicker3 = UIImagePickerController()
    let imagePicker4 = UIImagePickerController()
    
    @IBOutlet weak var mainTopLeftImage: UIImageView!
    @IBOutlet weak var mainTopRightImage: UIImageView!
    @IBOutlet weak var mainBottomLeftImage: UIImageView!
    @IBOutlet weak var mainBottomRightImage: UIImageView!
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        dismiss(animated: true, completion: nil)
        if picker == imagePicker1 {
            mainTopLeftImage.image = selectedImage
        } else if picker == imagePicker2 {
            mainTopRightImage.image = selectedImage
        } else if picker == imagePicker3 {
            mainBottomLeftImage.image = selectedImage
        } else if picker == imagePicker4 {
            mainBottomRightImage.image = selectedImage
        }
        
    }

    @IBAction func didTapTopLeftImg(_ sender: Any) {
        imagePicker1.sourceType = .photoLibrary
        present(imagePicker1, animated: true, completion: nil)
    }
    
  
    @IBAction func didTapTopRightImg(_ sender: Any) {
        imagePicker2.sourceType = .photoLibrary
        present(imagePicker2, animated: true, completion: nil)
        
    }
    @IBAction func didTapBottomLeftImg(_ sender: Any) {
        imagePicker3.sourceType = .photoLibrary
        present(imagePicker3, animated: true, completion: nil)
    }
    
    @IBAction func didTapBottomRightImg(_ sender: Any) {
        imagePicker4.sourceType = .photoLibrary
        present(imagePicker4, animated: true, completion: nil)
    }
    
    @IBAction func BottomLeftButton(_ sender: Any) {
        photoView.style = .left
    }
    
    @IBAction func BottomCenterButton(_ sender: Any) {
        photoView.style = .center
    }
    
    @IBAction func BottomRightButton(_ sender: Any) {
        photoView.style = .right
    }
    

}

