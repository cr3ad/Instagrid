//
//  Notes.swift
//  Instagrid
//
//  Created by Cr3AD on 16/01/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation


/*
 MVC
 
 M <=> C <=> V
 
 View (V)
 ImagePicker (V)
 ViewController (C)
 Model (M)
 
 View => Afficher Image Picker au ViewCOntroller (V => C)
 ViewController =>Afficher ImagePicker (C => V)
 ImagePicker => Informe le ViewCOntroller de l'image choisi (V = C)
 =>   ViewController => Enregistre la nouvelle image dans le model
 * Model => Met a jour le tableau pour refletter la nouvel image (C => M /// M => C)
 * VIewController => Met a jour la vue avec le nouveau tableau du Model (C => V)
 `
 
 VIew => Informe le VC que j'ai changer de layout (V => C)
 ViewController => Changer  le layout dans le Model (C => M)
 * Model => Met a jour le tableau pour refletter le nouveau layout (C => M /// M => C)
 * VIewController => Met a jour la vue avec le nouveau tableau du Model (C => V)
 ( V => C => M => C => V)
 
 */
    
