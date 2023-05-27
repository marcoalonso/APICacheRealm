//
//  MyDataObject.swift
//  APICacheRealm
//
//  Created by Marco Alonso Rodriguez on 26/05/23.
//

import Foundation
import RealmSwift

class MyDataObject: Object {
    @Persisted var data: Data?
}
