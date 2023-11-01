//
//  PersonalMealView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 10/31/23.
//

import SwiftUI

struct SavedMealsView: View {
//    @StateObject var viewModel: SavedMealsViewModel
    
    var body: some View {
        VStack {
            if UserDefaults.standard.stringArray(forKey: "SavedMeals") != nil {
                
            } else {
                EmptyViewState()

            }

            Spacer() // Pushes the Picker to the top
        }
        .background(Color("bgColor"))
    }
}

#Preview {
    SavedMealsView()
        .preferredColorScheme(.dark)
}
