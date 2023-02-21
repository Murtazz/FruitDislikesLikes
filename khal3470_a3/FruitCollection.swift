//
//  FruitCollection.swift
//  khal3470_a3
//
//  Created by Murtaza Khalid on 2023-02-05.
//

import Foundation
import UIKit


struct FruitCollection {
    var collection = [Fruit]() // a collection is an array of fruits
    var current:Int = 0 // the current fruit in the collection (to be shown in the scene)
   
    var fileURL : URL {
        let documentDirectoryURL = try!
        FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectoryURL.appendingPathComponent ("Codable.file" )
    }
    
    init(){ // init is automatically called when you make an instance of the FruitCollection
            // You implement this function
            // Make a Fruit and append it to your FruitCollection
            // repeat as many times as you need, your collection should contain at least four fruits
        let fruits = ["Banana", "Pineapple", "Orange", "Kiwi"]
        for fruit in fruits {
            let fruitImg = UIImage(named: "\(fruit).jpg") ?? UIImage(named: "question.png") // update current to new UIImage
            collection.append(Fruit(fruitImage: fruitImg, fruitName: fruit, likes: 0, disLikes: 0)!)
        }
     } //init
  
   
    // return the current fruit
    func currentFruit() -> Fruit {
        let fruit = collection[current]
        return fruit
    }
 
    // return the index of the current fruit
    mutating func setCurrentIndex(to index: Int) { // you may need this function for
        // relaunching the app
        self.current = index
    }
   
          // return the index of the current fruit in the collection
    func getCurrentIndex() -> Int {
        return current
    } // getCurrentIndex
    
    func collectionIsEmpty() -> Bool { // checks if collection is empty
        return collection.isEmpty
    }
    
    mutating func goNextIndex() { // go to the next index
        var i = getCurrentIndex()
        if (i+1 >= collection.count) {
            i = 0
        } else {
            i = i + 1
        }
        setCurrentIndex(to: i)
    }
    
    mutating func addLike() { // adding 1 like
        let fruit = currentFruit()
        fruit.likes = fruit.likes + 1
        replaceCurrentFruit(fruit: fruit)
    }
    
    mutating func addDisLike() { // adding 1 dislike
        let fruit = currentFruit()
        fruit.disLikes = fruit.disLikes + 1
        replaceCurrentFruit(fruit: fruit)
    }
    mutating func replaceCurrentFruit(fruit: Fruit) { // replacing fruit at the current index
        let i = getCurrentIndex()
        self.collection[i] = fruit
    }
    
    mutating func deleteCurrentFruit() { // deletes current fruit
        let i = getCurrentIndex()
        self.collection.remove(at: i)
        goNextIndex()
    }
    
    mutating func addFruit(named: String, fruitImage: UIImage?) { // adding new fruit
        self.collection.append(Fruit(fruitImage: fruitImage, fruitName: named, likes: 0, disLikes: 0)!)
    }
    
    func saveFruits() { // encoder
        
        let jsonEncoder = JSONEncoder()
        var jsonData = Data()
        do {
            jsonData = try jsonEncoder.encode(collection)
        }
        catch {
            print("cannot encode")
        }
        do {
            try jsonData.write(to: fileURL, options: [])
        } catch {
            print ("cannot write")
        }
    }
    
    mutating func loadFruits() { // decoder
        
        let jsonDecoder = JSONDecoder()
        
        var data = Data()
        do {
            data = try Data(contentsOf: fileURL)
        } catch {
            print ("cannot read the archive")
        }
        do {
            collection = try jsonDecoder.decode([Fruit].self, from: data)
        } catch {
            print("cannot decode the person from the archive")
        }
        
        
    }
    
    // used for reseting to the first 4 fruits
    mutating func reset() {
        let fruits = ["Banana", "Pineapple", "Orange", "Kiwi"]
        collection = [Fruit]()
        //let fruitPics = ["Banana.jpg", "Pineapple.jpg", "Orange.jpg", "Kiwi.jpg", "Strawberry.jpg"]
        for fruit in fruits {
            let fruitImg = UIImage(named: "\(fruit).jpg") ?? UIImage(named: "question.png") // update current to new UIImage
            collection.append(Fruit(fruitImage: fruitImg, fruitName: fruit, likes: 0, disLikes: 0)!)
        }
        
    }
    
 // other helper functions you may need when relaunching the app
    
} // FruitCollection
