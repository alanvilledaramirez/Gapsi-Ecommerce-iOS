//
//  ViewController.swift
//  eCommerce
//
//  Created by Alan Villeda Ramirez on 23/09/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func entrar(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(withIdentifier: "busquedasVC") as! BusquedasViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}

