//
//  PersonalMealView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 10/31/23.
//

import SwiftUI

struct SavedMealsView: View {
    @StateObject var viewModel: SavedMealsViewModel = SavedMealsViewModel()
    @State var meals: [Meals] = []
    var savedMeals = UserDefaults.standard.stringArray(forKey: "SavedMeals") ?? []
    @State private var selectedMeal: Meals?
    var body: some View {
        VStack {
            if !viewModel.meals.isEmpty {
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()), // You can adjust .flexible() as needed
                        GridItem(.flexible())
                    ]) {
                        ForEach(viewModel.meals, id: \.self) { meal in
                            NavigationLink(
                                destination:  MealDetailView(detailVM: DetailViewModel(meal: meal)),
                                tag: meal,
                                selection: $selectedMeal
                            ) {
                                SavedMealsCell(meal: meal)
                            }
                            .isDetailLink(false)
                        }
                    }
                }
            } else {
                EmptyViewState()
                    
            Spacer() // Pushes the Picker to the top
        }
    }
        .task {
            await viewModel.fetchMealsDetail()
        }
        
        .background(Color("bgColor"))
    }
}

#Preview {
    SavedMealsView()
        .preferredColorScheme(.dark)
}
