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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeValueLabel: UILabel!
    @IBOutlet weak var defenseValueLabel: UILabel!
    
    
    @IBOutlet weak var heightValueLabel: UILabel!
    
    
    @IBOutlet weak var pokedexIDValueLabel: UILabel!
    
    
    
    @IBOutlet weak var weightValueLabel: UILabel!

    
    
    @IBOutlet weak var baseAttackValueLabel: UILabel!
    
    @IBOutlet weak var evoLabel: UILabel!
    
    @IBOutlet weak var currentEvoImg: UIImageView!
    
    @IBOutlet weak var nextEvoImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        detailNameLabel.text = detailPoke.name
        // Do any additional setup after loading the view.
    }

   
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
