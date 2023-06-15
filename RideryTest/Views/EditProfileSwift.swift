//
//  EditProfileSwift.swift
//  RideryTest
//
//  Created by Luis Guerra on 14/6/23.
//

import SwiftUI

struct EditProfileSwift: View {
    @Binding var isEditActive:Bool
    @StateObject var emailString = TFManager()
    @StateObject var phoneNumberString = TFManager()
    var body: some View {
        ZStack{
            Constant.backgroundColor.ignoresSafeArea()
            VStack{
                Spacer(minLength: 5)
                Text("Editar Perfil")
                    .fontWeight(.bold)
                    .foregroundColor(Constant.mainColor)
                Spacer(minLength: 20)
                rideryTextField(placeholder: "ejemplo@gmail com", tittle: "Correo electrónico", textInputString: emailString)
           
                rideryTextField(placeholder: "0414 000 00 00", tittle: "Numero de teléfono", textInputString: phoneNumberString)
                
                Spacer(minLength: 20)
                
            }.padding(20)
        }.onAppear {
            let userdata = UserViewModel().getTestUser()
            emailString.text = userdata.email
            phoneNumberString.text = userdata.phoneNumber
        }
    }
}

struct EditProfileSwift_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileSwift(isEditActive: .constant(true))
    }
}
