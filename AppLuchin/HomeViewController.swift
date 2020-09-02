//
//  HomeViewController.swift
//  AppLuchin
//
//  Created by Raul Kevin Aliaga Shapiama on 9/1/20.
//  Copyright © 2020 Raul Kevin Aliaga Shapiama. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

enum ProviderType: String {
    case basic
    case google
}

class HomeViewController: UIViewController {

    @IBOutlet weak var emaillABEL: UILabel!
    @IBOutlet weak var PROVIDERlABEL: UILabel!
    @IBOutlet weak var closeSessionButton: UIButton!
    
    private let email: String
    private let provider: ProviderType
    
    init(email:String, provider: ProviderType) {
        self.email = email
        self.provider = provider
        super.init(nibName:"HomeViewController", bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Inicio"
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        emaillABEL.text = email
        PROVIDERlABEL.text = provider.rawValue
        
        //Guardamos los datos del usuario
        
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeSessionButtonAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        switch provider {
        case .basic:
            firebaseLogoOut()
        case  .google:
            GIDSignIn.sharedInstance()?.signOut()
            firebaseLogoOut()
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func firebaseLogoOut(){
        do{
            try Auth.auth().signOut()
            
        } catch{
            //Se ah producido un error
        }
    }
}
