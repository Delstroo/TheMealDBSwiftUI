//
//  MealSearchView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/22/23.
//

import SwiftUI

struct MealSearchView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var mealService: MealService
    @State var search: String = ""
    var body: some View {
        ScrollView {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color(uiColor: .label))
                        .padding()
                        .background {
                            Circle()
                                .foregroundColor(.secondary.opacity(0.55))
                                .frame(width: 24, height: 24)
                        }
                }//: Button
                .buttonStyle(.plain)
                Spacer()
            }//: HStack
            .padding(.horizontal, 12)
            VStack(spacing: 20) {
                CustomSearchBar(searchText: $search)
                    .resignKeyboardOnDrag()
                if search != "" {
                    ForEach(mealService.searchMeal, id: \.self) { meal in
                        NavigationLink(value: meal) {
                            MealSearchCellView(meal: meal)
                                .foregroundColor(Color(uiColor: .label))
                        }
                        .buttonStyle(.plain)
                    }//: ForEach
                }
            }
            .padding(.horizontal, 12)
        }
        .background(Color("bgColor"))

        .navigationDestination(for: Meals.self) { meal in
            MealDetailView(detailVM: DetailViewModel(meal: meal))
        }
        .onChange(of: search) { newValue in
            Task {
                await mealService.fetchSearchedMeal(search: newValue)
            }
        }
    }
}

struct MealSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MealSearchView()
                .environmentObject(MealService())
                .preferredColorScheme(.dark)
        }
    }
}

extension View {
    func resignKeyboardOnDrag() -> some View {
        return self.simultaneousGesture(DragGesture().onChanged({ _ in
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }))
    }
}
