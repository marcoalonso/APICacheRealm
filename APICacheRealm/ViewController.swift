//
//  ViewController.swift
//  APICacheRealm
//
//  Created by Marco Alonso Rodriguez on 26/05/23.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var listOfBanks: UITextView!
    
    
    var manager = BankManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        listOfBanks.text = ""
        getDataFromCacheOrFromAPIOnce()
    }
    
    
    func getDataFromCacheOrFromAPIOnce() {
        if !UserDefaults.standard.bool(forKey: "cacheBanks") {
            getBanks()
            UserDefaults.standard.set(true, forKey: "cacheBanks")
        }
        
        manager.getListOfBanksFromCache { [weak self] listBanks, error in
            if error != nil {
                print("Error getting data!")
            }
            
            if let listBanks = listBanks {
                print("List of banks from cache: \(listBanks)")
                self?.listOfBanks.text = "List of banks from cache:: \(listBanks)"
            }
        }
    }
    
    

    func getBanks(){
        manager.getListOfBanks { [weak self] listBanks, error in
            if error != nil {
                print("Error getting data!")
            }
            
            if let listBanks = listBanks {
                print("List of banks: \(listBanks)")
                self?.listOfBanks.text = "List of banks: \(listBanks)"
            }
        }
    }
    

}


