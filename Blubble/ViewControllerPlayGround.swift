//
//  ViewControllerPlayGround.swift
//  Blubble
//
//  Created by Maxime DeSaint on 5/5/17.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import UIKit

class ViewControllerPlayGround: UIViewController {
    
    @IBOutlet var countDownLabel: UILabel!
    
    @IBOutlet var gameOverLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    var score : Int = 0
    
    var count = 10
    
    var timer : Timer? = nil
    
    @IBOutlet var BlubblePicture: UIImageView!
    
    @IBOutlet var buttonLeft: UIButton!
    
    @IBAction func buttonLeftPressed(_ sender: Any) {
        if buttonLeft.backgroundColor == UIColor.myGreenColor() {
            buttonLeft.backgroundColor = UIColor.gray
            buttonRight.backgroundColor = UIColor.myGreenColor()
            
        }
    }
    
    
    @IBOutlet var buttonRight: UIButton!
    
    @IBAction func buttonRightPressed(_ sender: Any) {
        if (buttonLeft.backgroundColor == UIColor.gray) {
            buttonRight.backgroundColor = UIColor.gray
            buttonLeft.backgroundColor = UIColor.myGreenColor()
            BlubblePicture.frame.size.width = BlubblePicture.frame.size.width * 1.20
            BlubblePicture.frame.size.height = BlubblePicture.frame.size.height * 1.20
            BlubblePicture.center.x = self.view.center.x
            BlubblePicture.center.y = self.view.center.y
            score += 1
            scoreLabel.text = ("\(score)")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        
        countDownLabel.text = "\(count)"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewControllerPlayGround.update), userInfo: nil, repeats: true)

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
        
        
    }
    
    
    func initData() {
scoreLabel.text = ("\(score)")
        gameOverLabel.isHidden = true
        BlubblePicture.frame.size.width = 30
        BlubblePicture.frame.size.height = 30
    }
    
    
    func update() {
        
        if (count > 0) {
            count -= 1
            countDownLabel.text = ("\(count)")
            
        }
        
        if (count == 0){
            gameOver()
        }
        
    }
    
    func gameOver () {
        timer?.invalidate()
        timer = nil
        countDownLabel.isHidden = true
        gameOverLabel.isHidden = false
        buttonLeft.isEnabled = false
        buttonRight.isEnabled = false
        
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
