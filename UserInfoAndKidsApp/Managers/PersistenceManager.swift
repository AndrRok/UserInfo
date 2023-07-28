//
//  PersistenceManager.swift
//  UserInfoAndKidsApp
//
//  Created by ARMBP
//

import UIKit
import RealmSwift


class Kids: Object {
    @Persisted dynamic var kidsName = ""
    @Persisted dynamic var kidsAge  = ""
}

class PersistenceManager {
    static let sharedRealm = PersistenceManager()
    
    private let realm = try! Realm()
    
    var item: Results<Kids> {return realm.objects(Kids.self)}
    
    func addKid(name: String, age: String){
        let kid  = Kids()
        kid.kidsName = name
        kid.kidsAge  = age
        try! realm.write{ realm.add(kid) }
    }
    
    func deleteKid(item: Kids){
        try! realm.write{ realm.delete(item) }
    }
    
    func deleteAll(){
        try! realm.write {realm.deleteAll()}
    }
    
}
