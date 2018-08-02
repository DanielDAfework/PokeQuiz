//
//  SecondViewController.swift
//  PokemonQuiz
//
//  Created by Daniel Afework on 7/23/18.
//  Copyright © 2018 Daniel Afework. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage




class SecondViewController: UIViewController {
    
    var baseURL = "https://pokeapi.co/api/v2/pokemon/"
    var count = 0
    
    //Array which stores the strings that contain the full API image call
    var pokeArray = ["","","","","","","","","",""]
    //Stores the numbers that will be used to get the names of the pokemon choices
    var randomChoices = ["","","",""]
    var randomInt = [0]
    //Stores the numbers that will be used in the full api call for the 10 pokemon
    var pokemonImages : [Int] = [0]
    //boolean that will be used to determine if the selected answer is true or false
    var isAnswer = [String: Bool]()
    var pokeNames = [String]()
    var empty = " "
    var isAnswer1 = [String: Bool]()
    
    var choice = 0
    var rightAnswer = ""
    var name = ""
    var UICounter = 0
    var score = 0
    
    var isTop = false
    var isBot = false
    var isRight = false
    var isLeft = false
    
    
    
    
    
    
    @IBOutlet weak var topButon: UIButton!
    
    @IBOutlet weak var leftButon: UIButton!
    
    @IBOutlet weak var bottomButon: UIButton!
    
    @IBOutlet weak var rightButon: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         loadPics()
        
        nextPokemon()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func tester(_ sender: Any) {
        nextPokemon()
    }
    
    
    //    //MARK: - Networking
    //    /***************************************************************/
    //grabs the JSON using Alamofire from the pokemon api
    func getPokemonNameData(url: String){
        Alamofire.request(url, method: .get)
            .responseJSON {
                response in
                if response.result.isSuccess{
                    print("Got the Name Pokemon Data")
                    let pokemonJSON : JSON = JSON(response.result.value!)
                    switch self.UICounter{
                    case 0:
                       // print(self.isAnswer[url]!)
                        if(self.isAnswer[url] == true){
                            self.isTop = true
                        }
                        self.updatePokemonNames0(json: pokemonJSON)
                    case 1:
                        print(self.isAnswer[url]!)
                        if(self.isAnswer[url] == true){
                            self.isBot = true
                        }
                        self.updatePokemonNames1(json: pokemonJSON)
                    case 2:
                        print(self.isAnswer[url]!)
                        if(self.isAnswer[url] == true){
                            self.isLeft = true
                        }
                        self.updatePokemonNames2(json: pokemonJSON)
                    case 3:
                        print(self.isAnswer[url]!)
                        if(self.isAnswer[url] == true){
                            self.isRight = true
                        }
                        self.updatePokemonNames3(json: pokemonJSON)
                    default:
                        print("Something went wrong")
                    }
                }else {
                    print("Error: \(String(describing: response.result.error))")
                    //self.
                }
        }
    }
    
    
    func getPokemonImageData(url:String){
        Alamofire.request(url, method: .get)
            .responseJSON {
                response in
                if response.result.isSuccess{
                    print("Got the Pokemon Image Data")
                    let pokemonJSON : JSON = JSON(response.result.value!)
                    self.updatePokemonData(json: pokemonJSON)
                }
        }
    }
    //MARK: - JSON Parsing
    /***************************************************************/
    
    //turns the pokemon json into and image which is displayed on the UIVIEW
    func updatePokemonData(json : JSON){
        
        print("Hello World")
        if let tempResult = json["sprites"]["front_shiny"].string{
            print(tempResult)
            let downloadURL = NSURL(string: tempResult)!
            pictureView.af_setImage(withURL: downloadURL as URL)
            
        }
    }
    
    
    func updatePokemonNames0(json:JSON){
        if let tempResult = json["name"].string{
            topButon.setTitle(tempResult, for: .normal)
            UICounter = UICounter + 1
            print(UICounter)
        }
    }
    func updatePokemonNames1(json:JSON){
        if let tempResult1 = json["name"].string{
            bottomButon.setTitle(tempResult1, for: .normal)
            UICounter = UICounter + 1
            print(UICounter)
            
        }
    }
    func updatePokemonNames2(json:JSON){
        if let tempResult2 = json["name"].string{
            leftButon.setTitle(tempResult2, for: .normal)
            UICounter = UICounter + 1
            print(UICounter)
        }
    }
    func updatePokemonNames3(json:JSON){
        if let tempResult3 = json["name"].string{
            rightButon.setTitle(tempResult3, for: .normal)
            UICounter = 0
            print(UICounter)
            
        }
    }
    
    
    
    
    
    
    //mehtod which allows for a certain amount of non repeating random numbers
    func populatePics(_ from:Int, _ to: Int, _ qut:Int?) -> [Int]{
        var picList = [Int]() //All our generated numbers
        let numberOfPics = qut //how many numbers to generate
        
        let lower = UInt32(from) //generate from this number
        let higher = UInt32(to+1) //to this number
        
        while picList.count != numberOfPics{
            let myNumber = arc4random_uniform(higher-lower) + lower
            if !picList.contains(Int(myNumber)){
                picList.append(Int(myNumber))
            }
        }
        return picList
    }
    
