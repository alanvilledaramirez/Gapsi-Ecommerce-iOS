//
//  ProductoTableViewCell.swift
//  eCommerce
//
//  Created by Alan Villeda Ramirez on 23/09/23.
//

import UIKit
import PINRemoteImage

class ProductoTableViewCell: UITableViewCell {

    @IBOutlet weak var precio: UILabel!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func cargaProducto(producto: Producto){
        titulo.text = producto.nombre
        precio.text = producto.precio
        imagen.image = #imageLiteral(resourceName: "cargando")
        imagen.pin_updateWithProgress = true
        imagen.pin_setImage(from: URL(string: producto.imagen))
    }
}
