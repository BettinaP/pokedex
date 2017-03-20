//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bettina on 3/19/17.
//  Copyright © 2017 Bettina Prophete. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _pokemonURL: String!
    
    var name: String {
//        if _name == nil {
//            _name = ""
//        }
        return _name
    }
    
    var pokedexID: Int {
//        if _pokedexID == nil {
//            _pokedexID = 0
//        }
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(base_URL)\(pokemon_URL)\(self.pokedexID)/"
    }
    
    //want to do lazy loading since we dont want to make 700+ network calls at once, right off the bat. Want to make call for details once a Pokemon has been selected/clicked on to then make call.
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        if let pokemonURL = _pokemonURL {
          
            Alamofire.request(pokemonURL).responseJSON(completionHandler: { (response) in
                
                if let dict = response.result.value as? Dictionary<String,AnyObject> {
                    if let attack = dict["attack"] as? Int {
                        self._attack = "\(attack)"
                    }
                    
                    if let weight = dict["weight"] as? String {
                        self._weight = weight
                    }
                    
                    if let height = dict["height"] as? String {
                        self._height = height
                    }
                    
                    if let defense = dict["defense"] as? Int {
                        self._defense = "\(defense)"
                    }
                    
                    print(self._weight)
                    print(self._height)
                    print(self._attack)
                    print(self._defense)
                }
            })
        }
    }
    
}
