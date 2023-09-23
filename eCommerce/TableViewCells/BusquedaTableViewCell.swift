//
//  BusquedaTableViewCell.swift
//  eCommerce
//
//  Created by Alan Villeda Ramirez on 23/09/23.
//

import UIKit

class BusquedaTableViewCell: UITableViewCell {

    @IBOutlet weak var texto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func load(texto: String){
        self.texto.text = texto
    }
}
