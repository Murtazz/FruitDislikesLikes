//
//  AddViewController.swift
//  khal3470_a3
//
//  Created by Murtaza Khalid on 2023-02-11.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textView: UITextField!
    
    @IBAction func tap(_ sender: Any) {
        textView.resignFirstResponder()
    }
  
    func getText() -> String { // get text in textView and clearing the box
        let out: String = textView.text!
        textView.text = ""
        return out
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // keyboard Return button dismisses keyboard
        self.view.endEditing(true)
        return false
    }
    
    func getImage() -> UIImage { // gets image from UIImageView and defaults back to "?" image
        let out: UIImage = imageView.image!
        imageView.image = UIImage(named: "question.png")
        return out
    }
    
    func createAlert(title: String, message: String, actTitle: String) { // alert creator for multiple use
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: actTitle, style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func Add(_ sender: UIButton) { // adds new fruit
        
        let text = getText()
        
        let OK = "OK"
        
        if text.isEmpty { // fruit not added without name
            let noFruitTitle = "No Fruit Added"
            let noNameMsg = "The fruit name cannot be empty"
            createAlert(title: noFruitTitle, message: noNameMsg, actTitle: OK)
        } else {
            let img = getImage()
            let fruitAdded = "Fruit Added"
            let addedMsg = "The fruit \(text) is added"
            createAlert(title: fruitAdded, message: addedMsg, actTitle: OK)
            
            SharingFruitCollection.sharedFruitCollection.fruitCollection?.addFruit(named: text, fruitImage: img)
        }
        
    }
    
    @objc func imageTapped(gesture: UITapGestureRecognizer) { // UIImage tapped, open image picker
        if (gesture.view as? UIImageView) != nil {
            print("UIImageView tapped")
            let imgPickerController = UIImagePickerController()
            imgPickerController.sourceType = .photoLibrary
            imgPickerController.delegate = self

            present(imgPickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss (animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple
        //representations of the image. You want to use the original.
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        // Dismiss the picker.
        dismiss (animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        imageView.addGestureRecognizer(tapGR)
        imageView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: "question.png")
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
