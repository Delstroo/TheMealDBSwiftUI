//
//  MealDescription.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import Foundation

struct MealsResponse: Decodable, Hashable {
    let meals: [Meals]?
    enum CodingKeys: String, CodingKey {
        case meals = "meals"
    }
}

struct Meals: Decodable, Identifiable, Hashable {
    let id = UUID()
    let idMeal: String
    let strMeal: String?
    let strCategory: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let ingredients: [Ingredient]?
}

struct Ingredient: Decodable, Hashable {
    let name: String
    let measure: String
}



//Currently,the API response has 20 fields some of which are nil/null, we need to write a custom decoder that excludes nil fields and properly decodes them into an array so we can iterate
extension Meals {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mealDict = try container.decode([String: String?].self)
        var index = 1
        var ingredients: [Ingredient] = []
        while let ingredient = mealDict["strIngredient\(index)"] as? String,
              let measure = mealDict["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            ingredients.append(.init(name: ingredient, measure: measure))
            index += 1
        }//: while
            self.ingredients = ingredients
            idMeal = mealDict["idMeal"] as? String ?? ""
            strMeal = mealDict["strMeal"] as? String ?? ""
            strCategory = mealDict["strCategory"] as? String ?? ""
            strInstructions = mealDict["strInstructions"] as? String ?? ""
            strMealThumb = mealDict["strMealThumb"] as? String ?? ""
            strTags = mealDict["strTags"] as? String ?? ""
            strYoutube = mealDict["strYoutube"] as? String ?? ""
        }//: init
    }//: extension-Meals

extension Meals {
    static let mealTest = Meals(idMeal: "53049", strMeal: "Apam balik", strCategory: "Dessert", strInstructions: "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.", strMealThumb:  "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", strTags: nil, strYoutube: "https://www.youtube.com/watch?v=6R8ffRRJcrg", ingredients: Meals.ingredientTest )
}

extension Meals {
    static let ingredientTest: [Ingredient]?  =
    [
        Ingredient(name: "Milk", measure: "200ml"),
        Ingredient(name: "Oil", measure: "60ml"),
        Ingredient(name: "Eggs", measure: "2"),
        Ingredient(name: "Flour", measure: "1600g"),
        Ingredient(name: "Baking Powder", measure: "3 tsp"),
        Ingredient(name: "Salt", measure: "1/2 tsp"),
        Ingredient(name: "Unsalted Butter", measure: "25g"),
        Ingredient(name: "Sugar", measure: "45g"),
        Ingredient(name: "Peanut Butter", measure: "3 tbs")
    ]
}
