//
//  MealSearchView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/22/23.
//

import SwiftUI

struct MealSearchView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var mealService: MealService
    @State var search: String = ""
    @State var randomString = ""
    @State var mealIdeaString = ""
    @State private var savedMeals: [String] = UserDefaults.standard.stringArray(forKey: "SavedMeals") ?? []
    var placeholderStrings = ["Discover a Delicious Meal 🍽️",
                              "Find Your Next Culinary Adventure 🍴",
                              "Search for a Tasty Dish 🍔",
                              "Looking for a New Recipe? 🍳",
                              "Explore Exciting Meal Ideas 🥗",
                              "Start Your Food Journey Here 🌮",
                              "Hungry for Inspiration? 🍕",
                              "Try a New Culinary Experience 🍜",
                              "On the Hunt for Yummy Recipes? 🍰",
                              "Search for Your Next Favorite Dish 🍛"]
    
    var mealIdeasStrings = ["Beef Wellington",
                           "English Breakfast",
                           "Chicken Enhilada",
                           "Key Lime Pie",
                           "Rigatoni",
                           "Poutine",
                           "Fettuccine Alfredo",
                           "Katsudon",
                           "Salmon",
                           "French Onion Soup",
                           "Clam Chowder",
                           "Vegan Lasagna",
                           "Ratatouille"]
        
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 12, height: 12, alignment: .center)
                        .foregroundColor(Color(uiColor: .label))
                        .padding(8)
                        .background {
                            Circle()
                                .foregroundColor(Color(uiColor: .darkGray))
                        }
                }//: Button
                .buttonStyle(.plain)
            }//: HStack
            .padding(.horizontal, 22)
            .padding(.bottom, 6)
            VStack(spacing: 20) {
                CustomSearchBar(searchText: $search)
                if search != "" {
                    if !mealService.searchMeal.isEmpty {
                        ForEach(mealService.searchMeal, id: \.self) { meal in
                        NavigationLink(value: meal) {
                            MealSearchCellView(meal: meal)
                                .foregroundColor(Color(uiColor: .label))
                        }
                        .buttonStyle(.plain)
                        }//: ForEach
                    } else {
                        VStack(alignment: .center) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .foregroundStyle(Color(uiColor: .darkGray))
                                .frame(width: 80, height: 80, alignment: .center)
                            
                            Text("No Results for \"\(search)\"")
                                .font(.title2.bold())
                            
                            Text("Check the spelling or try a new search.")
                                .font(.headline)
                                .foregroundStyle(.secondary.opacity(0.65))
                        }
                    }
                } else {
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .foregroundStyle(Color(uiColor: .darkGray))
                            .frame(width: 80, height: 80, alignment: .center)
                        
                        Text(randomString)
                            .font(.title2.bold())
                        
                        Text("Try searching for \"\(mealIdeaString)\"")
                            .font(.headline)
                            .foregroundStyle(.secondary.opacity(0.65))
                    }
                    .padding(.top, 150)
                }
            }
            .padding(.horizontal, 12)
        }
        .background(Color("bgColor"))

        .navigationDestination(for: Meals.self) { meal in
            MealDetailView(detailVM: DetailViewModel(meal: meal), isStarred: savedMeals.contains(meal.idMeal))
        }
        .onChange(of: search) { newValue in
            Task {
                await mealService.fetchSearchedMeal(search: newValue)
            }
        }
        
        .onAppear {
            let placeHolderIndex = Int.random(in: 0..<placeholderStrings.count)
            randomString = placeholderStrings[placeHolderIndex]
            
            let mealIdeaIndex = Int.random(in: 0..<mealIdeasStrings.count)
            mealIdeaString = mealIdeasStrings[mealIdeaIndex]
        }
    }
}

struct MealSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MealSearchView()
                .environmentObject(MealService())
                .preferredColorScheme(.dark)
        }
    }
}