    //returns 3 random integers that are not the same as the ones in the 10 generated
    func randomChoice() -> [Int]{
        var randomChoices = [Int]()
        while randomChoices.count != 3{
            let myNumber = Int(arc4random_uniform(151)+1)
            if (!randomChoices.contains(myNumber) &&
                !pokemonImages.contains(myNumber)){
                randomChoices.append(myNumber)
            }
        }
        
        return randomChoices
    }
    func nextPokemon(){
        if(count<10){
        rightAnswer = String(pokemonImages[count])
        print(rightAnswer)
        }
        else{
            loadPics()
        }
        updateButtonLabels()
        UICounter = 0
        questionNumberLabel.text = "\(count)/10"
        isTop = false
        isBot = false
        isRight = false
        isLeft = false
    }
    
    
    
    
    
    func updateButtonLabels(){
         if(count<10){
        randomInt = randomChoice()
        var randInt = Int(arc4random_uniform(4))
        randomInt.append(pokemonImages[count])
        //randomInt.insert(pokemonImages[count], at: randInt)
        print(randomInt)
        
        
        
        
        //converts the randomInt integer array into an array of strings
        var randomIntString = randomInt.map
        {
            String($0)
        }
        //Now random IntString contains the full URL for each of its 3 random strings
       
        for i in 0...(randomIntString.count-1){
            randomIntString[i] = baseURL + randomIntString[i]
            isAnswer[randomIntString[i]] = false
            if(randomIntString[i] == pokeArray[count]){
                isAnswer[randomIntString[i]] = true
            }
            
        }
        print(isAnswer)
        print(" ")
        print(" ")
        
        print(randomIntString)
        
        getPokemonNameData(url: randomIntString[0])
        
        getPokemonNameData(url: randomIntString[1])
        
        getPokemonNameData(url: randomIntString[2])
        
        getPokemonNameData(url: randomIntString[3])
       
        getPokemonImageData(url: pokeArray[count])
            count = count + 1
        }
       else{
            score = 0
            count = 0
            let alert = UIAlertController(title: "Congrats You've Finished the Quiz!", message: "Would you like to play again?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart" ,style: .default, handler:{
                (UIAlertAction) in
                self.nextPokemon()
            })
            alert.addAction(restartAction)
            present(alert,animated: true, completion: nil)
        }
        
       
       
        
    }
    
    
    @IBAction func topButonAction(_ sender: Any) {
        print("top")
        if(isTop){
            score = score + 1
            scoreLabel.text = "Score: \(score)"
            ProgressHUD.showSuccess("Correct!")
            print("This is the answer")
        }
        else{
            ProgressHUD.showError("Wrong!")
            print("WRONG ANSWER")
        }
        isAnswer.removeAll()
        nextPokemon()
    }
    
    
    
    
    @IBAction func rightButonAction(_ sender: Any) {
        print("right")
        if(isRight){
            score = score + 1
            scoreLabel.text = "Score: \(score)"
             ProgressHUD.showSuccess("Correct!")
            print("This is the answer")
        }
        else{
            ProgressHUD.showError("Wrong!")
            print("WRONG ANSWER")
        }
        isAnswer.removeAll()
        nextPokemon()
        
        
    }
    
    @IBAction func bottomButonAction(_ sender: Any) {
        print("bottom")
        if(isBot){
            score = score + 1
            scoreLabel.text = "Score: \(score)"
            ProgressHUD.showSuccess("Correct!")
            print("This is the answer")
        }
        else{
            ProgressHUD.showError("Wrong!")
            print("WRONG ANSWER")
        }
        isAnswer.removeAll()
        nextPokemon()
        
        
        
    }
    func loadPics(){
        pokemonImages = populatePics(1,151,10)
        print(pokemonImages)
        
        for i in 0...(pokeArray.count-1){
            pokeArray[i] = baseURL + String(pokemonImages[i])
        }
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @IBAction func leftButonAction(_ sender: Any) {
        print("left")
        if(isLeft){
            score = score + 1
            scoreLabel.text = "Score: \(score)"
             ProgressHUD.showSuccess("Correct!")
            print("This is the answer")
        }
        else{
            ProgressHUD.showError("Wrong!")
            print("WRONG ANSWER")
        }
        isAnswer.removeAll()
        nextPokemon()
        
        
    }
    
}








