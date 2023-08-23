//
//  CategoryView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import SwiftUI

struct CategoryView: View {
    var category: Categories
    var width = UIScreen.main.bounds.width * 0.45

    var body: some View {
            VStack(spacing: 12) {
                if category.strMealThumb != nil{
                    // In CategoryView.swift
                    AsyncImage(url: category.strMealThumb) { img in
                        img
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: width / 0.667)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .black.opacity(0.4), radius: 2, x: -6, y: 3)
                            .overlay {
                                LinearGradient(colors: [.clear, .black.opacity(0.45)], startPoint: .top, endPoint: .bottom)
                                    .cornerRadius(12)
                            }
                            .overlay(alignment: .bottomLeading) {
                                Text(category.strMeal)
                                    .multilineTextAlignment(.leading)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: width - 16, alignment: .leading)
                                    .padding(.leading, 8)
                                    .padding(.bottom, 20)
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
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: .categoryDescriptionTest)
    }
}
