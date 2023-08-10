//
//  Profile.swift
//  GroceryAppTut
//
//  Created by Akhil Santha on 7/11/23.
//

import SwiftUI

struct Profile: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var street = ""
    @State private var houseNumber = ""
    @State private var city = ""
    @State private var district = ""
    @State private var state = ""
    @State private var pincode = ""
    @State private var profileImage: Image? = nil

    var body: some View {
        VStack {
            if let image = profileImage {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            }

            Text("Profile Page")
                .font(.title)
                .padding()

            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    TextField("Phone", text: $phone)
                }

                Section(header: Text("Address")) {
                    TextField("Street", text: $street)
                    TextField("House Number", text: $houseNumber)
                    TextField("City", text: $city)
                    TextField("District", text: $district)
                    TextField("State", text: $state)
                    TextField("Pincode", text: $pincode)
                }

                Section {
                    Button("Save Profile") {
                        saveProfileDetails()
                    }
                }
            }
        }
        .onAppear {
            loadProfileDetails()
        }
    }

    private func saveProfileDetails() {
        // Save the profile details to UserDefaults or other storage solution
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(phone, forKey: "phone")
        UserDefaults.standard.set(street, forKey: "street")
        UserDefaults.standard.set(houseNumber, forKey: "houseNumber")
        UserDefaults.standard.set(city, forKey: "city")
        UserDefaults.standard.set(district, forKey: "district")
        UserDefaults.standard.set(state, forKey: "state")
        UserDefaults.standard.set(pincode, forKey: "pincode")
        UserDefaults.standard.synchronize()
    }

    private func loadProfileDetails() {
        // Retrieve the profile details from UserDefaults or other storage solution
        if let storedName = UserDefaults.standard.string(forKey: "name") {
            name = storedName
        }
        if let storedEmail = UserDefaults.standard.string(forKey: "email") {
            email = storedEmail
        }
        if let storedPhone = UserDefaults.standard.string(forKey: "phone") {
            phone = storedPhone
        }
        if let storedStreet = UserDefaults.standard.string(forKey: "street") {
            street = storedStreet
        }
        if let storedHouseNumber = UserDefaults.standard.string(forKey: "houseNumber") {
            houseNumber = storedHouseNumber
        }
        if let storedCity = UserDefaults.standard.string(forKey: "city") {
            city = storedCity
        }
        if let storedDistrict = UserDefaults.standard.string(forKey: "district") {
            district = storedDistrict
        }
        if let storedState = UserDefaults.standard.string(forKey: "state") {
            state = storedState
        }
        if let storedPincode = UserDefaults.standard.string(forKey: "pincode") {
            pincode = storedPincode
        }
    }
}


struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
