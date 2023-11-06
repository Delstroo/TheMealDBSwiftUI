//
//  SavedMealsCell.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 11/3/23.
//

import SwiftUI

struct SavedMealsCell: View {
    @StateObject var viewModel: SavedMealsViewModel = SavedMealsViewModel()
    var meal: Meals
    var width = UIScreen.main.bounds.width * 0.45
    
    @State private var isStarred: Bool

    init(meal: Meals) {
            self.meal = meal
        _isStarred = State(initialValue: UserDefaults.standard.stringArray(forKey: "SavedMeals")?.contains(meal.idMeal) ?? false)
        }
    
    var body: some View {
            VStack(spacing: 12) {
                if meal.strMealThumb != nil{
                    // In CategoryView.swift
                    AsyncImage(url: URL(string: meal.strMealThumb!)!) { img in
                        img
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: width / 0.667)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .black.opacity(0.4), radius: 2, x: -6, y: 3)
                            .overlay {
                                LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                                    .cornerRadius(12)
                            }
                            .overlay(alignment: .bottomLeading) {
                                Text(meal.strMeal ?? "")
                                    .multilineTextAlignment(.leading)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: width - 16, alignment: .leading)
                                    .padding(.leading, 8)
                                    .padding(.bottom, 20)
                            }
                        
                            .overlay(alignment: .topTrailing) {
                                Button(action: {
                                    addToSavedMeals()
                                }, label: {
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 40, height: 40)
                                        .foregroundStyle(Color(uiColor: .black).opacity(0.35))
                                        .background(.clear)
                                    
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 6)
                                                .frame(width: 30, height: 30)
                                                .foregroundStyle(Color(uiColor: .black).opacity(0.75))
                                            
                                            Image(systemName: isStarred ? "star.fill" : "star")
                                                .foregroundStyle(.yellow.opacity(0.65))
                                        }
                                })
                                .padding(4)
                            }
                    } placeholder: {
                        ProgressView()
                            .frame(width: width, height: width / 0.667)
                    }
                } else {
                    Image(systemName: "photo.artframe")
                        .imageScale(.large)
                }//: if else -asyncImage
            }//: VStack
           
            .padding()
            .onAppear {
                checkIsStarred()
            }
    }
    
    func checkIsStarred() {
        if let savedMeals = UserDefaults.standard.stringArray(forKey: "SavedMeals"),
           savedMeals.contains(meal.idMeal) {
            isStarred = true
        }
    }
    
    func addToSavedMeals() {
        var savedMeals = UserDefaults.standard.stringArray(forKey: "SavedMeals") ?? []

        if isStarred {
            // If it's already starred, remove it
            savedMeals.removeAll { $0 == meal.idMeal }
            viewModel.meals.removeAll { $0.idMeal == meal.idMeal }
            isStarred = false // Update isStarred
        } else {
            // If it's not starred, add it
            savedMeals.append(meal.idMeal)
            isStarred = true // Update isStarred
        }
        
        UserDefaults.standard.set(savedMeals, forKey: "SavedMeals")
        checkIsStarred()
    }
}

#Preview {
    SavedMealsCell(meal: .mealTest)
}
