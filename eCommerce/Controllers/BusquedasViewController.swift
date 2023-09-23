//
//  BusquedasViewController.swift
//  eCommerce
//
//  Created by Alan Villeda Ramirez on 23/09/23.
//

import UIKit
import SwiftyJSON

class BusquedasViewController: UIViewController {
    
    @IBOutlet weak var tableViewBusquedas: UITableView!
    @IBOutlet weak var tableViewResultados: UITableView!
    @IBOutlet weak var constraintBusqueda: NSLayoutConstraint!
    @IBOutlet weak var mensaje: UILabel!
    @IBOutlet weak var buscador: UITextField!
    @IBOutlet weak var mensaje2: UILabel!
    var busquedas = Array<String>()
    var requester: Requester!
    var productos = Array<Producto>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requester = Requester(controller: self, delegate: self)
        cargaBusquedas()
        buscador.delegate = self
        tableViewBusquedas.delegate = self
        tableViewBusquedas.dataSource = self
        tableViewResultados.delegate = self
        tableViewResultados.dataSource = self
        tableViewBusquedas.isHidden = true
        
        /*DispatchQueue.main.async {
         self.requester.getProductosPorNombre(nombre: "sony", code: 0)
         }*/
        cargaMensaje()
    }
    
    func cargaDommies(){
        productos.removeAll()
        tableViewResultados.reloadData()
        productos.append(Producto(nombre: "iPad", precio: "$2,000", imagen: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"))
        productos.append(Producto(nombre: "iPhone", precio: "$1,000", imagen: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"))
        productos.append(Producto(nombre: "Zapatos", precio: "$1,000", imagen: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"))
        productos.append(Producto(nombre: "Zapatos", precio: "$1,000", imagen: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"))
        productos.append(Producto(nombre: "Zapatos", precio: "$1,000", imagen: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"))
        productos.append(Producto(nombre: "Zapatos", precio: "$1,000", imagen: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"))
        productos.append(Producto(nombre: "Zapatos", precio: "$1,000", imagen: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"))
        productos.append(Producto(nombre: "Zapatos", precio: "$1,000", imagen: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"))
        tableViewResultados.reloadData()
        cargaMensaje()
    }
    func cargaMensaje(){
        if productos.count > 0 {
            mensaje.isHidden = true
        }else{
            mensaje.isHidden = false
        }
    }
    func cargaMensaje2(){
        if busquedas.count > 0 {
            mensaje2.isHidden = true
        }else{
            mensaje2.isHidden = false
        }
    }
    func cargaBusquedas(){
        busquedas.removeAll()
        busquedas = DBUtils.getBusquedas()
        busquedas.reverse()
        tableViewBusquedas.reloadData()
    }
    
    func parseProductos(json: JSON){
        cargaDommies()
        /*productos.removeAll()
        productos.append(contentsOf: Producto.parseProductos(json: json["arreglo"].array))
        cargaMensaje()
        tableViewResultados.reloadData()*/
    }
    
    @IBAction func buscar(_ sender: Any) {
        self.view.endEditing(true)
        if !buscador.hasText {
            let alert = UIAlertController(title: "Gapsi", message: "Ingresa un producto para continuar", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
            present(alert, animated: true)
        }else{
            productos.removeAll()
            tableViewResultados.reloadData()
            DispatchQueue.main.async {
                self.requester.getProductosPorNombre(nombre: self.buscador.text!, code: 0)
            }
            DBUtils.guardaBusquedas(busqueda: buscador.text!)
        }
    }
}

extension BusquedasViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == tableViewBusquedas {
            return "Busquedas recientes"
        }else{
            return ""
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewResultados {
            return productos.count
        }else{
            return busquedas.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewResultados {
            return UITableView.automaticDimension
        }else{
            return 43
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewResultados {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellProducto", for: indexPath) as! ProductoTableViewCell
            cell.cargaProducto(producto: productos[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellBusqueda", for: indexPath) as! BusquedaTableViewCell
            cell.load(texto: busquedas[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewBusquedas {
            buscador.text = busquedas[indexPath.row]
            buscar(tableView)
        }
    }
    
}

extension BusquedasViewController: RequesterDelegate {
    func onSuccessRequest(json: JSON, code: Int) {
        parseProductos(json: json)
    }
    
    func onFailureRequest(mensaje: String, code: Int) {
        cargaDommies()
        let alert = UIAlertController(title: "Gapsi", message: mensaje+" (cargo dommies)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
        present(alert, animated: true)
    }
    
    
}

extension BusquedasViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        cargaBusquedas()
        cargaMensaje2()
        tableViewBusquedas.isHidden = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        cargaBusquedas()
        mensaje2.isHidden = true
        tableViewBusquedas.isHidden = true
    }
}
