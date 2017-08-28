//
//  File.swift
//  Blubble
//
//  Created by Maxime DeSaint on 23/08/2017.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import UIKit




class ViewControllerInstructions: UIViewController, UITextFieldDelegate {
    

    @IBOutlet var retourButton: UIButton!
    @IBOutlet var instructionsLabel: UILabel!
    @IBOutlet var diffDePointsPourGagner: UITextField!
    var points : Int = 18
    var inputText : String = ""
    var input = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initUI()
        initData()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData (){
        diffDePointsPourGagner.text = "\(points)"
    }
    
    func initUI(){
//        retourButton.layer.masksToBounds = true
//        retourButton.layer.backgroundColor  = UIColor.black.cgColor
//        retourButton.layer.cornerRadius = 5
//        retourButton.layer.borderWidth = 1
//        retourButton.layer.borderColor = UIColor.white.cgColor
        

       retourButton.titleLabel?.adjustsFontSizeToFitWidth = true
        retourButton.titleLabel?.baselineAdjustment = .alignCenters
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputText = self.diffDePointsPourGagner.text!
        input = Int(inputText)!
        
        
        textField.resignFirstResponder()
        return true;
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

