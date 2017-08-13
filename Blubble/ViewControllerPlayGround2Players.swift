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
import SwiftyGif


class ViewControllerPlayGround2Players: UIViewController
{
    
    @IBOutlet var retourButton: UIButton!
    
    
    @IBOutlet var countDownLabel: UILabel!
    
    @IBOutlet var scoreLabel2: UILabel!
    @IBOutlet var scoreLabel1: UILabel!
    
    @IBOutlet var replayButton: UIButton!
    
    @IBOutlet var imageView1: UIImageView!
    
    @IBOutlet var imageView2: UIImageView!
    
    
    let gifManager = SwiftyGifManager(memoryLimit:20)
    
    let gif = UIImage(gifName: "TheBlubble.gif")
    
    var score1 : Int = 0
    var score2 : Int = 0
    var count = 0
    
    var countGameOver = 0
    
    var timer : Timer? = nil
    
    var timerGameOver : Timer? = nil
    
    @IBOutlet var buttonLeft1: UIButton!
    @IBOutlet var buttonRight1: UIButton!
    @IBOutlet var buttonLeft2: UIButton!
    @IBOutlet var buttonRight2: UIButton!
    
    
    @IBAction func buttonLeft1Pressed(_ sender: Any) {
        if buttonLeft1.backgroundColor == UIColor.myGreenColor() {
            buttonLeft1.backgroundColor = UIColor.white
            buttonRight1.backgroundColor = UIColor.myGreenColor()
            
        }
    }
    
    
    
    @IBAction func buttonLeft2Pressed(_ sender: Any) {
        if buttonLeft2.backgroundColor == UIColor.myGreenColor() {
            buttonLeft2.backgroundColor = UIColor.white
            buttonRight2.backgroundColor = UIColor.myGreenColor()
            
        }
    }
    
    
    
