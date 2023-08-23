//
//  MealSearchView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/22/23.
//

import SwiftUI

struct MealSearchCellView: View {
    
    var meal: Meals
    
    var body: some View {
        VStack {
            HStack {
                
                AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { img in
                    img
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    Image(systemName: "photo.artframe")
                        .imageScale(.large)
                }//: AsyncImage
                VStack(alignment: .leading, spacing: 8) {
                    Text(meal.strMeal ?? "")
                        .foregroundColor(Color(uiColor: .label))
                        .font(.title3)
                        .bold()
                    HStack {
                        Text("Category:")
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                        Text(meal.strCategory ?? "")
                            .foregroundColor(Color(uiColor: .label))
                            .bold()
                    }//: HStack
                }//: VStack
                Spacer()
            }//: HStack
        }//:Vstack
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color(uiColor: .label.withAlphaComponent(0.15)), lineWidth: 4)
        }
    }
}

struct MealSearchCellView_Previews: PreviewProvider {
    static var previews: some View {
        MealSearchCellView(meal: .mealTest)
    }
}
