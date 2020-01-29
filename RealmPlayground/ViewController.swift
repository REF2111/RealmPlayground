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

    private var timer: Timer!

    @IBAction func saveOrSomething(_ sender: Any) {

        //        doRealmStuff()
//        download()
        startTimer()
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

        RealmManager.shared.add(myDog)
    }

    private func fetchAndDelete() {

        RealmManager.shared.deleteAll(Dog.self)
    }

    private func startTimer() {

        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] timer in
            self?.download()
        })
    }

    private func download() {

        let url = URL(string: "https://www.mocky.io/v2/5e31a2313200001e988886e8")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            do {
                let dog = try JSONDecoder().decode(Dog.self, from: data)
                dog.uuid = UUID().uuidString
                dog.parasite?.uuid = UUID().uuidString
                RealmManager.shared.add(dog)
            } catch {
                print(error)
            }
        }.resume()
    }

}

