//
//  File.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 10/31/23.
//

import Foundation

class SavedMealsViewModel: ObservableObject {
    
    var mealRepo = MealRepositories()
    
    var meal: Meals?
    var categoryDescription: Categories?
    
    @Published var isIngredientsTapped: Bool = false
    @Published var detailMeals: [Meals] = []

    init(meal: Meals) {
        self.meal = meal
    }
    
    init(categoryDescription: Categories) {
        self.categoryDescription = categoryDescription
    }
    
    @MainActor
    func fetchMealsDetail() async {
        do {
            if let meal = meal {
                // Fetch details for the provided meal
                detailMeals = try await mealRepo.getMealDetail(mealId: meal.idMeal).meals ?? []
            } else if let categoryDescription = categoryDescription {
                // Fetch details for the provided category
                detailMeals = try await mealRepo.getMealDetail(mealId: categoryDescription.idMeal).meals ?? []
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
