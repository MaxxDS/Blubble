//
//  BBViewControllerHome.swift
//  Blubble
//
//  Created by Maxime DeSaint on 5/5/17.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import UIKit
import Parse
import Bolts
import GameKit



class BBViewControllerHome: UIViewController, GKGameCenterControllerDelegate {

    @IBOutlet var segmentedControl1PlayerOr2Players: UISegmentedControl!
    @IBOutlet var buttonPlay: UIButton!
    @IBOutlet var buttonRate: UIButton!
    @IBOutlet var buttonInstructions: UIButton!
    @IBOutlet var buttonGameCenter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        buttonPlay.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName: UIFont(name: "AvenirNextCondensed-Demibold", size: 30)!]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        authenticateLocalPlayer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func buttonPlayPressed(_ sender: Any) {
        print (" bouton play pressed")
        if segmentedControl1PlayerOr2Players.selectedSegmentIndex == 0 {
        self.performSegue(withIdentifier: "Start1PlayerMode", sender: nil)
        }
        else if segmentedControl1PlayerOr2Players.selectedSegmentIndex == 1 {
        self.performSegue(withIdentifier: "Start2PlayersMode", sender: nil)
        }
    }
    
    @IBAction func buttonInstructionsPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showInstructions", sender: nil)
    }

    @IBAction func buttonRatePressed(_ sender: Any) {
        rateApp(appId: "id1234984538") { success in
            print("RateApp \(success)")
        }
    }
    
    @IBAction func buttonGameCenterPressed(_ sender: Any) {
        showGameCenter()
        
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
    func showGameCenter() {
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
