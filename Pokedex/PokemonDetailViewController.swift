//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Bettina on 3/20/17.
//  Copyright © 2017 Bettina Prophete. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var detailPoke: Pokemon!
    
    @IBOutlet weak var detailNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailNameLabel.text = detailPoke.name
        // Do any additional setup after loading the view.
    }

   

}
