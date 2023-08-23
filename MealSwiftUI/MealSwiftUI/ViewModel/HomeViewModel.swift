//
//  HomeViewModel.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import SwiftUI

final class HomeViewModel: ObservableObject {

    @Published var search = ""
    @Published var isSearchTapped: Bool = false

}
