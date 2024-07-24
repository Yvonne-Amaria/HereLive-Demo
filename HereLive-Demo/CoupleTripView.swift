//
//  CoupleTripView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import SwiftUI
import SafariServices

struct CoupleTripView: View {
    @State private var budget: String = ""
    @State private var totalSpent: Double = 0
    @State private var travelExpenses: Double = 0
    @State private var accommodationExpenses: Double = 0
    @State private var foodExpenses: Double = 0
    @State private var transportationExpenses: Double = 0
    @State private var showingDietaryOptionsPerson1 = false
    @State private var showingDietaryOptionsPerson2 = false
    @State private var dietaryRestrictionsPerson1: [String] = []
    @State private var dietaryRestrictionsPerson2: [String] = []
    @State private var navigateToTravel = false
    @State private var navigateToAccommodations = false
    @State private var navigateToTransportation = false

    var dietaryOptions = ["Vegetarian", "Vegan", "Gluten-Free", "Keto", "Halal", "Kosher"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Plan Your Couple's Trip")
                        .font(.largeTitle)
                        .foregroundColor(.orange)

                    TextField("Enter your budget", text: $budget)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    navigationLinksGroup()
                    expenseInputsGroup()
                    totalExpensesView()
                    
                    // Dietary options for Person 1
                    Button("Dietary Options for Person 1") {
                        showingDietaryOptionsPerson1.toggle()
                    }
                    .sheet(isPresented: $showingDietaryOptionsPerson1) {
                        DietaryOptionsView(selectedOptions: $dietaryRestrictionsPerson1)
                    }
                    
                    // Dietary options for Person 2
                    Button("Dietary Options for Person 2") {
                        showingDietaryOptionsPerson2.toggle()
                    }
                    .sheet(isPresented: $showingDietaryOptionsPerson2) {
                        DietaryOptionsView(selectedOptions: $dietaryRestrictionsPerson2)
                    }

                    dealsLinkView()
                }
            }
            .navigationBarTitle("Couple's Trip Planner", displayMode: .inline)
        }
    }
    
    private func navigationLinksGroup() -> some View {
        Group {
            Button("Find Travel Option") {
                navigateToTravel = true
            }
            .background(
                NavigationLink("", destination: SafariView(url: URL(string: "https://www.expedia.com/lp/b/vacations/planning")!), isActive: $navigateToTravel)
                    .hidden()
            )
            
            Button("Find Hotels or AirBnB") {
                navigateToAccommodations = true
            }
            .background(
                NavigationLink("", destination: SafariView(url: URL(string: "https://www.expedia.com/Accommodations")!), isActive: $navigateToAccommodations)
                    .hidden()
            )
            
            Button("Find Ground Transportation Rental") {
                navigateToTransportation = true
            }
            .background(
                NavigationLink("", destination: SafariView(url: URL(string: "https://www.tripadvisor.com/RentalCars")!), isActive: $navigateToTransportation)
                    .hidden()
            )
        }
        .padding()
        .foregroundColor(Color.green)
    }
    
    private func expenseInputsGroup() -> some View {
        Group {
            ExpenseInputView(label: "Travel Expenses", amount: $travelExpenses)
            ExpenseInputView(label: "Accommodation Expenses", amount: $accommodationExpenses)
            ExpenseInputView(label: "Food Expenses", amount: $foodExpenses)
            ExpenseInputView(label: "Transportation Expenses", amount: $transportationExpenses)
        }
    }
    
    private func totalExpensesView() -> some View {
        let totalExpenses = travelExpenses + accommodationExpenses + foodExpenses + transportationExpenses
        return Group {
            Text("Total Expenses: \(totalExpenses, specifier: "%.2f")")
                .font(.headline)
                .padding()
            
            if let budgetDouble = Double(budget), totalExpenses > budgetDouble {
                Text("Total is \(totalExpenses - budgetDouble, specifier: "%.2f") above your budget. You have to save \(totalExpenses - budgetDouble, specifier: "%.2f") more to achieve your goal.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
    
    private func dealsLinkView() -> some View {
        NavigationLink(destination: DealsView()) {
            HStack {
                Image(systemName: "tag.fill")
                    .foregroundColor(Color.orange)
                Text("Find Coupons and Deals")
                    .foregroundColor(Color.green)
            }
        }
        .padding()
    }
}
// DietaryOptionsView, MultipleSelectionRow, SafariView are used as already defined


struct CoupleTripView_Previews: PreviewProvider {
    static var previews: some View {
        CoupleTripView()
    }
}
