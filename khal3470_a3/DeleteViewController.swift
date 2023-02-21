//
//  DeleteViewController.swift
//  khal3470_a3
//
//  Created by Murtaza Khalid on 2023-02-12.
//

import UIKit

class DeleteViewController: UIViewController {
    
    var sharedIndex = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var fruitName: UILabel!
    
    func createAlert(title: String, message: String, actTitle: String) { // alert creator for multiple use
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: actTitle, style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func Delete(_ sender: UIButton) { // delete current fruit
        let sharedFC = SharingFruitCollection.sharedFruitCollection.fruitCollection
        let noFruits = sharedFC?.collectionIsEmpty()
        let OK = "OK"
        if noFruits == nil || noFruits == true {
            let noFruitTitle = "No Fruit Left"
            let noFruitMsg = "No fruits to delete"
            createAlert(title: noFruitTitle, message: noFruitMsg, actTitle: OK)
        } else {
            let deletedFruit = sharedFC?.currentFruit().fruitName
            let deletedFruitTitle = "Deleting a Fruit"
            let deletedFruitMsg = "The fruit \(deletedFruit ?? "") is deleted"
            createAlert(title: deletedFruitTitle, message: deletedFruitMsg, actTitle: OK)
            
            SharingFruitCollection.sharedFruitCollection.fruitCollection?.deleteCurrentFruit()
            updateFruitView()
        }
    }
    
    @IBAction func Next(_ sender: UIButton) { // go next
        SharingFruitCollection.sharedFruitCollection.fruitCollection?.goNextIndex()
        updateFruitView()
    }
    
    
    func updateFruitView() { // update view
        let sharedFC = SharingFruitCollection.sharedFruitCollection.fruitCollection
        let noFruits = sharedFC?.collectionIsEmpty()
        if noFruits == nil || noFruits == true { // update with no fruit if empty
            imageView.image = UIImage(named: "question.png")
            fruitName.text = "No fruit"
        } else {
            let fruit = sharedFC?.currentFruit()
            imageView.image = fruit?.fruitImage
            fruitName.text = fruit?.fruitName
        }
        sharedIndex = (sharedFC?.getCurrentIndex()) ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //let sharedFC = SharingFruitCollection.sharedFruitCollection.fruitCollection
        
        let favViewController = tabBarController?.viewControllers?[0] as! ViewController
        favViewController.sharedIndex = sharedIndex

        // Now display the info on the current fruit
        updateFruitView()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
