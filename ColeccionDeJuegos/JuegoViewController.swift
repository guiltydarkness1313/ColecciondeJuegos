//
//  JuegoViewController.swift
//  ColeccionDeJuegos
//
//  Created by Paul Pacheco on 4/25/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit

class JuegoViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var eliminarButton: UIButton!
    @IBOutlet weak var juegoImageVIew: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var agregarActualizarButton: UIButton!
    var imagePicker = UIImagePickerController()
    
    var juego:Juego?=nil
    
    override func viewDidLoad() {
        hideKeyBoardWhenTap()
        super.viewDidLoad()
        imagePicker.delegate=self
        // Do any additional setup after loading the view.
        if juego != nil{
            juegoImageVIew.image = UIImage(data: (juego!.imagen) as! Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarButton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarButton.isHidden = true
        }
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
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
    imagePicker.sourceType = .camera
        present(imagePicker,animated: true,completion: nil)
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        
        if juego != nil {
            juego!.titulo = tituloTextField.text
            juego!.imagen = UIImagePNGRepresentation(juegoImageVIew.image!) as Data?
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego=Juego(context:context)
            juego.titulo = tituloTextField.text
            juego.imagen = UIImagePNGRepresentation(juegoImageVIew.image!) as Data?
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        navigationController!.popViewController(animated: true)
    }
}
