//
//  Shop.swift
//  GroceryAppTut
//
//  Created by Ahmed Gagan on 15/01/23.
//    var items: [[Any]] = DataManager.shopItems.map { item in
//            return [
//                item.imageName,
//                item.title,
//                item.price,
//                Color(item.color)
//            ]
//        }
    


//

import SwiftUI
import Firebase
import FirebaseFirestore

struct Shop: View {
    @State private var cartItems: [[Any]] = []
    @State private var navigateToProfile = false
    
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var items: [[Any]] {
        return DataManager.loadShopItems()
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                VStack {
                    Text("Good morning,")
                        .frame(width: 320, alignment: .leading)
                        .foregroundColor(.gray)
                    Text("Let's order fresh\nitems for you")
                        .font(.system(size: 38, weight: .semibold, design: .rounded))
                        .frame(width: 320, alignment: .leading)
                    
                    //Spacer().frame(height: 75)
//                    Text("Fresh Items")
//                        .frame(width: 320, alignment: .leading)
//                        .foregroundColor(.gray)
                }
                .padding(20)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(0..<items.count, id: \.self) { item in
                            ShopItem(imageName: items[item][0] as! String, title: items[item][1] as! String, price: items[item][2] as! Double, color: items[item][3] as! Color, selfIndex: item, cartItems: $cartItems)
                        }
                    }
                }
                .padding(15)
            }
            .navigationTitle("Shop")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button("Profile") {
                            navigateToProfile = true
                        }
                        Button("Referral") {
                            // Handle settings button tapped
                        }
                        Button("Notifications") {
                            // Handle logout button tapped
                        }
                        Button("Messages") {
                            // Handle logout button tapped
                        }
                        Button("Payment") {
                            // Handle logout button tapped
                        }
                        Button("Logout") {
                            // Handle logout button tapped
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Cart(cartItems: $cartItems)) {
                        Image(systemName: "cart")
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle()) // Add this modifier
            .background(
                NavigationLink(destination: Profile(), isActive: $navigateToProfile) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
}

struct Shop_Previews: PreviewProvider {
    static var previews: some View {
        Shop()
    }
}
