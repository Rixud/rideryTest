//
//  UserViewModel.swift
//  RideryTest
//
//  Created by Luis Guerra on 15/6/23.
//

import Foundation

class UserViewModel {
    var userData:UserModel?
    
    func getTestUser() -> UserModel {
        return UserModel(userName: "luis", email: "lgdm@test.com", phoneNumber: "04145555555", profilePictureURL: nil)
    }
}
