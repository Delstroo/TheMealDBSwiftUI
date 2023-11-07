//
//  File.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 10/31/23.
//

import Foundation

class SavedMealsViewModel: ObservableObject {
    
    var mealRepo = MealRepositories()
    
    @Published var meal: Meals?
    @Published var savedMeals = UserDefaults.standard.stringArray(forKey: "SavedMeals") ?? []

    @Published var isIngredientsTapped: Bool = false
    @Published var detailMeals: [Meals] = []
    @Published var meals: [Meals] = []
    
    @MainActor
    func fetchMealsDetail() async {
        meals.removeAll()
        do {
            for savedMeal in savedMeals {
                // Fetch details for the provided category
                detailMeals = try await mealRepo.getMealDetail(mealId: savedMeal).meals ?? []
                if let meal = detailMeals.first {
                    if savedMeal.contains(meal.idMeal) {
                        meals.append(meal)
                    }
                }
            }
            
            print(meals.count)
            

//            // Iterate over the detailMeals and add them to savedMeals if not already present
//            for detailMeal in detailMeals {
//                if !savedMeals.contains(detailMeal.strMeal ?? "") {
//                    savedMeals.append(detailMeal.strMeal ?? "")
//                }
//            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func refreshMeals() {
        // Filter viewModel.meals based on the updated savedMeals array
        self.meals = self.detailMeals.filter { meal in
            savedMeals.contains(meal.idMeal)
        }
    }

}
