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
    //Label where the selected game mode is displayed
    @IBOutlet weak var greenScreenLabel: UILabel!
    
    @IBOutlet weak var gen2: UIButton!
    
    @IBOutlet weak var gen3: UIButton!
    
    @IBOutlet weak var gen4: UIButton!
    
    @IBOutlet weak var gen5: UIButton!
    
    
    @IBOutlet weak var all: UIButton!
    //variables that our passed through the segue to determine the range of pokemon to generate
    var pokeGenStart = 0
    var pokeGenEnd = 0
    
    @IBAction func playButton(_ sender: Any) {
        if( greenScreenLabel.text != ""){
            performSegue(withIdentifier: "WhoPokemon", sender: self)
          
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == "WhoPokemon"){
            let destinatinoVC = segue.destination as! SecondViewController
            destinatinoVC.pokemonGenerationStart = pokeGenStart
            destinatinoVC.pokemonGenerationEnd = pokeGenEnd
        }
    }
    
    
    //function which sets the range of what pokemon will be generated depending on how which generation they select
    @IBAction func WTPAction(_ sender: Any) {
        if((sender as AnyObject).tag == 1){
        greenScreenLabel.text = "Gen 1"
            pokeGenStart = 1
            pokeGenEnd = 151
        }
        else if((sender as AnyObject).tag == 3){
            greenScreenLabel.text = "Gen 2"
            pokeGenStart = 152
            pokeGenEnd = 251
        }
            
        else if((sender as AnyObject).tag == 4){
            greenScreenLabel.text = "Gen 3"
            pokeGenStart = 252
            pokeGenEnd = 386
        }
            
        else if((sender as AnyObject).tag == 5){
            greenScreenLabel.text = "Gen 4"
            pokeGenStart = 387
            pokeGenEnd = 493
        }
            
        else if((sender as AnyObject).tag == 6){
            greenScreenLabel.text = "Gen 5"
            pokeGenStart = 494
            pokeGenEnd = 649
        }
      
        else if ((sender as AnyObject).tag == 9){
            greenScreenLabel.text = "Gen 1-5"
            pokeGenStart = 1
            pokeGenEnd = 649
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
