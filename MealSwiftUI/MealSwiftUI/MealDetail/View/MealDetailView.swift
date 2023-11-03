//
//  MealDetailView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import SwiftUI

struct MealDetailView: View {
    @EnvironmentObject var mealService: MealService
    @StateObject var detailVM: DetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(detailVM.detailMeals) { meals in
                    VStack(alignment: .leading) {
                        // DetailImageView with matchedGeometryEffect
                        DetailImageView(meal: meals)
                        VStack {
                            // Ingredients toggle button
                            Button(action: {
                                // Toggle the drop-down state for ingredients
                                withAnimation {
                                    detailVM.isIngredientsTapped.toggle()
                                }
                            }) {
                                HStack {
                                    Text("Ingredients")
                                        .font(.title)
                                        .foregroundColor(Color(uiColor: .label))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Image(systemName: "chevron.up")
                                        .foregroundColor(.blue)
                                        .font(.title3)
                                        .rotationEffect(.degrees(detailVM.isIngredientsTapped ? 0 : 180)) // Rotate 180 degrees when transitioning
                                        .padding(.trailing, 8)

                                }//: HStack
                                .padding(.horizontal, 8)
                                .padding(.bottom, 10)
                            }
                            
                            // Ingredients
                            ForEach(meals.ingredients?.prefix(detailVM.isIngredientsTapped ? .max : 3) ?? [], id: \.self) { ing in
                                HStack {
                                    Text("•")
                                        .foregroundColor(Color(uiColor: .label))
                                    Text(ing.measure)
                                        .foregroundColor(.gray)
                                        .font(.title2) // Font size in between title3 and title
                                    Text(ing.name)
                                        .font(.title2) // Font size in between title3 and title
                                        .foregroundColor(Color(uiColor: .label))
                                    Spacer()
                                }
                                .padding(.horizontal, 8)
                            }
                            .transition(.opacity)
                            
                            // Instruction label
                            Text("Instructions")
                                .font(.title)
                                .foregroundColor(Color(uiColor: .label))
                                .padding(.horizontal, 8)
                                .padding(.top, 16)
                            
                            // Instruction text
                            Text(meals.strInstructions ?? "")
                                .font(.title2)
                                .foregroundColor(Color(uiColor: .label))
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.top, 8)
                                .padding(.horizontal, 8)
                            
                        }
                        .padding(.horizontal, 8)
                        .padding(.top, 24)
                        .background(Color("bgColor"))
                        .cornerRadius(20)
                    }

                }
            }
        }
        .background(Color("bgColor"))
        .task {
            await detailVM.fetchMealsDetail()
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(detailVM: DetailViewModel(categoryDescription: .categoryDescriptionTest))
    }
}
