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
    
    var searchTextBinding: Binding<String> {
        Binding<String>(
            get: { self.homeVM.search },
            set: { newValue in self.homeVM.search = newValue }
        )
    }
    
    var animation: Namespace.ID
    @State private var isLoginViewPresented = false
    @State private var isToolbarVisible = true
    @State var isFilterApplied: Bool = false
    @State private var scrollOffset: CGFloat = 0
    @State private var lastContentOffset: CGFloat = 0
    
    var filteredCategories: [Categories] {
        if isFilterApplied {
            return mealService.mealCategory.sorted(by: { $1.strMeal < $0.strMeal })
        } else {
            return mealService.mealCategory.sorted(by: { $0.strMeal < $1.strMeal })
        }
    }

    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        HStack(spacing: 12) {
                            Button {
                                withAnimation(.easeInOut) {
                                    isFilterApplied.toggle()
                                }
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
                                Image(systemName: "person.fill")
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
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 25)
                                    .frame(height: 40)
                                    .foregroundColor(Color(.systemGray5))
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .foregroundColor(.gray)
                                        .frame(width: 15, height: 15, alignment: .leading)
                                    
                                    Divider()
                                        .padding(.vertical, 6)
                                    
                                    Text("Search")
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.horizontal)
                            }
                            .onTapGesture {
                                homeVM.isSearchTapped.toggle()
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
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
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: [
                                GridItem(.flexible()), // You can adjust .flexible() as needed
                                GridItem(.flexible())
                            ]) {
                                ForEach(filteredCategories, id: \.self) { meals in
                                    NavigationLink(value: meals) {
                                        CategoryView(category: meals)
                                    }
                                }
                            }
                        }
                        .navigationDestination(for: Categories.self) { meal in
                            
                            MealDetailView(detailVM: DetailViewModel(categoryDescription: meal))
                        }
                    }
                    .background(Color("bgColor"))
                    .fullScreenCover(isPresented: $homeVM.isSearchTapped, content: {
                        NavigationStack {
                            MealSearchView()
                        }
                    })//: FullScreenCover
                    .sheet(isPresented: $isLoginViewPresented) {
                        NavigationView {
                            EmptyListView()
                        }
                    }
                    .onChange(of: mealService.categorySelected, perform: { newCategory in
                        Task {
                            await mealService.fetchMealCategory(category: newCategory)
                        }
                    })
                    .task {
                        await mealService.fetchMealCategory(category: mealService.categorySelected)
                    }
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
                    .onAppear {
                        // Hide the toolbar initially
                        isToolbarVisible = true
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                        // Hide the toolbar when the keyboard is shown
                        withAnimation {
                            isToolbarVisible = false
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        // Show the toolbar when the keyboard is hidden
                        withAnimation {
                            isToolbarVisible = true
                        }
                    }
                    .onAppear {
                        // Scroll to the top initially
                        withAnimation {
                            scrollProxy.scrollTo(0, anchor: .top)
                        }
                    }
                    .simultaneousGesture(
                        DragGesture().onChanged { value in
                            let currentContentOffset = value.translation.height
                            if currentContentOffset < 0 {
                                // Scrolling down
                                isToolbarVisible = false
                            } else {
                                // Scrolling up
                                isToolbarVisible = true
                            }
                            lastContentOffset = currentContentOffset
                        }
                    )
                }
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

struct ScrollDirectionPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
