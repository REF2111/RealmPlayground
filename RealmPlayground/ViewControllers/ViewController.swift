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

    private var timer: Timer?

    @IBAction func saveOrSomething(_ sender: Any) {

        var dogs = [Dog]()
        for _ in 1...1000 {
            let parasite = Parasite(name: "Pary", age: 915)
            let dog = Dog(name: "Doggy", age: 1, parasite: parasite)

            dogs.append(dog)
        }
        RealmManager.shared.addOrUpdate(dogs)

        startTimer()
    }

    @IBAction func deleteSomething(_ sender: Any) {

        RealmManager.shared.deleteAll(Dog.self)
    }

    private func startTimer() {

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] timer in

            let parasite = Parasite(name: "Pary", age: 915)
            let dog = Dog(name: "Doggy", age: 1, parasite: parasite)
            RealmManager.shared.addOrUpdate(dog)

            self?.download()
        })
        timer?.fire()
    }

    private func download() {

        let url = URL(string: "https://www.mocky.io/v2/5e31a2313200001e988886e8")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            do {
                let dog = try JSONDecoder().decode(Dog.self, from: data)
                RealmManager.shared.addOrUpdate(dog)
            } catch {
                print(error)
            }
        }.resume()
    }

}

