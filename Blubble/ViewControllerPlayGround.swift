//
//  ViewControllerPlayGround.swift
//  Blubble
//
//  Created by Maxime DeSaint on 5/5/17.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import UIKit
import Parse
import Bolts
import GameKit

class ViewControllerPlayGround: UIViewController, GKGameCenterControllerDelegate
{
    
    
    @IBOutlet var showLeaderButton: UIButton!
    
    @IBAction func showLeaderButtonPressed(_ sender: Any) {
        showLeader()
        
    }
    
    //shows leaderboard screen
    
    
    @IBOutlet var countDownLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
//    @IBOutlet var imageBulle: UIImageView!
    
    @IBOutlet var GifView: UIImageView!
    
    @IBOutlet var replayButton: UIButton!
    
    @IBOutlet var Label: UILabel!
    
    var score : Int = 0
    
    var count = 0
    
    var timer : Timer? = nil
    
    
    
    @IBOutlet var buttonLeft: UIButton!
    
    @IBAction func buttonLeftPressed(_ sender: Any) {
        if buttonLeft.backgroundColor == UIColor.myGreenColor() {
            buttonLeft.backgroundColor = UIColor.white
            buttonRight.backgroundColor = UIColor.myGreenColor()
            
        }
    }
    
    
    @IBOutlet var buttonRight: UIButton!
    
    @IBAction func buttonRightPressed(_ sender: Any) {
        if (buttonLeft.backgroundColor == UIColor.white) {
            buttonRight.backgroundColor = UIColor.white
            buttonLeft.backgroundColor = UIColor.myGreenColor()
            score += 1
//            imageBulle.frame.size.width = imageBulle.frame.size.width * 1.025
//            imageBulle.frame.size.height = imageBulle.frame.size.height * 1.025
//            imageBulle.center.x = self.view.center.x
//            imageBulle.center.y = self.view.center.y
            
            GifView.frame.size.width = GifView.frame.size.width * 1.025
            GifView.frame.size.height = GifView.frame.size.height * 1.025
            GifView.center.x = self.view.center.x
            GifView.center.y = self.view.center.y
            scoreLabel.text = ("\(score)")
            
            
        }
    }
    
    
    @IBAction func replayButtonPressed(_ sender: Any) {
        
        initData()
        initUI()
        restartGame()
        
        countDownLabel.text = "\(count)"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewControllerPlayGround.update), userInfo: nil, repeats: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        
        countDownLabel.text = "\(count)"
       
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewControllerPlayGround.update), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         authenticateLocalPlayer()
    }
    
    // Do any additional setup after loading the view.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        buttonLeft.backgroundColor = .clear
        buttonLeft.layer.cornerRadius = 10
        buttonLeft.layer.borderWidth = 3
        buttonLeft.layer.borderColor = UIColor.white.cgColor
        buttonLeft.backgroundColor = UIColor.myGreenColor()
        
        buttonRight.backgroundColor = .clear
        buttonRight.layer.cornerRadius = 10
        buttonRight.layer.borderWidth = 3
        buttonRight.layer.borderColor = UIColor.white.cgColor
        buttonRight.backgroundColor = UIColor.myGreenColor()
        
//        imageBulle.center.x = self.view.center.x
//        imageBulle.center.y = self.view.center.y
        
        GifView.frame.size.width = 80
        GifView.frame.size.height = 48
        GifView.center.x = self.view.center.x
        GifView.center.y = self.view.center.y
        
        GifView.loadGif(name: "BubbleBurst")
    }
    
    
    func initData() {
        count = 20
        score = 0
        scoreLabel.text = ("\(score)")
        replayButton.isHidden = true
        
    }
    
    
    func update() {
        
        if (count > 0) {
            count -= 1
            countDownLabel.text = (" \(count) ")
            
        }
        
        if (count == 0){
            gameOver()
        }
        
    }
    
    func gameOver () {
        timer?.invalidate()
        timer = nil
        countDownLabel.isHidden = true
        replayButton.isHidden = false
        buttonLeft.isEnabled = false
        buttonRight.isEnabled = false
        saveHighscore(score: score)
        
    }
    
    func restartGame () {
        timer = nil
        countDownLabel.isHidden = false
        replayButton.isHidden = true
        buttonLeft.isEnabled = true
        buttonRight.isEnabled = true
//        imageBulle.frame.size.width = 48
//        imageBulle.frame.size.height = 48
//        imageBulle.center.x = self.view.center.x
//        imageBulle.center.y = self.view.center.y
        
        GifView.frame.size.width = 80
        GifView.frame.size.height = 48
        GifView.center.x = self.view.center.x
        GifView.center.y = self.view.center.y
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
            
            let scoreReporter = GKScore(leaderboardIdentifier: "LesPlusGrossesBlubbles") //leaderboard id here
            
            scoreReporter.value = Int64(score) //score variable here (same as above)
            
            let scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.report(scoreArray, withCompletionHandler: { (error) in
                if error != nil {
                    print("error")
                }
            })
            
            
            
        }
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
