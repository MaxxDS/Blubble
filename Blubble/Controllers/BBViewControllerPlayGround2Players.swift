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


class BBViewControllerPlayGround2Players: UIViewController {
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var viewScoreBoard1: UIView!
    @IBOutlet var viewScoreBoard2: UIView!
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imagePointe: UIImageView!
    @IBOutlet var labelScoreToWin1: UILabel!
    @IBOutlet var labelScoreToWin2: UILabel!
    @IBOutlet var scoreLabel1: UILabel!
    @IBOutlet var scoreLabel2: UILabel!
    @IBOutlet var buttonRetour: UIButton!
    @IBOutlet var buttonReplay: UIButton!
    @IBOutlet var buttonLeft1: UIButton!
    @IBOutlet var buttonRight1: UIButton!
    @IBOutlet var buttonLeft2: UIButton!
    @IBOutlet var buttonRight2: UIButton!
    @IBOutlet var line1: UILabel!
    @IBOutlet var line2: UILabel!
    @IBOutlet var line3: UILabel!

    
    let gifManager = SwiftyGifManager(memoryLimit:20)
    let gif = UIImage(gifName: "BBtheBlubble.gif")
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        applyScoreBoardAndImageViewsSettings ()

    }
    
    func applyScoreBoardAndImageViewsSettings () {
        self.viewScoreBoard2.transform = viewScoreBoard2.transform.rotated(by: CGFloat(Double.pi))
        self.imageView1.transform = imageView1.transform.rotated(by: CGFloat(Double.pi/2))
        self.imageView2.transform = imageView2.transform.rotated(by: CGFloat(Double.pi*(3/2)))
    }
    
    func initUI() {
        applyImagesSettings ()
        applyLinesSettings ()
        applyButtonsSettings ()
    }
    
    func applyImagesSettings () {
        self.imageView1.setGifImage(gif, manager: gifManager, loopCount: 1)
        self.imageView2.setGifImage(gif, manager: gifManager, loopCount: 1)
        self.imageView1.stopAnimatingGif()
        self.imageView2.stopAnimatingGif()
        
        self.imagePointe.frame.size.height = screenSize.height * 0.15
        self.imagePointe.frame.size.width = screenSize.height * (3/18) * ( 129 / 182 )
        self.imagePointe.center.x = self.view.center.x
        self.imagePointe.center.y = self.view.center.y
    }
    
    func applyLinesSettings () {
        self.line1.frame.origin.x = screenSize.width / 11
        self.line1.frame.origin.y = (screenSize.height / 2 )
        self.line1.frame.size.width = (screenSize.width / 2 ) - 15 - screenSize.width / 11
        
        self.line2.frame.origin.x = (screenSize.width / 2 ) + 15
        self.line2.frame.origin.y = (screenSize.height / 2 )
        self.line2.frame.size.width = (screenSize.width / 2 ) - 15
        
        self.line3.frame.origin.x = screenSize.width/2
        self.line3.frame.origin.y = 0
        self.line3.frame.size.width = 1
        self.line3.frame.size.height = screenSize.height
        self.line3.backgroundColor = UIColor.white
        self.line3.layer.borderColor = UIColor.white.cgColor
    }
    
    func applyButtonsSettings () {
        self.buttonLeft1.backgroundColor = UIColor.black
        self.buttonRight1.backgroundColor = UIColor.black
        
        self.buttonLeft2.backgroundColor = UIColor.black
        self.buttonRight2.backgroundColor = UIColor.black
    }
    
    func initData() {
        self.timeCount = 1
        self.scoreDiff = score2-score1
        self.scoreLabel1.text = "\(score1)"
        self.scoreLabel2.text = "\(score2)"
    
        self.nombreDeCoupsPourGagner = Int(nombreDeCoupsPourGagnerText)!
        self.nombreDeCoupsCGFloat = CGFloat(nombreDeCoupsPourGagner)

        self.labelScoreToWin1.text = "\(nombreDeCoupsPourGagner-scoreDiff)"
        self.labelScoreToWin2.text = "\(nombreDeCoupsPourGagner+scoreDiff)"
        
        self.screenSizeHeightInt = Int(screenSizeHeight)
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(BBViewControllerPlayGround2Players.timeUpdate), userInfo: nil, repeats: true)
    }
    

    @IBAction func buttonLeft1Pressed(_ sender: Any) {
        if  self.buttonLeft1.isEnabled == true {
            self.buttonLeft1.isEnabled = false
            self.buttonRight1.isEnabled = true
        }
    }
    
    
    @IBAction func buttonLeft2Pressed(_ sender: Any) {
        if self.buttonLeft2.isEnabled == true {
            self.buttonLeft2.isEnabled = false
            self.buttonRight2.isEnabled = true
        }
    }
    
    
    @IBAction func buttonRight1Pressed(_ sender: Any) {
        if  self.buttonLeft1.isEnabled == false {
            self.buttonRight1.isEnabled = false
            self.buttonLeft1.isEnabled = true
            self.score1 += 1
            
            self.imagePointe.frame.origin.y = imagePointe.frame.origin.y - screenSize.height * (1/nombreDeCoupsCGFloat) * (18/100)
         
            refreshScoreData()
            scoreUpdate ()
        }
    }
    
    
    @IBAction func buttonRight2Pressed(_ sender: Any) {
        if  self.buttonLeft2.isEnabled == false {
            self.buttonRight2.isEnabled = false
            self.buttonLeft2.isEnabled = true
            self.score2 += 1

            self.imagePointe.frame.origin.y = imagePointe.frame.origin.y + screenSize.height * (1/nombreDeCoupsCGFloat) * (18/100)

            refreshScoreData()
            scoreUpdate ()
        }
    }
    
    
    @IBAction func buttonReplayPressed(_ sender: Any) {
        restartGame()
    }
    
    
    func refreshScoreData () {
        self.scoreDiff = self.score2-self.score1
        
        self.scoreLabel1.text = "\(score1)"
        self.scoreLabel2.text = "\(score2)"
        
        self.labelScoreToWin1.text = "\(nombreDeCoupsPourGagner+scoreDiff)"
        self.labelScoreToWin2.text = "\(nombreDeCoupsPourGagner-scoreDiff)"

    }
    
    func timeUpdate () {
        if (timeCount > 0) {
            timeCount -= 1
        }
        else if (timeCount == 0){
            timeOver()
        }
    }
    
    func timeOver () {
        self.timer?.invalidate()
        self.timer = nil
        self.line3.isHidden = true
    }
    
    func scoreUpdate () {
        if self.scoreDiff == nombreDeCoupsPourGagner {
            player2Wins()
        }
        if self.scoreDiff == (nombreDeCoupsPourGagner * -1) {
            player1Wins()
        }
    }
    
    func restartGame () {
        self.buttonLeft1.isEnabled = true
        self.buttonRight1.isEnabled = true
        self.buttonLeft2.isEnabled = true
        self.buttonRight2.isEnabled = true
        self.score1 = 0
        self.score2 = 0
        self.scoreDiff = 0
        initUI()
        initData()
    }
    
    func player1Wins () {
        self.buttonReplay.isHidden = false
        self.buttonLeft1.isEnabled = false
        self.buttonRight1.isEnabled = false
        self.buttonLeft2.isEnabled = false
        self.buttonRight2.isEnabled = false
        self.imageView2.startAnimatingGif()
    }
    
    func player2Wins () {
        self.buttonReplay.isHidden = false
        self.buttonLeft1.isEnabled = false
        self.buttonRight1.isEnabled = false
        self.buttonLeft2.isEnabled = false
        self.buttonRight2.isEnabled = false
        self.imageView1.startAnimatingGif()
    }
}
