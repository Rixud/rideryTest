//
//  HomeWithGoogle.swift
//  RideryTest
//
//  Created by Luis Guerra on 15/6/23.
//

import SwiftUI
import GoogleMaps
import MapKit

struct HomeWithGoogle: View {
    @State var locationHandler = RideryLocationViewModel.getInstance()
    @State var isEditActive = false
    @Binding var isActive:Bool
    @State var isOpen = false
    @State var isRefreshing = false
    @State var randomColor = Color.random()
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
                        MapView(locationHandler: $locationHandler, randomColor: $randomColor)
                    }
                }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded({value in
                        if value.translation.height > 0.0 {
                            isRefreshing = true
                            run(after: 2) {
                                randomColor = updateMap(locationHandler)
                            }
                            
                        }
                    }))
                if isRefreshing {
                    RideryRefreshCustom()
                }
            } drawer: {
                DrawerView(isOpen: $isOpen, isActive: $isActive, isEditActive: $isEditActive)
                
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
    
    func updateMap(_ location:RideryLocationViewModel)-> Color /*[ImportanLocation]*/ {
        //Code to updateMap info
        //TestRandom
        isRefreshing = false
        //location.getRandomTestMapLocations()
        return Color.random()
        
    }
    
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    struct RideryRefreshCustom: View {
        
        var body: some View {
            ZStack{
                ProgressView()
            }
            
        }
        
    }

    
    struct MapView:View {
        @Binding var locationHandler: RideryLocationViewModel
        @Binding var randomColor: Color
        @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 10.49039,
                longitude: -66.88330),
            span: MKCoordinateSpan(
                latitudeDelta: 0.03,
                longitudeDelta: 0.03)
        )
        
        
        var body: some View{
            Map(coordinateRegion: $region,annotationItems: locationHandler.getRandomTestMapLocations()) { location in
                MapMarker(coordinate: location.coordinate, tint: randomColor)
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

