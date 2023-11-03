//
//  JsonMealsView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 10/31/23.
//

import SwiftUI

import SwiftUI

// Step 1: Define an updated data model
struct Meal: Codable, Identifiable, Equatable {
    let id = UUID() // Add an ID for identifying meals
    var name: String
    var description: String
    var image: String // You can use a URL or a filename
    var ingredients: [String] // Dictionary to represent ingredients and quantities
    
    static let cheesecake = Meal(
        name: "Cheesecake",
        description: "Creamy and delicious cheesecake with a graham cracker crust.",
        image: "cheesecake.jpg", // You can use an image URL or filename
        ingredients: [
            "Cream Cheese 16 oz",
            "Sugar 1 cup",
            "Sour Cream 1 cup",
            "Vanilla Extract 1 tsp",
            "Eggs 4",
            "Graham Cracker Crumbs 1.5 cups",
            "Butter 1/2 cup"
        ]
    )
}

struct JsonMealsView: View {
    @State var meal: Meal
    @State var meals: [Meal] = []
    @State var editMode = false

    var body: some View {
        NavigationView {
            List {
                    if editMode {
                        // Edit mode with TextFields
                        MealEditView(mealData: MealData(meal: meal))
//                        $meals[meals.firstIndex(of: meal)!
                    } else {
                        // Default mode with Text elements
                        VStack(alignment: .leading) {
                            Text(meal.name)
                            Text(meal.description)
                            Text("Ingredients:")
                            ForEach(meal.ingredients.sorted(by: <), id: \.key) { (ingredient, quantity) in
                                Text("\(ingredient): \(quantity)")
                            }
                        }
                    }
            }
            .navigationTitle("Meal List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(editMode ? "Done" : "Edit") {
                        editMode.toggle()
                    }
                }
            }
        }
        .onAppear(perform: loadMeals)
    }

    // Step 2: Save data to JSON
    func saveMeals() {
        do {
            let data = try JSONEncoder().encode(meal)
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent("meals.json")
                try data.write(to: fileURL)
            }
        } catch {
            print("Error saving data: \(error)")
        }
    }

    // Step 3: Load data from JSON
    func loadMeals() {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("meals.json")
            do {
                let data = try Data(contentsOf: fileURL)
                meals = try JSONDecoder().decode([Meal].self, from: data)
            } catch {
                print("Error loading data: \(error)")
            }
        }
    }
}

class MealData: ObservableObject {
    @Published var meal: Meal

    init(meal: Meal) {
        self.meal = meal
    }
}

struct MealEditView: View {
    @ObservedObject var mealData: MealData

    init(mealData: MealData) {
        self.mealData = mealData
    }

    var body: some View {
        VStack {
            TextField("Name", text: $mealData.meal.name)
            TextField("Description", text: $mealData.meal.description)
            Text("Ingredients:")

            ForEach(mealData.meal.ingredients, id: \.self) { ingredient in
                HStack {
                    TextField("Ingredient", text: Binding(
                        get: { mealData.meal.ingredients[] ?? "" },
                        set: { mealData.meal.ingredients[ingredient] = $0 }
                    ))
                }
            }
        }
    }
}


#Preview {
    JsonMealsView(meal: Meal.cheesecake)
}
