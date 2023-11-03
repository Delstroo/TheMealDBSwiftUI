//
//  EmptyViewState.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 10/31/23.
//

import SwiftUI

struct EmptyViewState: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Image("emptyViewState")
                .resizable()
                .frame(width: 350, height: 350)
            
            Text("No Saved Meals")
                .font(.title)
                .foregroundColor(.primary)
                .padding(.horizontal)
            
            Text("Sorry, there are no saved meals.")
                .foregroundColor(Color(uiColor: .secondaryLabel))
                .padding(.horizontal)
            
            Text("You can add your favorite meals by tapping the")
                .foregroundColor(Color(uiColor: .secondaryLabel))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 0)
            
            HStack(alignment: .center) {
                Image(systemName: "star")
                    .foregroundStyle(.yellow)
                
                Text("button.")
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            .padding(.bottom, 24)
            
            
            Button(action: {
                dismiss()
            }, label: {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 200, height: 45)
                    .overlay {
                        Text("Dismiss")
                            .foregroundStyle(.white)
                            .font(.title3.bold())
                    }
            })
            
        }
    }
}

#Preview {
    EmptyViewState()
        .preferredColorScheme(.dark)
}
