//
//  DBUtils.swift
//  eCommerce
//
//  Created by Alan Villeda Ramirez on 23/09/23.
//

import Foundation

class DBUtils {
    
    static func eliminarData(){
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: "busqueda")
        preferences.synchronize()
    }
    
    static func guardaBusquedas(busqueda: String){
        var busquedas = getBusquedas()
        busquedas.append(busqueda)
        
        let preferences = UserDefaults.standard
        preferences.set(busquedas, forKey: "busqueda")
        preferences.synchronize()
    }
    
    static func getBusquedas()->Array<String>{
        let preferences = UserDefaults.standard
        if let busquedas = preferences.array(forKey: "busqueda") as? Array<String> {
            return busquedas
        } else {
            return Array<String>()
        }
    }
    
}
