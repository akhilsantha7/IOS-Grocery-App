//
//  Cart.swift
//  GroceryAppTut
//
//  Created by Ahmed Gagan on 15/01/23.
//

import SwiftUI

struct Cart: View {
    @Binding var cartItems: [[Any]]
    
    var body: some View {
        VStack {
            Text("My Cart")
                .font(.system(size: 44, weight: .semibold, design: .rounded))
                .frame(width: 320, alignment: .leading)
            
            List {
                ForEach(0..<cartItems.count, id: \.self) { index in
                    HStack {
                        Image(cartItems[index][0] as! String)
                            .resizable()
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(cartItems[index][1] as! String)
                            HStack {
                                Text("Quantity: \(cartItems[index][3] as! Int)")
                                    .foregroundColor(.gray)
                                Text("Price: $\(calculateItemTotalPrice(index: index))")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    cartItems.remove(atOffsets: indexSet)
                }
            }
            
            Spacer()
            
            VStack {
                HStack {
                    Spacer()
                    Text("Total Price")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.trailing, 60)
                }
                
                HStack {
                    Spacer()
                    Text("$\(String(format: "%.2f", calculateTotalPrice()))")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .bold))
                        .padding(.trailing, 60)
                }
                
                Button(action: {}) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder()
                            .frame(width: 120, height: 50)
                            .foregroundColor(.white)
                        
                        Text("Checkout >")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .padding(.top, 20)
                .offset(x: 80)
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.green)
                    .opacity(0.8)
                    .padding(.horizontal, 20)
            )
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
    }
    
    func calculateItemTotalPrice(index: Int) -> Double {
        let price = cartItems[index][2] as! Double
        let quantity = cartItems[index][3] as! Int
        return price * Double(quantity)
    }
    
    func calculateTotalPrice() -> Double {
        var totalPrice = 0.0
        for item in cartItems {
            let price = item[2] as! Double
            let quantity = item[3] as! Int
            totalPrice += price * Double(quantity)
        }
        return totalPrice
    }
}



struct Cart_Previews: PreviewProvider {
    @State static var cartItems: [[Any]] = []
    
    static var previews: some View {
        Cart(cartItems: $cartItems)
    }
}
