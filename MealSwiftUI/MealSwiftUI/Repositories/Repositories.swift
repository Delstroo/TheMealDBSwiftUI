//
//  Repositories.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import Foundation
final class MealRepositories: MealRepositoryProtocol {
    
    let requester = Requester()
    
    func getCategoryList(category: String) async throws -> CategoryResponse {
        let request = MealRequest.filterByCategory(category)
        return try await requester.doRequest(request: request)
    }
    
    func getMealDetail(mealId: String) async throws -> MealsResponse {
        let request = MealRequest.lookupFullMealDetailsById(mealId)
        return try await requester.doRequest(request: request)
    }
    
    func getIngredients(ingredients: String) async throws -> Meals {
        let request = MealRequest.ingredientsImage(ingredients)
        return try await requester.doRequest(request: request)
    }
    
    func getSearchMeals(mealName: String) async throws -> MealsResponse {
        let request = MealRequest.searchMealByName(mealName)
        return try await requester.doRequest(request: request)
    }
    
}
