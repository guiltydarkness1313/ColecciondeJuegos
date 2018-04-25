//
//  JuegoViewController.swift
//  ColeccionDeJuegos
//
//  Created by Paul Pacheco on 4/25/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit

class JuegoViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var juegoImageVIew: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        hideKeyBoardWhenTap()
        super.viewDidLoad()
        imagePicker.delegate=self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageSelected = info[UIImagePickerControllerOriginalImage] as! UIImage
        juegoImageVIew.frame.origin.y=20.0
        juegoImageVIew.frame.origin.x=(self.view.bounds.size.width - juegoImageVIew.frame.size.width)
        juegoImageVIew.image=imageSelected
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let juego=Juego(context:context)
        juego.titulo = tituloTextField.text
        juego.imagen = UIImagePNGRepresentation(juegoImageVIew.image!) as Data?
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
}
