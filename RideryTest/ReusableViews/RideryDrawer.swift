//
//  RideryDrawer.swift
//  RideryTest
//
//  Created by Luis Guerra on 14/6/23.
//

import SwiftUI

struct RideryDrawer<MainContent: View, DrawerContent: View>: View {

    private let overlap: CGFloat = 0.7
    private let overlayColor = Color.gray
    private let overlayOpacity = 0.7

    @Binding var isOpen: Bool
    private let main: () -> MainContent
    private let drawer: () -> DrawerContent

    init(isOpen: Binding<Bool>,
         @ViewBuilder main: @escaping () -> MainContent,
         @ViewBuilder drawer: @escaping () -> DrawerContent) {
        self._isOpen = isOpen
        self.main = main
        self.drawer = drawer
    }

    var body: some View {
        GeometryReader { proxy in
            let drawerWidth = proxy.size.width * overlap
            ZStack(alignment: .topLeading) {
                main()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(mainOverlay)
                drawer()
                    .frame(minWidth: drawerWidth, idealWidth: drawerWidth,
                           maxWidth: drawerWidth, maxHeight: .infinity)
                    .offset(x: isOpen ? 0 : -drawerWidth, y: 0)
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

struct RideryDrawer_Previews: PreviewProvider {
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
