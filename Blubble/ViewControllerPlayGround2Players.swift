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
    
    @IBOutlet var retourButton: UIButton!
    @IBOutlet var replayButton: UIButton!
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView: UIImageView!
    
    let gifManager = SwiftyGifManager(memoryLimit:20)
    let gif = UIImage(gifName: "TheBlubble.gif")
    let screenSize: CGRect = UIScreen.main.bounds
    
    var score1 : Int = 0
    var score2 : Int = 0
    var scoreDiff : Int = 0
    
    var distance : Int = 0
    
    @IBOutlet var buttonLeft1: UIButton!
    @IBOutlet var buttonRight1: UIButton!
    @IBOutlet var buttonLeft2: UIButton!
    @IBOutlet var buttonRight2: UIButton!
    
    @IBOutlet var line1: UILabel!
    @IBOutlet var line2: UILabel!
//    @IBOutlet var line3: UILabel!
    
    @IBAction func buttonLeft1Pressed(_ sender: Any) {
        if (buttonLeft1.backgroundColor == UIColor.white) {
            buttonLeft1.backgroundColor = UIColor.black
            buttonRight1.backgroundColor = UIColor.white
        }
    }
    
    
    
    @IBAction func buttonLeft2Pressed(_ sender: Any) {
        if buttonLeft2.backgroundColor == UIColor.white {
            buttonLeft2.backgroundColor = UIColor.black
            buttonRight2.backgroundColor = UIColor.white
        }
    }
    
    
    
    @IBAction func buttonRight1Pressed(_ sender: Any) {
        if (buttonLeft1.backgroundColor == UIColor.black) {
            buttonRight1.backgroundColor = UIColor.black
            buttonLeft1.backgroundColor = UIColor.white
            score1 += 1
            imageView.frame.origin.y = imageView.frame.origin.y-(screenSize.height * 0.01)
            scoreDiff = score2-score1
            scoreUpdate ()
        }
    }
    
    
    @IBAction func buttonRight2Pressed(_ sender: Any) {
        if (buttonLeft2.backgroundColor == UIColor.black) {
            buttonRight2.backgroundColor = UIColor.black
            buttonLeft2.backgroundColor = UIColor.white
            score2 += 1
            imageView.frame.origin.y = imageView.frame.origin.y+(screenSize.height * 0.01)
            scoreDiff = score2-score1
            scoreUpdate ()
        }
    }
    
    
    @IBAction func replayButtonPressed(_ sender: Any) {
        
        initData()
        initUI()
        restartGame()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    
    
    func initUI() {
        
        self.imageView1.setGifImage(gif, manager: gifManager, loopCount: 1)
        self.imageView2.setGifImage(gif, manager: gifManager, loopCount: 1)
        self.imageView1.stopAnimatingGif()
        self.imageView2.stopAnimatingGif()
        //        view.addSubview(imageView)
        
        imageView.frame.size.height = screenSize.height * 0.15
        imageView.frame.size.width = imageView1.frame.size.height * ( 129 / 182 )
        imageView.center.x = self.view.center.x
        imageView.center.y = self.view.center.y
        
        buttonLeft1.backgroundColor = .clear
        buttonLeft1.layer.cornerRadius = 10
        buttonLeft1.layer.borderWidth = 3
        buttonLeft1.layer.borderColor = UIColor.white.cgColor
        buttonLeft1.backgroundColor = UIColor.white
        //        buttonLeft.setBackgroundImage(#imageLiteral(resourceName: "Fingerprint"), for: [])
        
        buttonRight1.backgroundColor = .clear
        buttonRight1.layer.cornerRadius = 10
        buttonRight1.layer.borderWidth = 3
        buttonRight1.layer.borderColor = UIColor.white.cgColor
        //        buttonRight.setBackgroundImage(#imageLiteral(resourceName: "Fingerprint"), for: [])
        
        buttonLeft2.backgroundColor = .clear
        buttonLeft2.layer.cornerRadius = 10
        buttonLeft2.layer.borderWidth = 3
        buttonLeft2.layer.borderColor = UIColor.white.cgColor
        buttonLeft2.backgroundColor = UIColor.white
        //        buttonLeft.setBackgroundImage(#imageLiteral(resourceName: "Fingerprint"), for: [])
        
        buttonRight2.backgroundColor = .clear
        buttonRight2.layer.cornerRadius = 10
        buttonRight2.layer.borderWidth = 3
        buttonRight2.layer.borderColor = UIColor.white.cgColor
        //        buttonRight.setBackgroundImage(#imageLiteral(resourceName: "Fingerprint"), for: [])
        
//        line1.layer.borderColor = UIColor.white.cgColor
//        line2.layer.borderColor = UIColor.white.cgColor
        
        line1.frame.origin.x = (screenSize.width / 2 ) - 15 - line1.frame.width
        line1.frame.origin.y = (screenSize.height / 2 )
        line2.frame.origin.x = (screenSize.width / 2 ) + 15
        line2.frame.origin.y = (screenSize.height / 2 )
        
        
//        line3.frame.origin.x = screenSize.width/2
//        line3.frame.origin.y = 0
//        line3.frame.size.width = 1
//        line3.frame.size.height = screenSize.height
//        line3.backgroundColor = UIColor.white
//        line3.layer.borderColor = UIColor.white.cgColor
        
        
//        imageView1.frame.size.height = screenSize.height * 0.25
//        imageView1.frame.size.width = imageView1.frame.size.height * ( 23 / 13 )
//        imageView1.center.x = self.view.center.x
//        NSLayoutConstraint(item: imageView1, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0).isActive = true
        imageView1.transform = imageView1.transform.rotated(by: CGFloat(Double.pi/2))
        
        
//        imageView2.frame.size.height = screenSize.height * 0.25
//        imageView2.frame.size.width = imageView2.frame.size.height * ( 23 / 13 )
//        imageView2.center.x = self.view.center.x
//        NSLayoutConstraint(item: imageView2, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0).isActive = true
       imageView2.transform = imageView2.transform.rotated(by: CGFloat(Double.pi*(3/2)))
        scoreDiff = 0
    }

    func initData() {
        replayButton.isHidden = true
    }
    
    
    func scoreUpdate () {
        if scoreDiff == 18 {
            player2Wins()
        }
        if scoreDiff == -18 {
            player1Wins()
        }
    }
    
    
    func restartGame () {
        replayButton.isHidden = true
        buttonLeft1.isEnabled = true
        buttonRight1.isEnabled = true
        buttonLeft2.isEnabled = true
        buttonRight2.isEnabled = true
        initUI()
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
