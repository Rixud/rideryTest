//
//  rideryButton.swift
//  RideryTest
//
//  Created by Luis Guerra on 14/6/23.
//

import Foundation
import SwiftUI

struct rideryButton:View {
    var tittle:String = ""
    var action :() -> Void
    
    var body: some View {
        Button(action: action) {
            Text(tittle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame( maxWidth: .infinity, alignment: .center)
                .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                .overlay(RoundedRectangle(cornerRadius: 6)
                    .stroke(Constant.mainColor, lineWidth: 3).shadow(color: .white, radius: 6))
        }.padding(.bottom)
        
        Divider()
        
        
    }
}

struct drawerRideryButton:View {
    var tittle:String = ""
    var action :() -> Void
    
    var body: some View {
        Button(action: action) {
            Text(tittle)
                .fontWeight(.light)
                .foregroundColor(.white)
                .frame( maxWidth: .infinity, alignment: .center)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .overlay(RoundedRectangle(cornerRadius: 6)
                    .stroke(Constant.mainColor, lineWidth: 3).shadow(color: .white, radius: 6))
        }.padding(.bottom)
        
        Divider()
        
        
    }
}
