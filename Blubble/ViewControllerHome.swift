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
    
    @IBOutlet var rateButton: UIButton!
    
    @IBAction func rateButtonPressed(_ sender: Any) {
        rateApp(appId: "id1234984538") { success in
            print("RateApp \(success)")
        }
        
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

        
        buttonPlay.backgroundColor = .clear
        
        instructionsLabel.layer.masksToBounds = true
        instructionsLabel.layer.backgroundColor  = UIColor.white.cgColor
        instructionsLabel.layer.cornerRadius = 5
        instructionsLabel.layer.borderWidth = 0
        instructionsLabel.layer.borderColor = UIColor.white.cgColor

        rateButton.layer.cornerRadius = 5
       rateButton.layer.borderWidth = 1
       rateButton.layer.borderColor = UIColor.white.cgColor
        
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName: UIFont(name: "AvenirNextCondensed-Demibold", size: 30)!]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        UIApplication.shared.statusBarStyle = .lightContent
        //setNavBarToTheView()
        
    }
    

    
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
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
