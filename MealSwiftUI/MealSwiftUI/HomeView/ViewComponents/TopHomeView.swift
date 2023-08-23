//
//  TopHomeView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import SwiftUI

struct TopHomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("What Are")
                HStack {
                    Text("We")
                        .foregroundColor(.blue)
                    Text("Cooking Today?")
                }//: HStack
            }
            .font(.largeTitle.bold())
        }//VStack
        .padding(.horizontal, 12)
    }
}

struct TopHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TopHomeView()
    }
}
