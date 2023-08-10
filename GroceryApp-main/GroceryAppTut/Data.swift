//
//  Data.swift
//  GroceryAppTut
//
//  Created by Ahmed Gagan on 15/01/23.
//



//
//import SwiftUI
//import Firebase
//
//var shopItems: [[Any]] = [
//    ["avocado", "Avocado", 4.00, Color.green],
//    ["banana", "Banana", 2.50, Color.yellow],
//    ["chicken", "Chicken", 12.80, Color.red],
//    ["water", "Water", 1.00, Color.blue],
//    ["carrot", "carrot", 1.00, Color.blue],
//    ["tomato", "tomato", 1.00, Color.blue],
//    ["potato", "potato", 1.00, Color.blue],
//    ["cilantro", "cilantro", 1.00, Color.blue]
//]
//
//var cartItems: [[Any]] = [
//
//]

import SwiftUI
import Foundation

struct GroceryItem: Hashable, Decodable {
    let imageName: String
    let title: String
    let price: Double
    let color: String
    let quantityLimit: Int
}

class DataManager {
    static var shopItems: [GroceryItem] = []

    static func loadShopItems() -> [[Any]] {
        var items: [[Any]] = []
        
        if let fileURL = Bundle.main.url(forResource: "shopItems", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                self.shopItems = try decoder.decode([GroceryItem].self, from: data)
                
                items = self.shopItems.map { item in
                    return [
                        item.imageName,
                        item.title,
                        item.price,
                        Color(item.color),
                        item.quantityLimit
                    ]
                }
                
                print("shopItems")
                print(items)
            } catch {
                print("Error loading shopItems: \(error)")
            }
        }
        
        return items
    }
}

var cartItems: [[Any]] = []

let shopItems: [[Any]] = DataManager.loadShopItems()
