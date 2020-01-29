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
    private let dispatchQueue = RealmDispatchQueueProvider().dispatchQueue
    
    private init() {}
    
    func add(dog: Dog) {
        
        dog.uuid = UUID().uuidString
        let realm = try! Realm()
        try! realm.write {
            realm.add(dog, update: .modified)
        }
    }
    
    func fetchAndDeleteDogs() {
        
        let realm = try! Realm()
        let dogs = realm.objects(Dog.self)
        
        try! realm.write {
            realm.delete(dogs, cascading: true)
        }
    }
    
    func deleteOnlyThis() {
        
        let realm = try! Realm()
        let dogs = realm.objects(Dog.self)
        if let myDog = dogs.first(where: { $0.uuid == "B71E2D51-BCC3-4133-938A-3719D20B334F" }) {
            
            try! realm.write {
                realm.delete(myDog, cascading: true)
            }
        }
    }
    
}
