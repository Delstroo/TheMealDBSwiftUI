//
//  ContentView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/21/23.
//

import SwiftUI

enum ScrollDirection {
    case up, down
}

struct HomeView: View {
    @EnvironmentObject var mealService: MealService
    @StateObject var homeVM = HomeViewModel()
    
    var searchTextBinding: Binding<String> {
        Binding(
            get: { self.homeVM.search },
            set: { newValue in self.homeVM.search = newValue }
        )
    }
    
    var animation: Namespace.ID
<<<<<<< Updated upstream
    var body: some View {
        NavigationStack {
            ScrollView {
                TopHomeView()
                HStack(spacing: 12, content: {
                    CustomSearchBar(searchText: searchTextBinding)
                        .onTapGesture {
                            homeVM.isSearchTapped.toggle()
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
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
=======
    @State private var isLoginViewPresented = false
    @State private var isToolbarVisible = true
    @State private var lastContentOffset: CGFloat = 0
    @State private var scrollDirection: ScrollDirection = .up
    
    var body: some View {
        ScrollViewWithDirection(scrollDirection: $scrollDirection) {
            NavigationView {
                GeometryReader { geometry in
                    ScrollViewReader { scrollProxy in
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
                                CustomSearchBar(searchText: searchTextBinding)
                                    .onTapGesture {
                                        homeVM.isSearchTapped.toggle()
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 40)
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
                                    ForEach(mealService.mealCategory, id: \.self) { meals in
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
                        .overlay(
                            VStack {
                                if isToolbarVisible {
                                    BottomToolbarView(
                                        homeAction: {},
                                        addRecipeAction: {},
                                        accountAction: { isLoginViewPresented.toggle() }
                                    )
                                    .transition(.move(edge: .bottom))
                                    .animation(.easeInOut)
>>>>>>> Stashed changes
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
                        ForEach(mealService.mealCategory, id: \.self) { meals in
                            NavigationLink(value: meals) {
                                CategoryView(category: meals)
                            }
                                .frame(width: geometry.size.width, alignment: .bottom),
                            alignment: .bottom
                        )
                        .fullScreenCover(isPresented: $homeVM.isSearchTapped) {
                            NavigationStack { MealSearchView() }
                        }
<<<<<<< Updated upstream
                    }
                }
                .navigationDestination(for: Categories.self) { meal in
                    
                    MealDetailView(detailVM: DetailViewModel(categoryDescription: meal))
=======
                        .fullScreenCover(isPresented: $isLoginViewPresented) {
                            NavigationStack { LoginView(animation: animation) }
                        }
                        .onChange(of: mealService.categorySelected) { newCategory in
                            Task {
                                await mealService.fetchMealCategory(category: newCategory)
                            }
                        }
                        .task {
                            await mealService.fetchMealCategory(category: mealService.categorySelected)
                        }
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true)
                        .onAppear {
                            isToolbarVisible = true
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                            withAnimation {
                                isToolbarVisible = false
                            }
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                            withAnimation {
                                isToolbarVisible = true
                            }
                        }
                        .onAppear {
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
>>>>>>> Stashed changes
                }
            }
            .background(Color("bgColor"))
        }//: NavigationStack
        .fullScreenCover(isPresented: $homeVM.isSearchTapped, content: {
            NavigationStack {
                MealSearchView()
            }
        })//: FullScreenCover
        
        .onChange(of: mealService.categorySelected, perform: { newCategory in
            Task{
                await mealService.fetchMealCategory(category: newCategory)
            }//: Task
            
        })//: onChange
        .task {
            await mealService.fetchMealCategory(category: mealService.categorySelected)
        }//: Task
    }
}


struct ContentView_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        HomeView(animation: animation)
            .environmentObject(MealService()) // Provide the MealService environment object here
    }
}

<<<<<<< Updated upstream
=======
struct ScrollDirectionPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct ScrollViewWithDirection<Content: View>: View {
    @Binding var scrollDirection: ScrollDirection
    @State private var lastContentOffset: CGFloat = 0

    let content: Content
    
    init(scrollDirection: Binding<ScrollDirection>, @ViewBuilder content: () -> Content) {
        self._scrollDirection = scrollDirection
        self.content = content()
    }
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView {
                content
            }
            .background(Color("bgColor"))
            .onAppear {
                scrollProxy.scrollTo(0, anchor: .top)
            }
            .simultaneousGesture(DragGesture().onChanged { value in
                let currentContentOffset = value.translation.height
                if currentContentOffset < 0 {
                    scrollDirection = .down
                } else {
                    scrollDirection = .up
                }
                lastContentOffset = currentContentOffset
            })
        }
    }
}

struct UIScrollViewWrapper: UIViewRepresentable {
    @Binding var scrollDirection: ScrollDirection
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // Update the UI if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: UIScrollViewWrapper
        
        init(_ parent: UIScrollViewWrapper) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let delta = scrollView.panGestureRecognizer.translation(in: scrollView.superview).y
            
            if delta > 0 {
                parent.scrollDirection = .down
            } else if delta < 0 {
                parent.scrollDirection = .up
            }
        }
    }
}

>>>>>>> Stashed changes
