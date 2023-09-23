//
//  Requester.swift
//  eCommerce
//
//  Created by Alan Villeda Ramirez on 23/09/23.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol RequesterDelegate {
    func onSuccessRequest(json: JSON, code: Int)
    func onFailureRequest(mensaje: String, code: Int)
}

class Requester {
    
    //URLS
    var clientId = "adb8204d-d574-4394-8c1a-53226a40876e"
    var url = "https://00672285.us-south.apigw.appdomain.cloud/demo-gapsi/"
    var controller: UIViewController?
    var delegate: RequesterDelegate?
    
    init(controller: UIViewController, delegate: RequesterDelegate) {
        self.controller = controller
        self.delegate = delegate
    }
    
    //Metodos
    func getProductosPorNombre(nombre: String, code: Int){
        let headers = [
            "X-IBM-Client-Id":"adb8204d-d574-4394-8c1a-53226a40876e"
        ]
        sendRequest(metodo: "search?&query=\(nombre)", httpMethod: .get, parametros: nil, headers: headers, code: code)
    }
    
    //Requester
    func sendRequest(metodo: String, httpMethod: HTTPMethod, parametros: Parameters?, headers: HTTPHeaders?, code: Int){
        let endPoint = url + metodo
        print("ENDPOINT: \(endPoint)")
        print("HEADERS: \(String(describing: headers!))")
        print("PARAMETROS: \(String(describing: parametros))")
        print("METODO: \(httpMethod)")
        
        showLoader {
            Alamofire.request(endPoint, method: httpMethod, parameters: parametros, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<300).responseJSON { (resonse) in
                
                self.dismissLoader{
                    
                    switch resonse.result {
                    case .success:
                        
                        let json = JSON(resonse.result.value!)
                        print(json)
                        self.delegate?.onSuccessRequest(json: json, code: code)
                        break
                        
                    case .failure(let error):
                        self.delegate?.onFailureRequest(mensaje: error.localizedDescription, code: code)
                        break
                    }
                }
            }
        }
    }
    
    //Loaders
    func showLoader(completion: (() -> Void)?){
        let alert = UIAlertController(title: "Gapsi", message: "Cargando...", preferredStyle: .alert)
        controller?.present(alert, animated: true, completion: completion)
    }
    
    func dismissLoader(completion: (() -> Void)?){
        controller?.dismiss(animated: true, completion: completion)
    }
}
