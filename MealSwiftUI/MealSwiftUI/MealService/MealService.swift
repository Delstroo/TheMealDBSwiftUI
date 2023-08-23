//
//  MealService.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import Foundation

class MealService: ObservableObject {
    
    enum CategoryMealSort: String, CaseIterable {
        case Beef = "Beef"
        case Breakfast = "Breakfast"
        case Chicken = "Chicken"
        case Dessert = "Dessert"
        case Goat = "Goat"
        case Lamb = "Lamb"
        case Miscellaneous = "Miscellaneous"
        case Pasta = "Pasta"
        case Pork = "Pork"
        case Seafood = "Seafood"
        case Side = "Side"
        case Starter = "Starter"
        case Vegan = "Vegan"
        case Vegetarian = "Vegetarian"
        
    }
    
    var mealRepo = MealRepositories()
    
    @Published var categorySelected = "Beef"
    @Published var sortType: CategoryMealSort = .Beef
    
    @Published var mealCategory: [Categories] = []//category of meal
    @Published var searchMeal: [Meals] = []//searched meal through api
    
    
    ///This will get the list of meals for the category
    ///'''
    /// mealService.fetchMealCategory(category: String)
    ///'''
    @MainActor func fetchMealCategory(category: String) async {
        do {
            mealCategory = try await mealRepo.getCategoryList(category: category).mealsCategory.sorted(by: { $0.strMeal < $1.strMeal })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor func fetchSearchedMeal(search: String) async {
        do {
            searchMeal = try await mealRepo.getSearchMeals(mealName: search).meals ?? []
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
