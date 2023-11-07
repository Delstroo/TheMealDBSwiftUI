//
//  ContentView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mealService: MealService
    @StateObject var homeVM = HomeViewModel()
    @State private var selectedMeal: Categories?
    @State private var savedMeals: [String] = UserDefaults.standard.stringArray(forKey: "SavedMeals") ?? []

    var searchTextBinding: Binding<String> {
        Binding<String>(
            get: { self.homeVM.search },
            set: { newValue in self.homeVM.search = newValue }
        )
    }
    
    var animation: Namespace.ID
    @State private var isLoginViewPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack(spacing: 12) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                    .frame(width: 60, height: 60)
                    .background(Color(uiColor: .secondarySystemFill))
                    .foregroundColor(.primary)
                    .cornerRadius(15)
                    
                    Spacer() // This will push the following button to the trailing edge
                    
                    Button {
                        isLoginViewPresented.toggle()
                    } label: {
                        Image(systemName: "star.fill")
                    }
                    .frame(width: 60, height: 60)
                    .background(Color(uiColor: .secondarySystemFill))
                    .foregroundColor(.primary)
                    .cornerRadius(15)
                }
                .frame(maxWidth: .infinity) // This makes the HStack fill the width of the screen
                .padding(.horizontal, 20)
                TopHomeView()
                HStack(spacing: 12, content: {
                    RoundedRectangle(cornerRadius: 25.0)
                        .overlay {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 10)
                                    .frame(height: 12)
                                
                                Divider()
                                    .frame(height: 30)
                                
                                Text("Search")
                                    .foregroundStyle(.gray)
                                
                                Spacer()
                            }
                        }
                        .foregroundStyle(Color(.systemGray5))
                        .frame(height: 40)
                        .onTapGesture {
                            homeVM.isSearchTapped.toggle()
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)
                        .onDisappear {
                            
                        }
                })
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        
                        ForEach(MealService.CategoryMealSort.allCases, id: \.self) { category in
                            HStack {
                                Text(category.rawValue)
                                    .fontWeight(.semibold)
                                    .foregroundColor(mealService.categorySelected != category.rawValue ? Color(UIColor.secondaryLabel.withAlphaComponent(0.45)) : Color(.label))
                                    .padding(.vertical, 8)
                                    .padding(.leading, 12)
                                    .frame(maxWidth: .infinity)
                                
                                Image(category.rawValue)
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing, 12)
                                //                                    .padding(.leading, 6)
                            }
                            .background {
                                if mealService.categorySelected == category.rawValue {
                                    Capsule()
                                        .fill(Color("sliderColor").opacity(0.55))
                                        .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                                        .matchedGeometryEffect(id: "MENU", in: animation)
                                }
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut){
                                    mealService.categorySelected = category.rawValue
                                    homeVM.search = ""
                                    
                                }
                            }
                        }
                    }//:Hstack
                    .padding(.horizontal, 12)
                }//:ScrollView
                
                LazyVGrid(columns: [
                    GridItem(.flexible()), // You can adjust .flexible() as needed
                    GridItem(.flexible())
                ]) {
                    ForEach(mealService.mealCategory, id: \.self) { meal in
                        NavigationLink(
                            destination:  MealDetailView(detailVM: DetailViewModel(categoryDescription: meal), isStarred: meal.isStarred),
                            tag: meal,
                            selection: $selectedMeal
                        ) {
                            CategoryView(category: meal)
                        }
                        .isDetailLink(false)
                        .background(Color("bgColor"))
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .background(Color("bgColor"))
            .fullScreenCover(isPresented: $homeVM.isSearchTapped, content: {
                NavigationStack {
                    MealSearchView()
                }
            })
            
            .sheet(isPresented: $isLoginViewPresented, content: {
                NavigationStack {
                    SavedMealsView()
                }
                .transition(.identity)
            })
            
            .onChange(of: mealService.categorySelected, perform: { newCategory in
                Task {
                    await mealService.fetchMealCategory(category: newCategory)
                }
            })
            .task {
                await mealService.fetchMealCategory(category: mealService.categorySelected)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @Namespace static var animation

    static var previews: some View {
        HomeView(animation: animation)
            .environmentObject(MealService()) // Provide the MealService environment object here
            .preferredColorScheme(.dark)
    }
}
