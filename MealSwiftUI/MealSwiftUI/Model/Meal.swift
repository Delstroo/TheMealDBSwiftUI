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
class Categories: Codable, Hashable, Equatable {
    static func == (lhs: Categories, rhs: Categories) -> Bool {
        return lhs.idMeal == rhs.idMeal
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMeal)
    }

    var strMeal: String
    var strMealThumb: URL?
    var idMeal: String
    var isStarred: Bool {
        get {
            return UserDefaults.standard.stringArray(forKey: "SavedMeals")?.contains(idMeal) ?? false
        }
        set {
            if newValue {
                // Add the meal to saved meals
                var savedMeals = UserDefaults.standard.stringArray(forKey: "SavedMeals") ?? []
                if !savedMeals.contains(idMeal) {
                    savedMeals.append(idMeal)
                    UserDefaults.standard.set(savedMeals, forKey: "SavedMeals")
                }
            } else {
                // Remove the meal from saved meals
                var savedMeals = UserDefaults.standard.stringArray(forKey: "SavedMeals") ?? []
                savedMeals.removeAll { $0 == idMeal }
                UserDefaults.standard.set(savedMeals, forKey: "SavedMeals")
            }
        }
    }
    
    init(strMeal: String, strMealThumb: URL?, idMeal: String) {
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
    }
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

