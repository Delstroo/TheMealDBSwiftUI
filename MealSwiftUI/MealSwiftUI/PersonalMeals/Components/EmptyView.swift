//
//  EmptyView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 10/30/23.
//

import SwiftUI

struct EmptyListView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 8) {
            
            Image("emptyBox")
                .resizable()
                .frame(width: 300, height: 300)
            
            Text("No saved recipes!")
                .font(.title).bold()
            
            Text("There are no saved recipes. \n Start saving recipes to your favorites!")
                .multilineTextAlignment(.center)
            
            Button {
                dismiss()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 200, height: 50)
                        .overlay {
                            Text("Dismiss")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                    }
                }
            }
            .padding()

        }
        .ignoresSafeArea()
    }
}

#Preview {
    EmptyListView()
        .preferredColorScheme(.dark)
}
