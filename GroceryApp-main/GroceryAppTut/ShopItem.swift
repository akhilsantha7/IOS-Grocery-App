import SwiftUI

struct ShopItem: View {
    var imageName: String
    var title: String
    var price: Double
    var color: Color
    var selfIndex: Int
    @Binding var cartItems: [[Any]]
    
    @State private var quantity = 0
    
    var body: some View {
        VStack(spacing: 5) {
            Image(imageName)
                .resizable()
                .frame(width: 100, height: 100)
            
            Text(title)
                .font(.headline)
            
            Text("₹\(String(format: "%.2f", price))")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Button(action: {
                    decrementQuantity()
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(color)
                            .frame(width: 30, height: 30)
                        Image(systemName: "minus")
                            .foregroundColor(.gray)
                    }
                }
                
                Text("\(quantity)")
                
                Button(action: {
                    incrementQuantity()
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(color)
                            .frame(width: 30, height: 30)
                        Image(systemName: "plus")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.top, 8)
            .font(.subheadline)
            .buttonStyle(BorderlessButtonStyle())
            
            Button(action: {
                addToCart()
            }) {
                Text("Add")
                    .foregroundColor(.green)
                    .frame(width: 120, height: 40)
                    .background(color)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 2)
    }
    
    func incrementQuantity() {
        quantity += 1
    }
    
    func decrementQuantity() {
        if quantity > 0 {
            quantity -= 1
        }
    }
    
    func addToCart() {
        if quantity > 0 {
            if let index = cartItems.firstIndex(where: { $0[0] as! String == imageName }) {
                // Item already exists in the cart, increment quantity
                cartItems[index][3] = (cartItems[index][3] as! Int) + quantity
            } else {
                // Item doesn't exist in the cart, add new item
                let newItem: [Any] = [imageName, title, price, quantity]
                cartItems.append(newItem)
            }
            quantity = 0
        }
    }
}


struct ShopItem_Previews: PreviewProvider {
    static var previews: some View {
        let cartItems: Binding<[[Any]]> = .constant([])
        return ShopItem(imageName: "avocado", title: "Avocado", price: 4.00, color: Color.green, selfIndex: 0, cartItems: cartItems)
    }
}

