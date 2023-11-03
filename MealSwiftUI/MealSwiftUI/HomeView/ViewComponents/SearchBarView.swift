//
//  SearchBarView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 10)
            
            Divider()
                .frame(height: 30)
            
            TextField("Search", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(8)
                .background(Color(.systemGray5))
                .cornerRadius(25)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(4)
                }
                .transition(.scale)
                .animation(.default)
            }
        }
        .background(Color(.systemGray5))
        .frame(height: 40)
        .clipShape(RoundedRectangle(cornerRadius: .infinity))
    }
}

struct ContentView: View {
    @State private var searchText = ""

    var body: some View {
        VStack {
            CustomSearchBar(searchText: $searchText)
                .padding()

            // Your content here
        }
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
