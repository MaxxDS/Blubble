//
//  ViewControllerHome.swift
//  Blubble
//
//  Created by Maxime DeSaint on 5/5/17.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import UIKit

class ViewControllerHome: UIViewController {

    @IBOutlet var buttonClassement: UIButton!
    
    @IBOutlet var buttonRating: UIButton!
    
    @IBOutlet var buttonPlay: UIButton!
    
    @IBAction func buttonPlayPressed(_ sender: Any) {
        print (" bouton play pressed")
        
    }
    
    
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
    }
    
    func initUI(){
        
        buttonClassement.backgroundColor = .clear
        buttonClassement.layer.cornerRadius = 5
        buttonClassement.layer.borderWidth = 1
        buttonClassement.layer.borderColor = UIColor.myGreenColor().cgColor
        
        buttonRating.backgroundColor = .clear
        buttonRating.layer.cornerRadius = 5
        buttonRating.layer.borderWidth = 1
        buttonRating.layer.borderColor = UIColor.myGreenColor().cgColor
        
        
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
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
