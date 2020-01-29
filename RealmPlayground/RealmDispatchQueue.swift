//
//  RealmDispatchQueue.swift
//  RealmPlayground
//
//  Created by Raphael-Alexander Berendes on 29.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Foundation

class RealmDispatchQueueProvider {

    let dispatchQueue: DispatchQueue!

    init() {
        dispatchQueue = DispatchQueue(label: "background")
    }

}
