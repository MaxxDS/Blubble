//
//  BBViewControllerPlayGround.swift
//  Blubble
//
//  Created by Maxime DeSaint on 5/5/17.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import UIKit
import Parse
import Bolts
import GameKit
import SwiftyGif

class BBViewControllerPlayGround: UIViewController, GKGameCenterControllerDelegate
{
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelCountDown: UILabel!
    @IBOutlet var labelScore: UILabel!
    @IBOutlet var buttonGameCenter: UIButton!
    @IBOutlet var buttonReplay: UIButton!
    @IBOutlet var buttonLeft: UIButton!
    @IBOutlet var buttonRight: UIButton!
    
    
    let gifManager = SwiftyGifManager(memoryLimit:20)
    let gif = UIImage(gifName: "BBtheBlubble.gif")
    let fingerPrint = UIImage(named: "Fingerprint")
    var score : Int = 0
    var totalTime = 0
    var count = 0
    var countGameOver = 0
    var timer : Timer? = nil
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(BBViewControllerPlayGround.timeUpdate), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        authenticateLocalPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initUI() {
        applyButtonSettings ()
        applyImageViewSettings ()
        startTimeFormat ()
        self.labelScore.text = ("\(score)")
        self.buttonReplay.isHidden = true
    }
    
    func initData() {
        self.totalTime = 20
        self.count = totalTime - 1
        self.score = 0
    }
    
    func applyButtonSettings () {
        self.buttonLeft.backgroundColor = .clear
        self.buttonLeft.layer.cornerRadius = 10
        self.buttonLeft.layer.borderWidth = 3
        self.buttonLeft.layer.borderColor = UIColor.white.cgColor
        self.buttonLeft.backgroundColor = UIColor.white
        
        self.buttonRight.backgroundColor = .clear
        self.buttonRight.layer.cornerRadius = 10
        self.buttonRight.layer.borderWidth = 3
        self.buttonRight.layer.borderColor = UIColor.white.cgColor
    }
    
    func applyImageViewSettings () {
        self.imageView.setGifImage(gif, manager: gifManager, loopCount: 1)
        self.imageView.stopAnimatingGif()
        
        self.imageView.frame.size.height = screenSize.height * 0.1
        self.imageView.frame.size.width = imageView.frame.size.height * ( 23 / 13 )
        self.imageView.center.x = self.view.center.x
        self.imageView.center.y = self.view.center.y
    }
    
    
    @IBAction func buttonGameCenterPressed(_ sender: Any) {
        showLeader()
    }

    @IBAction func buttonLeftPressed(_ sender: Any) {
        if  self.buttonLeft.backgroundColor == UIColor.white {
            self.buttonLeft.backgroundColor = UIColor.black
            self.buttonRight.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func buttonRightPressed(_ sender: Any) {
        if  self.buttonLeft.backgroundColor == UIColor.black {
            self.buttonRight.backgroundColor = UIColor.black
            self.buttonLeft.backgroundColor = UIColor.white
            
            self.score += 1
            
            self.imageView.frame.size.width = imageView.frame.size.width * 1.021
            self.imageView.frame.size.height = imageView.frame.size.height * 1.021
            self.imageView.center.x = self.view.center.x
            self.imageView.center.y = self.view.center.y
            
            self.labelScore.text = ("\(score)")
        }
    }
    
    @IBAction func buttonReplayPressed(_ sender: Any) {
        initData()
        initUI()
        restartGame()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(BBViewControllerPlayGround.timeUpdate), userInfo: nil, repeats: true)
    }
    

    func startTimeFormat () {
        if (self.totalTime > 9) {
            self.labelCountDown.text = ("0:\(totalTime) ")
        }
            
        else if (self.count > 0) {
            self.labelCountDown.text = ("0:0\(totalTime) ")
        }
    }
    

    func timeUpdate () {
        if (self.count > 9) {
            self.labelCountDown.text = ("0:\(count) ")
            self.count -= 1}
            
        else if (self.count > 0) {
            self.labelCountDown.text = ("0:0\(count) ")
            self.count -= 1
        }
            
        else if (self.count == 0){
            gameOver()
        }
        
    }
    
    
    func gameOver () {
        self.timer?.invalidate()
        self.timer = nil
        self.labelCountDown.isHidden = true
        self.buttonReplay.isHidden = false
        self.buttonLeft.isEnabled = false
        self.buttonRight.isEnabled = false
        saveHighscore(score: score)
        self.imageView.startAnimatingGif()
        
    }
    
    
    func restartGame () {
        self.timer = nil
        self.labelCountDown.isHidden = false
        self.buttonReplay.isHidden = true
        self.buttonLeft.isEnabled = true
        self.buttonRight.isEnabled = true
        
        self.imageView.frame.size.height = screenSize.height * 0.1
        self.imageView.frame.size.width = imageView.frame.size.height * ( 23 / 13 )
        self.imageView.center.x = self.view.center.x
        self.imageView.center.y = self.view.center.y
    }
    
    
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
    
    //send high score to leaderboard
    func saveHighscore(score:Int) {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "LesPlusGrossesBlubbles")
            
            scoreReporter.value = Int64(score)
            
            let scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.report(scoreArray, withCompletionHandler: { (error) in
                if error != nil {
                    print("error")
                }
            })
        }
    }
}

