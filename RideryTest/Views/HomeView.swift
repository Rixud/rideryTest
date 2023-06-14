//
//  HomeView.swift
//  RideryTest
//
//  Created by Luis Guerra on 14/6/23.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @Binding var isActive:Bool
    @State var isOpen = false
    @State var isRefreshing = false
    let swipeDownTolerance = 50.0
    var body: some View {
        NavigationView{
            RideryDrawer(isOpen: $isOpen) {
                ZStack{
                    
                    Constant.backgroundColor.ignoresSafeArea()
                    
                    VStack(alignment: .leading){
                        HStack{
                            drawerRideryButton(tittle: "Options", action: openDrawer)
                                .frame(width: 100, height: 50)
                                .padding(.horizontal, 5.0)
                        }
                        //Spacer(minLength: 10)
                        MapView()
                            .refreshable {
                                updateMap()
                            }
                    }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded({value in
                            if value.translation.height > swipeDownTolerance {
                                print("Down \(value.translation.height)")
                            }
                        }))
                    
                }.navigationBarHidden(true)
            } drawer: {
                DrawerView(isOpen: $isOpen, isActive: $isActive)
                
            }
            
            
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func openDrawer(){
        withAnimation {
            isOpen.toggle()
        }
    }
    
    func updateMap() {
        //Code to updateMap info
        //TestRandom
        print("Refresh")
    }

    
    struct MapView:View {
        @State var locationHandler = RideryLocationViewModel.getInstance()
        
        @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 10.50439,
                longitude: -66.88376),
            span: MKCoordinateSpan(
                latitudeDelta: 0.03,
                longitudeDelta: 0.03)
        )
        
        let locations = [
            ImportanLocation(name: "Ridery Home", coordinate: CLLocationCoordinate2D(latitude: 10.50439, longitude: -66.88376)),
            ImportanLocation(name: "Random1", coordinate: CLLocationCoordinate2D(latitude: 10.50439, longitude: -66.87666)),
            ImportanLocation(name: "Random2 ", coordinate: CLLocationCoordinate2D(latitude: 10.52439, longitude: -66.88376))
        ]
        
        var body: some View{
            Map(coordinateRegion: $region,annotationItems: locations) { location in
                MapMarker(coordinate: location.coordinate, tint: Constant.mainColor)
            }
            .edgesIgnoringSafeArea(.all)
        }
        
        
        func updateLocation () {
            locationHandler.request()
        }
        
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView(isActive: .constant(true))
        }
    }
}

struct DrawerView: View {
    
    @Binding var isOpen:Bool
    @Binding var isActive:Bool
    
    var body: some View {
        Constant.backGroundDrawerColor.ignoresSafeArea()
        VStack {
            HStack{
                Spacer()
                drawerRideryButton(tittle: "X", action: closeDrawer)
                    .frame(width: 20, height: 20, alignment: .topTrailing)
                    
            }
            Spacer(minLength: 5)
            rideryButton(tittle: "Editar Perfil", action: editProfile)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
            rideryButton(tittle: "Cerrar Sesion", action: logOut)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
        }
    }
    
    func closeDrawer(){
        withAnimation {
            isOpen.toggle()
        }
    }
    func editProfile(){
        withAnimation {
            
        }
    }
    func logOut(){
        withAnimation {
            isActive.toggle()
        }
    }
    
}
