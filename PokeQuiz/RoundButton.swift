//
//  RoundButton.swift
//  PokemonQuiz
//
//  Created by Daniel Afework on 7/21/18.
//  Copyright © 2018 Daniel Afework. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0{
    didSet{
    self.layer.cornerRadius = cornerRadius
    }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }

}
