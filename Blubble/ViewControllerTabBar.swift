//
//  ViewControllerTabBar.swift
//  Blubble
//
//  Created by Maxime DeSaint on 5/8/17.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import UIKit

class ViewControllerTabBar: UIViewController, UITabBarDelegate {
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //This method will be called when user changes tab.
        print ("mmmmm")
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.delegate = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("the selected index is : \(tabBar.items?.index(of: item))")
//    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
