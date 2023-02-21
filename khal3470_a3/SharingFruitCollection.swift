//
//  SharingFruitCollection.swift
//  khal3470_a3
//
//  Created by Murtaza Khalid on 2023-02-12.
//

import Foundation

import Foundation
 
class SharingFruitCollection {
    static let sharedFruitCollection = SharingFruitCollection()
    var fruitCollection : FruitCollection?
 
    // method to restore the fruit collection from a file
    func loadFruitCollection() {
        fruitCollection?.loadFruits()
    }

    // method to save the fruit collection to a file
    func saveFruitCollection() {
        //fruitCollection?.reset()
        fruitCollection?.saveFruits()
    }
}
