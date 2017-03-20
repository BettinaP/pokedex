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
    private var _type: String! //[String]!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    //set getters to protect data (data encapsulation) and ensure that we're only providing an actual value or if value is nil to return an empty string to avoid app crashing
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type:String {
        //[String] {
        if _type == nil {
            _type = ""
            // _type = [""]
        }
        return _type
    }
    
    var defense: String {
        if  _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
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
                    //check there is at least one value in dictionary by including count in condition
                    if let types = dict["types"] as? [Dictionary<String,String>] , types.count > 0 {
                        //if only one dictionary in array will execute this:
                        if let name = types[0]["name"]?.capitalized {
                            //self._type.append(name)
                            self._type = name.capitalized
                        }
                        
                        //if more than 1 type dictionary in types array, loop through however many dictionaries there are and look for "names" key and take value to add on to _type string.
                        if types.count > 1 {
                            for x in 1..<types.count {
                                if let name = types[x]["name"] {
                                    // self._type.append(name.capitalized)
                                    self._type! += "/\(name.capitalized)"
                                }
                            }
                        }
                        //find different ways to loop and handle optional
                        //                      for type in types {
                        //                        if let name = type["name"] {
                        //                            self._type.append(name)
                        //                            print("TYPE ARRAY: \(self._type)")
                        //                            print("NAME in typeArray: \(name)")
                        //
                        //                        }
                        //                        }
                        
                    } else {
                        self._type = ""
                        //self._type = [""]
                    }
                    
                    if let descriptionArray = dict["descriptions"] as? [Dictionary<String,String>] , descriptionArray.count > 0 {
                        
                        if let resourceURL = descriptionArray[0]["resource_uri"] {
                            let descriptionURL = "\(base_URL)\(resourceURL)"
                            Alamofire.request(descriptionURL).responseJSON(completionHandler: { (response) in
                                if let descDict = response.result.value as? Dictionary<String,AnyObject> {
                                    
                                    if let description = descDict["description"] as? String {
                                        let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                        self._description = newDescription
                                    }
                                    
                                    print("DESCRIPTION RESULT: \(self._description)")
                                }
                                completed()
                            })
                        } else {
                            self._description = ""
                        }
                    }
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                        
                        if let nextEvo = evolutions[0]["to"] as? String {
                            if nextEvo.range(of: "mega") == nil {
                                self._nextEvolutionName = nextEvo
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                    self._nextEvolutionID = nextEvoId
                                    
                                    if let levelExist = evolutions[0]["level"] {
                                        if let level = levelExist as? Int {
                                            self._nextEvolutionLevel = "\(level)"
                                        }
                                    } else {
                                        
                                        self._nextEvolutionLevel = ""
                                    }
                                }
                            }
                        }
                        
                        print(self.nextEvolutionID)
                        print(self.nextEvolutionName)
                        print(self.nextEvolutionLevel)
                    }
                    
                }
                completed()
            })
        }
    }
    
}
