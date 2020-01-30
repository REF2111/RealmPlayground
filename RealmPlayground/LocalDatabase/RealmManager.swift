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

    func all<T: Object>(_ object: T.Type) -> Results<T> {

        let realm = try! Realm()

        return realm.objects(object)
    }
    
    func addOrUpdate<T: Object>(_ object: T) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: .modified)
        }
    }

    func addOrUpdate<T: Object>(_ objects: [T]) {

        let realm = try! Realm()
        try! realm.write {
            realm.add(objects, update: .modified)
        }
    }

    func deleteAll<T: Object>(_ object: T, cascading: Bool = true) {

        let realm = try! Realm()
        try! realm.write {
            realm.delete(object, cascading: cascading)
        }
    }
    
    func deleteAll<T: Object>(_ object: T.Type, cascading: Bool = true) {
        
        let realm = try! Realm()
        let objects = realm.objects(object)
        
        try! realm.write {
            realm.delete(objects, cascading: cascading)
        }
    }
    
}
