//
//  UserModel.swift
//  RideryTest
//
//  Created by LuisGuerra on 14/6/23.
//

import Foundation

class UserModel:Codable {
    
    var userName:String
    var email:String
    var phoneNumber:String
    var profilePictureURL:URL?
    
    init(userName: String, email: String, phoneNumber: String, profilePictureURL: URL?) {
        self.userName = userName
        self.email = email
        self.phoneNumber = phoneNumber
        self.profilePictureURL = profilePictureURL
    }
        
}
