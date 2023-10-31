//
//  PersonalMealsView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 10/31/23.
//

import SwiftUI

struct PersonalMealsView: View {
    @State private var selectedSegment = 0

    var body: some View {
        VStack {
            Picker(selection: $selectedSegment, label: Text("Select a View")) {
                Text("Saved Meals").tag(0)
                Text("Personal Meals").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if selectedSegment == 0 {
                EmptyListView()
            } else {
                Text("View 2 Content")
                    .font(.title)
            }

            Spacer() // Pushes the Picker to the top
        }
        .background(Color("bgColor"))
    }
}


#Preview {
    PersonalMealsView()
        .preferredColorScheme(.dark)
}
