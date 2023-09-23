//
//  Producto.swift
//  eCommerce
//
//  Created by Alan Villeda Ramirez on 23/09/23.
//

import Foundation
import SwiftyJSON

class Producto{
    
    var nombre: String!
    var precio: String!
    var imagen: String!
    
    init(nombre: String, precio: String, imagen: String) {
        self.nombre = nombre
        self.precio = precio
        self.imagen = imagen
    }
    init(json: JSON){
        nombre = json["title"].stringValue
        precio = json["price"].stringValue
        imagen = json["image"].stringValue
    }
    
    static func parseProductos(json: [JSON]?)->Array<Producto>{
        var productos = Array<Producto>()
        
        if json != nil {
            for prod in json! {
                productos.append(Producto(json: prod))
            }
        }
        
        return productos
    }
}
