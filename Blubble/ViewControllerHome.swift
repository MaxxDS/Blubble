//
//  ViewControllerHome.swift
//  Blubble
//
//  Created by Maxime DeSaint on 5/5/17.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewControllerHome: UIViewController {


    @IBOutlet var instructionsLabel: UILabel!
    
    @IBOutlet var buttonPlay: UIButton!
    
    @IBAction func buttonPlayPressed(_ sender: Any) {
        print (" bouton play pressed")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackground { (Bool, Error) in
//            print("Object has been saved.")
//        }
        
        initUI()
        initData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData (){
        instructionsLabel.text = instructions
    }
    
    func initUI(){

        
        buttonPlay.backgroundColor = .clear
//        buttonPlay.layer.cornerRadius = 5
//        buttonPlay.layer.borderWidth = 1
//        buttonPlay.layer.borderColor = UIColor.myBlueColor().cgColor

        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName: UIFont(name: "AvenirNextCondensed-Demibold", size: 30)!]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        UIApplication.shared.statusBarStyle = .lightContent
        //setNavBarToTheView()
        
    }
    

    
    var instructions : String =
    "Appuyer alternativememt sur le bouton gauche et le bouton droit pour faire grossir la bulle !!"
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
