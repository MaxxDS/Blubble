//
//  ViewControllerEnter2PlayersMode.swift
//  Blubble
//
//  Created by Maxime DeSaint on 29/08/2017.
//  Copyright © 2017 Maxime DeSaint. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerEnter2PlayersMode: UIViewController {
    
    
    @IBOutlet var retourButton: UIButton!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var nombreDeCoupsTextField: UITextField!
    
    @IBAction func playButtonPressed(_ sender: Any) {
        
        
        if (checkIfNombreDeCoupsIsEmpty() == false){
            displayAlert (titleAlert: "Erreur", messageAlert: "Ce champ ne peut pas être vide")
        }
            
        else {
            nombreDeCoupsTextField.resignFirstResponder()
            self.performSegue(withIdentifier: "play2PlayersMode", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreDeCoupsTextField.text = "10"
        nombreDeCoupsTextField.textAlignment = .center
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "play2PlayersMode" {
            
            
            let destController : ViewControllerPlayGround2Players = segue.destination as! ViewControllerPlayGround2Players
            // on recupere le controller de destination
            
            
            
            destController.nombreDeCoupsPourGagnerText = nombreDeCoupsTextField.text!
            
            // destController.currentCategorie = currentCategorie
            
            
            // et on le preconfigure, c a d qu'on lui attribue des valeurs
            
            
        }
    }
    
    func checkIfNombreDeCoupsIsEmpty () -> Bool {
        if (nombreDeCoupsTextField.text != ""){
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

extension ViewControllerEnter2PlayersMode: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        
        // cet evenement est appele quand on appuie sur le bouton return d'un keyboard. Il envoie en parametre le textField sur lequel on a appuye return
        
        //textField.becomeFirstResponder()
        //        if textField.tag == 0 {

            if (checkIfNombreDeCoupsIsEmpty() == false){
                displayAlert (titleAlert: "Erreur", messageAlert: "Ce champ ne peut pas être vide")
            }
                
            else {
                self.view.endEditing(true)
//                nombreDeCoupsTextField.resignFirstResponder()
                self.performSegue(withIdentifier: "play2PlayersMode", sender: nil)
            }
        return true}
    
}

//        else if textField.tag == 1 {
//            if (checkIfMotDePasseIsEmpty () == false){
//                displayAlert (titleAlert: "Erreur", messageAlert: "Le mot de passe ne peut pas être vide")
//            }
//                // je suis sur le premier textField
//            else {tfRetaperMotDePasse.becomeFirstResponder()
//            }
//        }
//        else {
//            print ("j ai appuyé sur suivant depuis le champ retaper l email")
//            tfRetaperMotDePasse.resignFirstResponder()
//            signUpRequest()
//
//        }







