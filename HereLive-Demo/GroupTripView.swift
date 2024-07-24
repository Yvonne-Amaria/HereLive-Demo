//
//  GroupTripView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

//import SwiftUI
//import SafariServices
//
//struct GroupTripView: View {
//    @State private var budget: String = ""
//    @State private var numberOfAdults = 1
//    @State private var numberOfChildren = 0
//    @State private var showingGroupOptions = false
//    @State private var totalSpent: Double = 0
//    @State private var travelExpenses: Double = 0
//    @State private var accommodationExpenses: Double = 0
//    @State private var foodExpenses: Double = 0
//    @State private var transportationExpenses: Double = 0
//    @State private var navigateToTravel = false
//    @State private var navigateToAccommodations = false
//    @State private var navigateToTransportation = false
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(alignment: .leading) {
//                    Text("Plan Your Group Trip")
//                        .font(.largeTitle)
//                        .foregroundColor(.orange)
//
//                    Button("Select Group Size") {
//                        showingGroupOptions = true
//                    }
//                    .sheet(isPresented: $showingGroupOptions) {
//                        GroupSizeSelector(numberOfAdults: $numberOfAdults, numberOfChildren: $numberOfChildren)
//                    }
//
//                    if showingGroupOptions {
//                        Text("Adults: \(numberOfAdults), Children: \(numberOfChildren)")
//                            .foregroundColor(Color.green)
//                            .padding()
//                    }
//
//                    TextField("Enter your budget", text: $budget)
//                        .keyboardType(.numberPad)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
//
//                    navigationLinksGroup()
//                    expenseInputsGroup()
//                    totalExpensesView()
//
//                    dealsLinkView()
//                }
//            }
//            .navigationBarTitle("Group Trip Planner", displayMode: .inline)
//        }
//    }
//
//    private func navigationLinksGroup() -> some View {
//        Group {
//            Button("Find Travel Option") {
//                navigateToTravel = true
//            }
//            .background(
//                NavigationLink("", destination: SafariView(url: URL(string: "https://www.expedia.com/lp/b/vacations/planning")!), isActive: $navigateToTravel)
//                    .hidden()
//            )
//
//            Button("Find Hotels or AirBnB") {
//                navigateToAccommodations = true
//            }
//            .background(
//                NavigationLink("", destination: SafariView(url: URL(string: "https://www.expedia.com/Accommodations")!), isActive: $navigateToAccommodations)
//                    .hidden()
//            )
//
//            Button("Find Ground Transportation Rental") {
//                navigateToTransportation = true
//            }
//            .background(
//                NavigationLink("", destination: SafariView(url: URL(string: "https://www.tripadvisor.com/RentalCars")!), isActive: $navigateToTransportation)
//                    .hidden()
//            )
//        }
//        .padding()
//        .foregroundColor(Color.green)
//    }
//
//    private func expenseInputsGroup() -> some View {
//        Group {
//            ExpenseInputView(label: "Travel Expenses", amount: $travelExpenses)
//            ExpenseInputView(label: "Accommodation Expenses", amount: $accommodationExpenses)
//            ExpenseInputView(label: "Food Expenses", amount: $foodExpenses)
//            ExpenseInputView(label: "Transportation Expenses", amount: $transportationExpenses)
//        }
//    }
//
//    private func totalExpensesView() -> some View {
//        let totalExpenses = travelExpenses + accommodationExpenses + foodExpenses + transportationExpenses
//        return Group {
//            Text("Total Expenses: \(totalExpenses, specifier: "%.2f")")
//                .font(.headline)
//                .padding()
//
//            if let budgetDouble = Double(budget), totalExpenses > budgetDouble {
//                Text("Total is \(totalExpenses - budgetDouble, specifier: "%.2f") above your budget. You have to save \(totalExpenses - budgetDouble, specifier: "%.2f") more to achieve your goal.")
//                    .foregroundColor(.red)
//                    .padding()
//            }
//        }
//    }
//
//    private func dealsLinkView() -> some View {
//        NavigationLink(destination: DealsView()) {
//            HStack {
//                Image(systemName: "tag.fill")
//                    .foregroundColor(Color.orange)
//                Text("Find Coupons and Deals")
//                    .foregroundColor(Color.green)
//            }
//        }
//        .padding()
//    }
//}
//
//// Selector for number of adults and children
//struct GroupSizeSelector: View {
//    @Binding var numberOfAdults: Int
//    @Binding var numberOfChildren: Int
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Stepper("Number of Adults: \(numberOfAdults)", value: $numberOfAdults, in: 1...10)
//                Stepper("Number of Children: \(numberOfChildren)", value: $numberOfChildren, in: 0...10)
//            }
//            .navigationBarItems(trailing: Button("Done") {
//                presentationMode.wrappedValue.dismiss()
//            })
//            .navigationBarTitle("Select Group Size", displayMode: .inline)
//        }
//    }
//}
//
//struct GroupTripView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupTripView()
//    }
//}


import SwiftUI
import SafariServices

struct GroupTripView: View {
    @State private var budget: String = ""
    @State private var numberOfAdults = 1
    @State private var numberOfChildren = 0
    @State private var showingGroupOptions = false
    @State private var showingFoodOptions = false
    @State private var totalSpent: Double = 0
    @State private var travelExpenses: Double = 0
    @State private var accommodationExpenses: Double = 0
    @State private var foodExpenses: Double = 0
    @State private var transportationExpenses: Double = 0
    @State private var navigateToFood = false
    @State private var navigateToTravel = false
    @State private var navigateToAccommodations = false
    @State private var navigateToTransportation = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Plan Your Group Trip")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    
                    Button("Select Group Size") {
                        showingGroupOptions = true
                    }
                    .sheet(isPresented: $showingGroupOptions) {
                        GroupSizeSelector(numberOfAdults: $numberOfAdults, numberOfChildren: $numberOfChildren)
                    }
                    
                    if showingGroupOptions {
                        Text("Adults: \(numberOfAdults), Children: \(numberOfChildren)")
                            .foregroundColor(Color.green)
                            .padding()
                    }
                    
                    TextField("Enter your budget", text: $budget)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    navigationLinksGroup()
                    expenseInputsGroup()
                    totalExpensesView()
                    
                    Button("Set Food Preferences") {
                        showingFoodOptions = true
                    }
                    .sheet(isPresented: $showingFoodOptions) {
                        FoodOptionsView(navigateToFoodLink: $navigateToFood)
                    }
                    
                    dealsLinkView()
                }
            }
            .navigationBarTitle("Group Trip Planner", displayMode: .inline)
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

struct FoodOptionsView: View {
    @Binding var navigateToFoodLink: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Choose Food Preferences")
                .font(.headline)
                .padding()
            
            Button("Done Setting Food Preferences") {
                navigateToFoodLink = true
            }
            .padding()
        }
        .navigationBarItems(trailing: Button("Done") {
            presentationMode.wrappedValue.dismiss()
        })
    }
}

struct GroupSizeSelector: View {
    @Binding var numberOfAdults: Int
    @Binding var numberOfChildren: Int
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Stepper("Number of Adults: \(numberOfAdults)", value: $numberOfAdults, in: 1...10)
                Stepper("Number of Children: \(numberOfChildren)", value: $numberOfChildren, in: 0...10)
            }
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitle("Select Group Size", displayMode: .inline)
        }
    }
}

struct GroupTripView_Previews: PreviewProvider {
    static var previews: some View {
        GroupTripView()
    }
}
