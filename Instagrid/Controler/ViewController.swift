//
//  ViewController.swift
//  Instagrid
//
//  Created by Cr3AD on 13/12/2018.
//  Copyright © 2018 Cr3AD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var TLView: UIView!
    @IBOutlet weak var TRView: UIView!
    @IBOutlet weak var BLView: UIView!
    @IBOutlet weak var BRView: UIView!
    @IBOutlet weak var BottomViewLeftView: UIView!
    @IBOutlet weak var BottomViewCenterView: UIView!
    @IBOutlet weak var BottomViewRightView: UIView!
    @IBOutlet weak var checkImgLeft: UIImageView!
    @IBOutlet weak var checkImgRight: UIImageView!
    @IBOutlet weak var checkImgCenter: UIImageView!
    
    @IBAction func didTapTopLeftImg(_ sender: Any) {
    }
    @IBAction func didTapTopRightImg(_ sender: Any) {
    }
    @IBAction func didTapBottomLeftImg(_ sender: Any) {
    }
    
    @IBAction func didTapBottomRightImg(_ sender: Any) {
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
    

    
    func userChooseLeftView() {
        TLView.isHidden = false
        TRView.isHidden = true
        BRView.isHidden = false
        BLView.isHidden = false
        checkImgLeft.alpha = 0.4
        checkImgRight.alpha = 1
        checkImgCenter.alpha = 1
    }
    
    func userChooseCenterView() {
        TLView.isHidden = false
        TRView.isHidden = false
        BRView.isHidden = true
        BLView.isHidden = false
        checkImgLeft.alpha = 1
        checkImgRight.alpha = 1
        checkImgCenter.alpha = 0.4
    }
    
    func userChooseRight() {
        TLView.isHidden = false
        TRView.isHidden = false
        BRView.isHidden = false
        BLView.isHidden = false
        checkImgLeft.alpha = 1
        checkImgRight.alpha = 0.4
        checkImgCenter.alpha = 1
    }
}

