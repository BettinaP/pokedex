//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Bettina on 3/20/17.
//  Copyright © 2017 Bettina Prophete. All rights reserved.
//

import UIKit
import Alamofire


class PokemonDetailViewController: UIViewController {
    
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
    
    var detailPoke: Pokemon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailNameLabel.text = detailPoke.name.capitalized
        pokedexIDValueLabel.text = "\(detailPoke.pokedexID)"
        let img = UIImage(named: "\(detailPoke.pokedexID)")
        mainImage.image = img
        currentEvoImg.image = img
        nextEvoImg.image = UIImage(named: "\(detailPoke.pokedexID + 1)")
        
        detailPoke.downloadPokemonDetails {
            // code below will only be called after the network call is complete.
            self.updateUI()
            
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        OperationQueue.main.addOperation {
            
            self.baseAttackValueLabel.text = self.detailPoke.attack
            self.defenseValueLabel.text = self.detailPoke.defense
            self.heightValueLabel.text = self.detailPoke.height
            self.weightValueLabel.text = self.detailPoke.weight
            self.typeValueLabel.text = self.detailPoke.type
            self.descriptionLabel.text = self.detailPoke.description
            
            if self.detailPoke.nextEvolutionID == "" {
                self.evoLabel.text = "No Evolutions"
                self.nextEvoImg.isHidden = true
            } else {
                self.nextEvoImg.isHidden = false
                self.nextEvoImg.image = UIImage(named: "\(self.detailPoke.nextEvolutionID)")
                let nextEvoStr = "Next Evolution: \(self.detailPoke.nextEvolutionName) - LVL \(self.detailPoke.nextEvolutionLevel)"
                self.evoLabel.text = nextEvoStr
                
            }
        }
    }
}
