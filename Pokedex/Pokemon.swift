//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bettina on 3/19/17.
//  Copyright © 2017 Bettina Prophete. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    
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
    
    init(name: String, pokedexID: Int){
        self._name = name
        self._pokedexID = pokedexID
    }
}
