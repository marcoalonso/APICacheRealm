//
//  BankObjectModel.swift
//  APICacheRealm
//
//  Created by Marco Alonso Rodriguez on 26/05/23.
//

import Foundation
import RealmSwift


struct BankObject : Codable {
    let description: String
    let age: Int
    let url: String
    let bankName: String
}


