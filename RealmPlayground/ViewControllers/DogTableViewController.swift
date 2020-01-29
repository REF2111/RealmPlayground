//
//  DogTableViewController.swift
//  RealmPlayground
//
//  Created by Raphael-Alexander Berendes on 29.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

import Realm
import RealmSwift

class DogTableViewController: UITableViewController {

    private var dogs: Results<Dog>!
    private var notificationToken: NotificationToken?

    override func viewDidLoad() {

        super.viewDidLoad()

        let realm = try! Realm()

        dogs = realm.objects(Dog.self).sorted(byKeyPath: Dog.primaryKey()! , ascending: true)
        notificationToken = dogs.observe { [weak self] changes in
            self?.tableView.applyChanges(changes: changes)
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dogs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let dog = dogs[indexPath.row]

        let cell = UITableViewCell()
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.minimumScaleFactor = 0.5
        cell.textLabel?.text = dog.uuid

        return cell
    }

}
