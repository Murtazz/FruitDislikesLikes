//
//  Fruit.swift
//  khal3470_a3
//
//  Created by Murtaza Khalid on 2023-02-05.
//

import Foundation
import UIKit
 
class Fruit: Codable {
    let fruitImage : UIImage? // Need to make this property Codable
    let fruitName : String
    var likes : Int
    var disLikes : Int
    
    // We need the init function for this custom Fruit object
    init?(fruitImage: UIImage?, fruitName: String, likes: Int, disLikes: Int){
        guard !fruitName.isEmpty else {
            return nil
        }
        
        self.fruitImage = fruitImage
        self.fruitName = fruitName
        self.likes  = likes
        self.disLikes = disLikes
    } //init?
    
    //MARK: Codable functions
    
    public enum CodingKeys: String, CodingKey {
        case fruitImage // we want to encode the photo property
        case fruitName
        case likes
        case disLikes
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // decoding the image property of the object
        let imageData = try container.decode(Data.self, forKey: .fruitImage)
        self.fruitImage = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(imageData) as? UIImage
        
        // decoding the name property
        let nameData = try container.decode(Data.self, forKey: .fruitName)
        self.fruitName = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(nameData) as? String ?? "no fruit name"
        
        let likesData = try container.decode(Data.self, forKey: .likes)
        self.likes = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(likesData) as? Int ?? 0
        
        let disLikesData = try container.decode(Data.self, forKey: .disLikes)
        self.disLikes = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(disLikesData) as? Int ?? 0
    } // decoder
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let imageData = try NSKeyedArchiver.archivedData(withRootObject: fruitImage ?? UIImage(named: "question-mark.jpg")!, requiringSecureCoding: true)
        try container.encode(imageData, forKey: .fruitImage)
        
        let nameData = try NSKeyedArchiver.archivedData(withRootObject: fruitName, requiringSecureCoding: true)
        try container.encode(nameData, forKey: .fruitName)
        
        let likesData = try NSKeyedArchiver.archivedData(withRootObject: likes, requiringSecureCoding: true)
        try container.encode(likesData, forKey: .likes)
        
        let disLikesData = try NSKeyedArchiver.archivedData(withRootObject: disLikes, requiringSecureCoding: true)
        try container.encode(disLikesData, forKey: .disLikes)
        
    }
    
    //MARK: Helper functions to manage the vars such as likes, disLikes,etc.
}
