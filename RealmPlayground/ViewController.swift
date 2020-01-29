//
//  ViewController.swift
//  RealmPlayground
//
//  Created by Raphael-Alexander Berendes on 29.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

import RealmSwift

class ViewController: UIViewController {

    @IBAction func saveOrSomething(_ sender: Any) {

        //        doRealmStuff()
        download()
    }

    @IBAction func deleteSomething(_ sender: Any) {

        fetchAndDelete()
//        RealmManager.shared.deleteOnlyThis()
    }

    private func doRealmStuff() {

        let parasite = Parasite()
        parasite.name = "Wurm"
        parasite.age = 10

        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        myDog.parasite = parasite

        RealmManager.shared.add(dog: myDog)
    }

    private func fetchAndDelete() {

        RealmManager.shared.fetchAndDeleteDogs()
    }

    private func download() {

        let url = URL(string: "https://www.mocky.io/v2/5e31a2313200001e988886e8")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            do {
                let dog = try JSONDecoder().decode(Dog.self, from: data)
                RealmManager.shared.add(dog: dog)
            } catch {
                print(error)
            }
        }.resume()
    }

}

