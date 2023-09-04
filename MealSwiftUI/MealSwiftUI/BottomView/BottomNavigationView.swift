//
//  BottomNavigationView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 9/4/23.
//

import SwiftUI

struct BottomToolbarView: View {
    var homeAction: () -> Void
    var addRecipeAction: () -> Void
    var accountAction: () -> Void

    var body: some View {
        VStack {
            Divider()
                .padding(.top, 10)
            
            HStack(spacing: 20) {
                Button(action: homeAction) {
                    Image(systemName: "house.fill")
                }
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
                
                Button(action: addRecipeAction) {
                    Image(systemName: "plus.circle.fill")
                }
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
                
                Button(action: accountAction) {
                    Image(systemName: "person.fill")
                }
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
            }
            .padding(.bottom, 10)
        }
    }
}
