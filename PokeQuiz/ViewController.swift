//
//  ViewController.swift
//  PokeQuiz
//
//  Created by Daniel Afework on 7/31/18.
//  Copyright © 2018 Daniel Afework. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    //remeber this is a button
    @IBOutlet weak var WTPLabel: UIButton!
    
    @IBOutlet weak var greenScreenLabel: UILabel!
    
    @IBAction func playButton(_ sender: Any) {
        if( greenScreenLabel.text == "Who's That Pokemon?"){
            performSegue(withIdentifier: "WhoPokemon", sender: self)
            print("Hello World 342342049831048")
        }
    }
    
    
    
    @IBAction func WTPAction(_ sender: Any) {
        greenScreenLabel.text = "Who's That Pokemon?"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