    @IBAction func buttonRight1Pressed(_ sender: Any) {
        if (buttonLeft1.backgroundColor == UIColor.white) {
            buttonRight1.backgroundColor = UIColor.white
            buttonLeft1.backgroundColor = UIColor.myGreenColor()
            score1 += 1
            imageView1.frame.size.width = imageView1.frame.size.width * 1.025
            imageView1.frame.size.height = imageView1.frame.size.height * 1.025
            imageView1.center.x = self.view.center.x
            //            imageView.center.y = self.view.center.y
            scoreLabel1.text = ("\(score1)")
        }
    }
    
    
    @IBAction func buttonRight2Pressed(_ sender: Any) {
        if (buttonLeft2.backgroundColor == UIColor.white) {
            buttonRight2.backgroundColor = UIColor.white
            buttonLeft2.backgroundColor = UIColor.myGreenColor()
            score2 += 1
            imageView2.frame.size.width = imageView2.frame.size.width * 1.025
            imageView2.frame.size.height = imageView2.frame.size.height * 1.025
            imageView2.center.x = self.view.center.x
            //            imageView.center.y = self.view.center.y
            scoreLabel2.text = ("\(score2)")
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

        //    override func viewDidAppear(_ animated: Bool) {
        //        authenticateLocalPlayer()
        //    }
        //
        //    // Do any additional setup after loading the view.
        //
        //
        //    override func didReceiveMemoryWarning() {
        //        super.didReceiveMemoryWarning()
        //        // Dispose of any resources that can be recreated.

    
    func initUI() {
        
        //        retourButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        countDownLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        scoreLabel2.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        
        
        
        //        replayButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        
        //
        //        self.imageView.setGifImage(gif, manager: gifManager, loopCount: 1)
        //
        //        view.addSubview(imageView)
        //
        //        buttonLeft.backgroundColor = .clear
        //        buttonLeft.layer.cornerRadius = 10
        //        buttonLeft.layer.borderWidth = 3
        //        buttonLeft.layer.borderColor = UIColor.white.cgColor
        //        buttonLeft.backgroundColor = UIColor.myGreenColor()
        //
        //        buttonRight.backgroundColor = .clear
        //        buttonRight.layer.cornerRadius = 10
        //        buttonRight.layer.borderWidth = 3
        //        buttonRight.layer.borderColor = UIColor.white.cgColor
        //        buttonRight.backgroundColor = UIColor.myGreenColor()
        //
        //        //        JpgView.isHidden = false
        //        //        GifView.isHidden = false
        //        //
        //                JpgView.frame.size.width = 80
        //                JpgView.frame.size.height = 48
        //                JpgView.center.x = self.view.center.x
        //                JpgView.center.y = self.view.center.y
        ////        //
        //        //        GifView.frame.size.width = 80
        //        //        GifView.frame.size.height = 48
        //        //        GifView.center.x = self.view.center.x
        //        //        GifView.center.y = self.view.center.y
        //        //
        //        //        GifView.loadGif(name: "BubbleBurst")
        //
        //        imageView.frame.size.width = 80
        //        imageView.frame.size.height = 48
        //        imageView.center.x = self.view.center.x
        //        imageView.center.y = self.view.center.y
        //
        //        self.imageView.stopAnimatingGif()
        //
    }
    //
    //
    func initData() {
        //        count = 5
        //        countGameOver = 6
        //        score = 0
        //        scoreLabel.text = ("\(score)")
        //        replayButton.isHidden = true
        //
        
    }
    //
    //
    //    func update() {
    //
    //        if (count > 0) {
    //            count -= 1
    //            countDownLabel.text = (" \(count) ")
    //
    //        }
    //
    //        if (count == 0){
    //            gameOver()
    //        }
    //
    //    }
    //
    //    //    func update1() {
    //    //        if (countGameOver > 0) {
    //    //            countGameOver -= 1
    //    //
    //    //
    //    //        }
    //    //
    //    //        if (countGameOver == 0){
    //    //            GifView.isHidden = true
    //    //        }
    //    //
    //    //    }
    //
    //    func gameOver () {
    //        timer?.invalidate()
    //        timer = nil
    //        countDownLabel.isHidden = true
    //        replayButton.isHidden = false
    //        buttonLeft.isEnabled = false
    //        buttonRight.isEnabled = false
    //        //        JpgView.isHidden = true
    //        //        GifView.isHidden = false
    //        saveHighscore(score: score)
    //        self.imageView.startAnimatingGif()
    //
    //    }
    //
        func restartGame () {
            timer = nil
            countDownLabel.isHidden = false
            replayButton.isHidden = true
            buttonLeft1.isEnabled = true
            buttonRight1.isEnabled = true
            buttonLeft2.isEnabled = true
            buttonRight2.isEnabled = true
    
            initUI()
        }
    //
    //
    //    //initiate gamecenter
    //    func authenticateLocalPlayer(){
    //
    //        let localPlayer = GKLocalPlayer.localPlayer()
    //
    //        localPlayer.authenticateHandler = {(viewController, error) -> Void in
    //
    //            if (viewController != nil) {
    //                self.present(viewController!, animated: true, completion: nil)
    //            }
    //
    //            else {
    //                print((GKLocalPlayer.localPlayer().isAuthenticated))
    //            }
    //        }
    //
    //    }
    //
    //
    //    //shows leaderboard screen
    //    func showLeader() {
    //        _ = self.view?.window?.rootViewController
    //        let gc = GKGameCenterViewController()
    //        gc.gameCenterDelegate = self
    //        self.present(gc, animated: true, completion: nil)
    //    }
    //
    //    //hides leaderboard screen
    //    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController)
    //    {
    //        gameCenterViewController.dismiss(animated: true, completion: nil)
    //
    //    }
    //
    //    //send high score to leaderboard
    //    func saveHighscore(score:Int) {
    //
    //        //check if user is signed in
    //        if GKLocalPlayer.localPlayer().isAuthenticated {
    //
    //            let scoreReporter = GKScore(leaderboardIdentifier: "LesPlusGrossesBlubbles") //leaderboard id here
    //
    //            scoreReporter.value = Int64(score) //score variable here (same as above)
    //
    //            let scoreArray: [GKScore] = [scoreReporter]
    //
    //            GKScore.report(scoreArray, withCompletionHandler: { (error) in
    //                if error != nil {
    //                    print("error")
    //                }
    //            })
    //
    //
    //
    //        }
    //    }
    //
    //
    //    /*
    //     // MARK: - Navigation
    //
    //     // In a storyboard-based application, you will often want to do a little preparation before navigation
    //     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //     // Get the new view controller using segue.destinationViewController.
    //     // Pass the selected object to the new view controller.
    //     }
    //     */
    //
}
//
//extension UIImage {
//    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
//        var delay = 0.001
//
//        // Get dictionaries
//        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
//        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
//        if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) == false {
//            return delay
//        }
//
//        let gifProperties:CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
//
//        // Get delay time
//        var delayObject: AnyObject = unsafeBitCast(
//            CFDictionaryGetValue(gifProperties,
//                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
//            to: AnyObject.self)
//        if delayObject.doubleValue == 0 {
//            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
//                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
//        }
//
//        delay = delayObject as? Double ?? 0
//
//        if delay < 0.001 {
//            delay = 0.001 // Make sure they're not too fast
//        }
//
//        return delay
//    }
//
//}
