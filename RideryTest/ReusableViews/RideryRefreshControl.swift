//
//  RideryRefreshControl.swift
//  RideryTest
//
//  Created by Luis Guerra on 14/6/23.
//

import SwiftUI

struct RideryRefreshControl:View {

    private let overlap: CGFloat = 0.1
    private let overlayColor = Color.gray
    private let overlayOpacity = 0.7

    @Binding var isOpen: Bool

    var body: some View {
        GeometryReader { proxy in
            let refreshHeight = 15.0
            ZStack(alignment: .topLeading) {

                Image("AppLogo")
                    .frame(maxWidth: .infinity, minHeight: refreshHeight, idealHeight: refreshHeight, maxHeight: refreshHeight)
                    .offset(x: 0, y: isOpen ? 0 : -refreshHeight)
            }
        }
    }

    private var mainOverlay: some View {
        overlayColor.opacity(isOpen ? overlayOpacity : 0.0)
            .onTapGesture {
                withAnimation {
                    isOpen.toggle()
                }
            }
    }
}

struct RideryRefreshControl_Previews: PreviewProvider {
    static var previews: some View {
        RideryDrawer(isOpen: .constant(true)) {
            Constant.backGroundDrawerColor
            Text("Show drawer")
        } drawer: {
            Constant.backgroundColor
            Text("Drawer Content")
        }
    }
}

