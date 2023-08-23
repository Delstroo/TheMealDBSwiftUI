//
//  DetailImageView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import SwiftUI

struct DetailImageView: View {
    var meal: Meals

    var body: some View {
        if   meal.strMealThumb != ""{
            // In DetailImageView.swift
            AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { img in
                img
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 150)
            } placeholder: {
                ProgressView()
            }

        }  else {
            Image(systemName: "photo.artframe")
                .imageScale(.large)
        }
    }
}

struct DetailImageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageView(meal: .mealTest)
    }
}
