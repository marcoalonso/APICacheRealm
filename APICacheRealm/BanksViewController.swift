//
//  ViewController.swift
//  APICacheRealm
//
//  Created by Marco Alonso Rodriguez on 26/05/23.
//

import UIKit
import RealmSwift

class BanksViewController: UIViewController {
    
    var banks: [BankObject] = []
    
    @IBOutlet weak var banksTableView: UITableView!
    
    
    var manager = BankManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        banksTableView.delegate = self
        banksTableView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        banks.removeAll()
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
                self?.banks = listBanks
                
                DispatchQueue.main.async {
                    self?.banksTableView.reloadData()
                }
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
                self?.banks = listBanks
                
                DispatchQueue.main.async {
                    self?.banksTableView.reloadData()
                }
            }
        }
    }
    

}

extension BanksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = banks[indexPath.row].bankName
        cell.detailTextLabel?.text = banks[indexPath.row].description
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailBank", sender: self)
    }
    
}
