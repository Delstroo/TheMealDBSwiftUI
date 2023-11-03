//
//  MealSwiftUIApp.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import SwiftUI

@main
struct MealSwiftUIApp: App {
    @Namespace static var animation
    @StateObject var mealService = MealService()//

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(animation: MealSwiftUIApp.animation)
                    .environmentObject(mealService)
            }
        }
    }
}
