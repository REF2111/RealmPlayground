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
    private var persons = [Person]()

    @IBAction func saveOrSomething(_ sender: Any) {

        let person = Person(name: "Hansi", age: 34, dogs: List<Dog>())
        for _ in 1...5 {
            let parasite = Parasite(name: "Pary", age: 915)
            let dog = Dog(name: "Doggy", age: 1, parasite: parasite, owner: person)
            let dogTwo = Dog(name: "Doggy", age: 1, parasite: parasite, owner: person)
            let dogThree = Dog(name: "Doggy", age: 1, parasite: parasite, owner: person)
            let dogFour = Dog(name: "Doggy", age: 1, parasite: parasite, owner: person)

            person.dogs.append(dog)
            person.dogs.append(dogTwo)
            person.dogs.append(dogThree)
            person.dogs.append(dogFour)

        }
        RealmManager.shared.addOrUpdate(person)
        persons.append(person)

        startTimer()
    }

    @IBAction func deleteSomething(_ sender: Any) {

        RealmManager.shared.deleteAll(Person.self)

//        persons.forEach { person in
//            RealmManager.shared.deleteAllDogs(forPersonUuid: person.uuid)
//        }
    }

    private func startTimer() {

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] timer in

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

