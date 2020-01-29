//
//  RealmManager.swift
//  RealmPlayground
//
//  Created by Raphael-Alexander Berendes on 29.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Foundation

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    private init() {}
    
    func add<T: Object>(_ object: T) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func deleteAll<T: Object>(_ object: T.Type, cascading: Bool = true) {
        
        let realm = try! Realm()
        let dogs = realm.objects(object)
        
        try! realm.write {
            realm.delete(dogs, cascading: cascading)
        }
    }
    
}
