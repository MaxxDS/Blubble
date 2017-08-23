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
import GameKit



class ViewControllerHome: UIViewController, GKGameCenterControllerDelegate {


    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet var buttonPlay: UIButton!
    
    @IBAction func buttonPlayPressed(_ sender: Any) {
        print (" bouton play pressed")
        if segmentedControl.selectedSegmentIndex == 0 {
        self.performSegue(withIdentifier: "Start1PlayerMode", sender: nil)
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
        self.performSegue(withIdentifier: "Start2PlayersMode", sender: nil)
        }
    }
    
    @IBOutlet var rateButton: UIButton!
    
    @IBOutlet var instructionButton: UIButton!
    
    
    @IBAction func rateButtonPressed(_ sender: Any) {
        rateApp(appId: "id1234984538") { success in
            print("RateApp \(success)")
        }
        
    }
    
    @IBOutlet var showLeaderButton: UIButton!
    
    @IBAction func showLeaderButtonPressed(_ sender: Any) {
        showLeader()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        initUI()
        initData()
    

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        authenticateLocalPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData (){

    }
    
    func initUI(){

        
        buttonPlay.backgroundColor = .clear
        

//        rateButton.layer.cornerRadius = 5
//        rateButton.layer.borderWidth = 1
//        rateButton.layer.borderColor = UIColor.white.cgColor
//        rateButton.titleLabel?.textAlignment = .center
//        
        
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
    
    //initiate gamecenter
    func authenticateLocalPlayer(){
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                self.present(viewController!, animated: true, completion: nil)
            }
                
            else {
                print((GKLocalPlayer.localPlayer().isAuthenticated))
            }
        }
        
    }
    
    
    //shows leaderboard screen
    func showLeader() {
        _ = self.view?.window?.rootViewController
        let gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        self.present(gc, animated: true, completion: nil)
    }
    
    //hides leaderboard screen
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController)
    {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        
    }

}
