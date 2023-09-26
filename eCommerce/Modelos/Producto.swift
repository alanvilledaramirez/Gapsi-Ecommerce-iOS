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
    var type: String!
    
    init(nombre: String, precio: String, imagen: String) {
        self.nombre = nombre
        self.precio = precio
        self.imagen = imagen
    }
    init(json: JSON){
        //Falta el parceo aiuudaa!!
        //Ya quedo :)
        nombre = json["name"].stringValue
        precio = json["priceInfo"]["linePriceDisplay"].stringValue
        imagen = json["image"].stringValue
        type = json["type"].stringValue
    }
    
    static func parseProductos(json: [JSON]?)->Array<Producto>{
        var productos = Array<Producto>()
        
        if json != nil {
            for prod in json! {
                let prod = Producto(json: prod)
                //Solo pinto estos types
                if (prod.type == "REGULAR" || prod.type == "VARIANT") {
                    productos.append(prod)
                }
            }
        }
        
        return productos
    }
}
