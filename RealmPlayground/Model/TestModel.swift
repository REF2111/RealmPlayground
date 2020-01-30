//
//  TestModel.swift
//  RealmPlayground
//
//  Created by Raphael-Alexander Berendes on 29.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Foundation

import RealmSwift

class Dog: Object, Codable {

    @objc private(set) dynamic var uuid: String = String()
    @objc private(set) dynamic var name: String = String()
    @objc private(set) dynamic var age: Int = .zero
    @objc private(set) dynamic var parasite: Parasite?

    convenience init(name: String,
                     age: Int,
                     parasite: Parasite?) {

        self.init()
        self.uuid = UUID().uuidString
        self.name = name
        self.age = age
        self.parasite = parasite
    }

    override class func primaryKey() -> String? {

        let keyPath = \Dog.uuid
        return NSExpression(forKeyPath: keyPath).keyPath
    }

}

class Parasite: Object, Codable {

    @objc private(set) dynamic var uuid: String = String()
    @objc private(set) dynamic var name: String = String()
    @objc private(set) dynamic var age: Int = .zero

    convenience init(name: String,
                     age: Int) {

        self.init()
        self.uuid = UUID().uuidString
        self.name = name
        self.age = age
    }

    override class func primaryKey() -> String? {

        let keyPath = \Parasite.uuid
        return NSExpression(forKeyPath: keyPath).keyPath
    }

}
