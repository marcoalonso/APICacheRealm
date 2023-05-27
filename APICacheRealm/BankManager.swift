//
//  BankManager.swift
//  APICacheRealm
//
//  Created by Marco Alonso Rodriguez on 26/05/23.
//

import Foundation
import RealmSwift

struct BankManager {
    
    func getListOfBanks(completion: @escaping(_ listBanks: [BankObject]?, _ error: Error?) -> () ) {
        //URL
        guard let url = URL(string: "https://dev.obtenmas.com/catom/api/challenge/banks") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            //safe unwrapp
            guard let data = data else { return }
            
            saveDataToDataBase(data: data)
            
            if let listOfBanks = parseData(data: data) {
            completion(listOfBanks, nil)
            }
            
        }.resume()
    }
    
    private func saveDataToDataBase(data: Data) {
        //Save to DB
        let realm = try! Realm()
        let myObject = MyDataObject()
        
        myObject.data = data
        
        do {
            try realm.write {
                realm.add(myObject)
                print("Data Saved!")
            }
        } catch {
            print("Debug: error saving data \(error.localizedDescription)")
        }
    }
    
    func getListOfBanksFromCache(completion: @escaping(_ listBanks: [BankObject]?, _ error: Error?) -> () ) {
        let realm = try! Realm()
        
        let listOfBanksData = realm.objects(MyDataObject.self)
        
        for bank in listOfBanksData {
            ///Recupera la data
            if let data = bank.data {
                if let listOfBanks = parseData(data: data) {
                    completion(listOfBanks, nil)
                }
            }
        }
    }
    
    private func parseData(data: Data) -> [BankObject]? {
        do {
            let listBanks = try JSONDecoder().decode([BankObject].self, from: data)
            return listBanks
        } catch {
            print("Error al decodifica  o mapear el JSON \(error.localizedDescription)")
            return nil
        }
    }
}

