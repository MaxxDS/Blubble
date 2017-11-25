//
//  File.swift
//  Blubble
//
//  Created by Maxime DeSaint on 23/08/2017.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import UIKit

class BBViewControllerInstructions: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var buttonRetour: UIButton!
    @IBOutlet var labelInstructions: UILabel!

    
    var points : Int = 18
    var inputText : String = ""
    var input = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        buttonRetour.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonRetour.titleLabel?.baselineAdjustment = .alignCenters
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

