//
//  Meal.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import Foundation

struct CategoryResponse: Codable, Hashable{
    let mealsCategory: [Categories]
    
    enum CodingKeys: String, CodingKey {
        case mealsCategory = "meals"
    }
    
}

// MARK: - MealCategory
struct Categories: Codable, Hashable {
    var strMeal: String
    var strMealThumb: URL?
    var idMeal: String
    
}
extension Categories {
    static let categoryDescriptionTest = Categories(strMeal: "Tunisian Orange Cake", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/y4jpgq1560459207.jpg")!, idMeal: "52970")
}


//MARK: - Area
//TODO: make the area view
struct AreaResponse: Codable {
    let areaResponse: [Area]
    
    enum CodingKeys: String, CodingKey {
        case areaResponse = "meals"
    }
}

// MARK: - Area
struct Area: Codable {
    let strArea: String
}
