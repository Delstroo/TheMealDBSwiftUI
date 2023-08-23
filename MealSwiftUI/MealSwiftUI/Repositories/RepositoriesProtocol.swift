//
//  RepositoriesProtocol.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import Foundation
protocol MealRepositoryProtocol {
    func getCategoryList(category: String) async throws -> CategoryResponse
    func getMealDetail(mealId: String) async throws -> MealsResponse
    func getIngredients(ingredients: String) async throws -> Meals
    func getSearchMeals(mealName: String) async throws -> MealsResponse
}
