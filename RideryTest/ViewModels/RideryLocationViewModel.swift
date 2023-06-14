//
//  RideryLocationViewModel.swift
//  RideryTest
//
//  Created by LuisGuerra on 14/6/23.
//

import Foundation
import CoreLocation

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
