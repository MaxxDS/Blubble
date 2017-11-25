//
//  BBViewControllerEnter2PlayersMode.swift
//  Blubble
//
//  Created by Maxime DeSaint on 29/08/2017.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import Foundation
import UIKit

class BBViewControllerEnter2PlayersMode: UIViewController {
    
    
    @IBOutlet var buttonRetour: UIButton!
    @IBOutlet var buttonPlay: UIButton!
    @IBOutlet var textFieldNombreDeCoupsDeDiffPourGagner: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldNombreDeCoupsDeDiffPourGagner.text = "10"
        textFieldNombreDeCoupsDeDiffPourGagner.textAlignment = .center
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "play2PlayersMode" {
            
            let destController : BBViewControllerPlayGround2Players = segue.destination as! BBViewControllerPlayGround2Players
 
            destController.nombreDeCoupsPourGagnerText = textFieldNombreDeCoupsDeDiffPourGagner.text!
 
        }
    }
    
    
    @IBAction func buttonPlayPressed(_ sender: Any) {

        if (checkIfNombreDeCoupsIsEmpty() == false){
            displayAlert (titleAlert: "Erreur", messageAlert: "Ce champ ne peut pas être vide")
        }
            
        else {
            textFieldNombreDeCoupsDeDiffPourGagner.resignFirstResponder()
            self.performSegue(withIdentifier: "play2PlayersMode", sender: nil)
        }
    }
    

    
    func checkIfNombreDeCoupsIsEmpty () -> Bool {
        if (textFieldNombreDeCoupsDeDiffPourGagner.text != ""){
            return true
        }
        else {
            return false
        }
    }
    
    func displayAlert (titleAlert: String, messageAlert: String) {
        let alertSignUp = UIAlertController(title: titleAlert ,
                                            message : messageAlert,
                                            preferredStyle: UIAlertControllerStyle.alert)
        
        alertSignUp.addAction(UIAlertAction(title: "OK",
                                            style: UIAlertActionStyle.default,
                                            handler: nil))
        
        self.present(alertSignUp, animated: true,
                     completion: nil)
    }
}

extension BBViewControllerEnter2PlayersMode: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            if (checkIfNombreDeCoupsIsEmpty() == false){
                displayAlert (titleAlert: "Erreur", messageAlert: "Ce champ ne peut pas être vide")
            }
                
            else {
                self.view.endEditing(true)
                self.performSegue(withIdentifier: "play2PlayersMode", sender: nil)
            }
        
        return true}
    
}








