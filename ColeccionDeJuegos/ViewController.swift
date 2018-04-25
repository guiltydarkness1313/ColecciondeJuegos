//
//  ViewController.swift
//  ColeccionDeJuegos
//
//  Created by Paul Pacheco on 4/25/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var juegos:[Juego]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hideKeyBoardWhenTap()
        tableView.dataSource=self
        tableView.delegate=self
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try juegos = context.fetch(Juego.fetchRequest())
            tableView.reloadData()
        }
        catch{
            print("Hubo un error al cargar la data en el table view")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let juego = juegos[indexPath.row]
        cell.textLabel?.text = juego.titulo
        cell.imageView?.image = UIImage(data:(juego.imagen!) as Data)
        return cell
    }



}

extension UIViewController {
    func hideKeyBoardWhenTap(){
        let tap = UITapGestureRecognizer(target:self,action:#selector(JuegoViewController.dimissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dimissKeyboard(){
        view.endEditing(true)
    }
}

