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
import SwiftGifOrigin


class ViewControllerPlayGround2Players: UIViewController
{
    
    @IBOutlet var stackView: UIStackView!
    
    @IBOutlet var gameBoardView2: UIView!
    @IBOutlet var gameBoardView1: UIView!
    
    @IBOutlet var retourButton: UIButton!
    @IBOutlet var replayButton: UIButton!
    
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imagePointe: UIImageView!
    
    @IBOutlet var totalLabel1: UILabel!
    @IBOutlet var pourGagnerLabel1: UILabel!
    
    let gifManager = SwiftyGifManager(memoryLimit:20)
    let gif = UIImage(gifName: "TheBlubble.gif")
    
    let screenSize: CGRect = UIScreen.main.bounds
    let screenSizeHeight = UIScreen.main.bounds.height
    var screenSizeHeightInt = 0
    var score1 : Int = 0
    var score2 : Int = 0
    var scoreDiff : Int = 0
    var distance : Int = 0
    var timer : Timer? = nil
    var timeCount : Int = 0
    var nombreDeCoupsPourGagnerText : String = ""
    var nombreDeCoupsPourGagner : Int = 0
    var nombreDeCoupsCGFloat : CGFloat = 0.0
    
    
//    var imageView1Height = 0
//    
//    
    
    
    @IBOutlet var score1ToWin: UILabel!
    @IBOutlet var score2ToWin: UILabel!
    @IBOutlet var scoreLabel1: UILabel!
    @IBOutlet var scoreLabel2: UILabel!
    
    @IBOutlet var buttonLeft1: UIButton!
    @IBOutlet var buttonRight1: UIButton!
    @IBOutlet var buttonLeft2: UIButton!
    @IBOutlet var buttonRight2: UIButton!
    
    @IBOutlet var line1: UILabel!
    @IBOutlet var line2: UILabel!
    @IBOutlet var line3: UILabel!
    
    @IBOutlet var player1Name: UILabel!
    
    //    @IBOutlet var PourGagner2: UILabel!
    //    @IBOutlet var PourGagner1: UILabel!
    //    @IBOutlet var Total1: UILabel!
    //    @IBOutlet var Total2: UILabel!
    
    @IBAction func buttonLeft1Pressed(_ sender: Any) {
        if (buttonLeft1.isEnabled == true) {
            buttonLeft1.isEnabled = false
            buttonRight1.isEnabled = true
        }
    }
    
    
    
    @IBAction func buttonLeft2Pressed(_ sender: Any) {
        if buttonLeft2.isEnabled == true {
            buttonLeft2.isEnabled = false
            buttonRight2.isEnabled = true
        }
    }
    
    
    
    @IBAction func buttonRight1Pressed(_ sender: Any) {
        if (buttonLeft1.isEnabled == false) {
            buttonRight1.isEnabled = false
            buttonLeft1.isEnabled = true
            score1 += 1
            
            imagePointe.frame.origin.y = imagePointe.frame.origin.y - screenSize.height * (1/nombreDeCoupsCGFloat) * (18/100)
         
            refreshScoreData()
            scoreUpdate ()
        }
    }
    
    
    @IBAction func buttonRight2Pressed(_ sender: Any) {
        if (buttonLeft2.isEnabled == false) {
            buttonRight2.isEnabled = false
            buttonLeft2.isEnabled = true
            score2 += 1

            imagePointe.frame.origin.y = imagePointe.frame.origin.y + screenSize.height * (1/nombreDeCoupsCGFloat) * (18/100)

            refreshScoreData()
            scoreUpdate ()
        }
    }
    
    
    @IBAction func replayButtonPressed(_ sender: Any) {
        
        restartGame()
        timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(ViewControllerPlayGround2Players.update), userInfo: nil, repeats: true)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        imagePointeHeight = Int(imagePointe.frame.height)
//        screenSizeHeightInt = Int(screenSizeHeight)
//        
//        print ("imagePointeHeight: \(imagePointeHeight)")
//        print ("0.3 screenHeight: \(screenSizeHeightInt)")
//        
        initData()
        initUI()
        
        gameBoardView2.transform = gameBoardView2.transform.rotated(by: CGFloat(Double.pi))
        
        imageView1.transform = imageView1.transform.rotated(by: CGFloat(Double.pi/2))
        
        
        imageView2.transform = imageView2.transform.rotated(by: CGFloat(Double.pi*(3/2)))
        
        timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(ViewControllerPlayGround2Players.update), userInfo: nil, repeats: true)
    }
    
    
    func initUI() {
        
        self.imageView1.setGifImage(gif, manager: gifManager, loopCount: 1)
        self.imageView2.setGifImage(gif, manager: gifManager, loopCount: 1)
        self.imageView1.stopAnimatingGif()
        self.imageView2.stopAnimatingGif()
        //        view.addSubview(imageView)
        
        imagePointe.frame.size.height = screenSize.height * 0.15
//        imagePointe.frame.size.width = imageView1.frame.size.height * ( 129 / 182 )
        
        imagePointe.frame.size.width = screenSize.height * (3/18) * ( 129 / 182 )
        
        imagePointe.center.x = self.view.center.x
        imagePointe.center.y = self.view.center.y
        
        buttonLeft1.backgroundColor = UIColor.black
        
        buttonRight1.backgroundColor = UIColor.black
        
        buttonLeft2.backgroundColor = UIColor.black
        
        buttonRight2.backgroundColor = UIColor.black
        
        line1.frame.origin.x = screenSize.width / 11
        
        line1.frame.origin.y = (screenSize.height / 2 )
        line1.frame.size.width = (screenSize.width / 2 ) - 15 - screenSize.width / 11
        line2.frame.origin.x = (screenSize.width / 2 ) + 15
        line2.frame.origin.y = (screenSize.height / 2 )
        line2.frame.size.width = (screenSize.width / 2 ) - 15
        
        line3.frame.origin.x = screenSize.width/2
        line3.frame.origin.y = 0
        line3.frame.size.width = 1
        line3.frame.size.height = screenSize.height
        line3.backgroundColor = UIColor.white
        line3.layer.borderColor = UIColor.white.cgColor
        
        
        //        scoreLabel2.transform = scoreLabel2.transform.rotated(by: CGFloat(Double.pi))
        
        //        score2ToWin.transform = score2ToWin.transform.rotated(by: CGFloat(Double.pi))
        
        //        PourGagner2.transform = scoreLabel2.transform.rotated(by: CGFloat(Double.pi))
        
        //        Total2.transform = score2ToWin.transform.rotated(by: CGFloat(Double.pi))
        
        
        
        scoreDiff = 0
    }
    
    func initData() {
        //        replayButton.isHidden = false
        timeCount = 1
        
        scoreDiff = score2-score1
        
        scoreLabel1.text = "\(score1)"
        scoreLabel2.text = "\(score2)"
        
        nombreDeCoupsPourGagner = Int(nombreDeCoupsPourGagnerText)!
        nombreDeCoupsCGFloat = CGFloat(nombreDeCoupsPourGagner)
        
        print ("\(nombreDeCoupsCGFloat)")

        score1ToWin.text = "\(nombreDeCoupsPourGagner-scoreDiff)"
        score2ToWin.text = "\(nombreDeCoupsPourGagner+scoreDiff)"
        screenSizeHeightInt = Int(screenSizeHeight)
        
    }
    
    func refreshScoreData () {
        scoreDiff = score2-score1
        
        scoreLabel1.text = "\(score1)"
        scoreLabel2.text = "\(score2)"
        
        score1ToWin.text = "\(nombreDeCoupsPourGagner+scoreDiff)"
        score2ToWin.text = "\(nombreDeCoupsPourGagner-scoreDiff)"

    }
    
    func update() {
        
        if (timeCount > 0) {
            timeCount -= 1
        }
            
        else if (timeCount == 0){
            timeOver()
        }
    }
    
    func timeOver () {
        timer?.invalidate()
        timer = nil
        line3.isHidden = true
        //        line4.isHidden = true
        
        //        JpgView.isHidden = true
        //        GifView.isHidden = false
    }
    
    func scoreUpdate () {
        if scoreDiff == nombreDeCoupsPourGagner {
            player2Wins()
        }
        if scoreDiff == (nombreDeCoupsPourGagner * -1) {
            player1Wins()
        }
    }
    
    func restartGame () {
        //        replayButton.isHidden = false
        buttonLeft1.isEnabled = true
        buttonRight1.isEnabled = true
        buttonLeft2.isEnabled = true
        buttonRight2.isEnabled = true
        score1 = 0
        score2 = 0
        scoreDiff = 0
        initUI()
        initData()
    }
    
    func player1Wins () {
        replayButton.isHidden = false
        buttonLeft1.isEnabled = false
        buttonRight1.isEnabled = false
        buttonLeft2.isEnabled = false
        buttonRight2.isEnabled = false
        
        self.imageView2.startAnimatingGif()
    }
    
    func player2Wins () {
        replayButton.isHidden = false
        buttonLeft1.isEnabled = false
        buttonRight1.isEnabled = false
        buttonLeft2.isEnabled = false
        buttonRight2.isEnabled = false
        
        self.imageView1.startAnimatingGif()
    }
    
}
