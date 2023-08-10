import SwiftUI
import Firebase
import FirebaseDatabase





struct ContentView: View {
    @State private var showSignIn = false
    @State private var showSignUp = false

   

    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Image("avocado")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Text("We deliver\n grocery at your\n doorstep")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                Text("Grocerr gives you fresh vegetables and fruits,\nOrder fresh at grocerr")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                Button("Sign In") {
                    showSignIn = true
                }
                Button("Sign Up") {
                    showSignUp = true
                }
                
            }
            .sheet(isPresented: $showSignIn) {
                SignInView(navigateToShop: navigateToShop)
            }
            .sheet(isPresented: $showSignUp) {
                SignUpView(navigateToShop: navigateToShop)
            }
        }
        .onAppear {
            FirebaseApp.configure()
            
        }
    }

    private func navigateToShop() {
        showSignIn = false
        showSignUp = false
        let shopView = Shop()
        let shopNavigation = UINavigationController(rootViewController: UIHostingController(rootView: shopView))
        shopNavigation.navigationBar.prefersLargeTitles = true
        UIApplication.shared.windows.first?.rootViewController = shopNavigation
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}



struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    var navigateToShop: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign In")
                .font(.title)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Sign In") {
                signIn()
            }
            Text(errorMessage)
                .foregroundColor(.red)
        }
        .padding()
    }

    private func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                navigateToShop()
            }
        }
    }
}

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    var navigateToShop: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .font(.title)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Sign Up") {
                signUp()
            }
            Text(errorMessage)
                .foregroundColor(.red)
        }
        .padding()
    }

    private func signUp() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                navigateToShop()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
