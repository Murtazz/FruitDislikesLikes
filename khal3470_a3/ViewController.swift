//
//  ViewController.swift
//  khal3470_a3
//
//  Created by Murtaza Khalid on 2023-02-04.
//

import UIKit

class ViewController: UIViewController {
    var sharedIndex = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var DislikeOutlet: UILabel!
    
    @IBOutlet weak var LikeOutlet: UILabel!
    
    @IBOutlet weak var FruitName: UILabel!
    
    @IBAction func Dislike(_ sender: UIButton) {
        var sharedFC = SharingFruitCollection.sharedFruitCollection.fruitCollection
        let noFruits = sharedFC?.collectionIsEmpty()
        if noFruits == false {
            sharedFC?.addDisLike()
            updateFruitView()
        }
    }
    
    @IBAction func Like(_ sender: UIButton) {
        var sharedFC = SharingFruitCollection.sharedFruitCollection.fruitCollection
        let noFruits = sharedFC?.collectionIsEmpty()
        if noFruits == false {
            sharedFC?.addLike()
            updateFruitView()
        }
    }
    
    @IBAction func Next(_ sender: UIButton) {
        SharingFruitCollection.sharedFruitCollection.fruitCollection?.goNextIndex()
        updateFruitView()
    }
    
    
    func updateFruitView() {
        // update view for no fruits left
        let sharedFC = SharingFruitCollection.sharedFruitCollection.fruitCollection
        let noFruits = sharedFC?.collectionIsEmpty()
        if noFruits == nil || noFruits == true {
            imageView.image = UIImage(named: "question.png")
            FruitName.text = "No fruit"
            LikeOutlet.text = "0"
            DislikeOutlet.text = "0"
        } else { // update view for existing fruits
            let fruit = sharedFC?.currentFruit()
            imageView.image = fruit?.fruitImage
            LikeOutlet.text = fruit?.likes.description
            DislikeOutlet.text = fruit?.disLikes.description
            FruitName.text = fruit?.fruitName
        }
        sharedIndex = (sharedFC?.getCurrentIndex()) ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _ = SharingFruitCollection()
        
        SharingFruitCollection.sharedFruitCollection.fruitCollection = FruitCollection()
        SharingFruitCollection.sharedFruitCollection.fruitCollection?.loadFruits()
        
        //when the app is launched for the first time this shared fruit collection is nil.
        if let i = UserDefaults.standard.integer(forKey: "currentIndex") as Int? {
            print("Fruits existed with index: \(i)")
            SharingFruitCollection.sharedFruitCollection.fruitCollection?.setCurrentIndex(to: i) // restore the fruit
            sharedIndex = i
        }
    
        // set up the view
        updateFruitView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // sharedFruitCollection is the singleton we want to work with
        let deleteViewController = tabBarController?.viewControllers?[2] as! DeleteViewController
        deleteViewController.sharedIndex = sharedIndex
        
        // Now display the info on the current fruit
        updateFruitView()
    }

}

