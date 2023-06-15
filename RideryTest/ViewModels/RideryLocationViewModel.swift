//
//  RideryLocationViewModel.swift
//  RideryTest
//
//  Created by LuisGuerra on 14/6/23.
//

import Foundation
import CoreLocation
import MapKit

struct ImportanLocation: Identifiable {
    let id = UUID()
    let name:String
    let coordinate: CLLocationCoordinate2D
}

class RideryLocationViewModel:NSObject {
    
    private let locationManager = CLLocationManager()
    
    // MARK: Properties observadas
    @objc dynamic var latitudeDouble: Double
    @objc dynamic var longitudeDouble: Double
    
    // MARK: Singleton, siempre se obtiene una sola instancia
    private static let singleton : RideryLocationViewModel = {
        let locationHandler = RideryLocationViewModel()
        
        return locationHandler
    }()
    
    private override init(){
        latitudeDouble = 0.0
        longitudeDouble = 0.0
        super.init()
        // MARK: Configuracion de LocationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // MARK: Retorna siempre la misma instancia (singleton)
    class func getInstance() -> RideryLocationViewModel {
        return singleton
    }
    
    // MARK: Actualiza lat & lon
    func request(){
        locationManager.startUpdatingLocation()
    }
    
    func StopRequest(){
        locationManager.stopUpdatingLocation()
    }
    
    func getRandomTestMapLocations()->[ImportanLocation]{
        return  [
            ImportanLocation(name: "Ridery Home", coordinate: CLLocationCoordinate2D(latitude: 10.50439, longitude: -66.88376)),
            ImportanLocation(name: "Random1", coordinate: CLLocationCoordinate2D(latitude: 10.50439, longitude: -66.87666)),
            ImportanLocation(name: "Random2 ", coordinate: CLLocationCoordinate2D(latitude: 10.49039, longitude: -66.88376))
        ]

    }
    
    
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    
    func getCentralMapRegion () -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 10.50439,
                longitude: -66.88376),
            span: MKCoordinateSpan(
                latitudeDelta: 0.03,
                longitudeDelta: 0.03)
        )
    }
}

extension RideryLocationViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitudeDouble = location.coordinate.latitude
            longitudeDouble = location.coordinate.longitude
            locationManager.stopUpdatingLocation()//Ahorra recursos si no se necesita las coordenadas
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
        //Manajar errores
    }
    
}
