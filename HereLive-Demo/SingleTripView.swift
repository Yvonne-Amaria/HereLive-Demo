//
//  SingleTripView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}

struct SingleTripView: View {
    @State private var budget: String = ""
    @State private var totalSpent: Double = 0
    @State private var travelExpenses: Double = 0
    @State private var accommodationExpenses: Double = 0
    @State private var foodExpenses: Double = 0
    @State private var transportationExpenses: Double = 0
    @State private var showingDietaryOptions = false
    @State private var dietaryRestrictions: [String] = []
    @State private var navigateToTravel = false
    @State private var navigateToAccommodations = false
    @State private var navigateToTransportation = false

    var dietaryOptions = ["Vegetarian", "Vegan", "Gluten-Free", "Keto", "Halal", "Kosher"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Plan Your Solo Trip")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    
                    TextField("Enter your budget", text: $budget)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
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
                        
                        Button("Find Food Spots/Options") {
                            showingDietaryOptions.toggle()
                        }
                        .sheet(isPresented: $showingDietaryOptions) {
                            DietaryOptionsView(selectedOptions: $dietaryRestrictions)
                        }
                        
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
                    
                    Group {
                        ExpenseInputView(label: "Travel Expenses", amount: $travelExpenses)
                        ExpenseInputView(label: "Accommodation Expenses", amount: $accommodationExpenses)
                        ExpenseInputView(label: "Food Expenses", amount: $foodExpenses)
                        ExpenseInputView(label: "Transportation Expenses", amount: $transportationExpenses)
                    }
                    
                    let totalExpenses = travelExpenses + accommodationExpenses + foodExpenses + transportationExpenses
                    Text("Total Expenses: \(totalExpenses, specifier: "%.2f")")
                        .font(.headline)
                        .padding()
                    
                    if let budgetDouble = Double(budget), totalExpenses > budgetDouble {
                        Text("Total is \(totalExpenses - budgetDouble, specifier: "%.2f") above your budget. You have to save \(totalExpenses - budgetDouble, specifier: "%.2f") more to achieve your goal.")
                            .foregroundColor(.red)
                            .padding()
                    }
                    
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
            .navigationBarTitle("Solo Trip Planner", displayMode: .inline)
        }
    }
}

// Other structs like ExpenseInputView and DietaryOptionsView remain unchanged


struct ExpenseInputView: View {
    var label: String
    @Binding var amount: Double
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(Color.black)
            Spacer()
            TextField("0", value: $amount, formatter: NumberFormatter())
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}

struct DietaryOptionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedOptions: [String]
    let options = ["Vegetarian", "Vegan", "Gluten-Free", "Keto", "Halal", "Kosher"]
    @State private var navigateToFoodLink = false

    var body: some View {
        NavigationView {
            List {
                ForEach(options, id: \.self) { option in
                    MultipleSelectionRow(title: option, isSelected: selectedOptions.contains(option)) {
                        if selectedOptions.contains(option) {
                            selectedOptions.removeAll(where: { $0 == option })
                        } else {
                            selectedOptions.append(option)
                        }
                    }
                }
            }
            .navigationBarTitle("Select Dietary Options", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Done") {
                    navigateToFoodLink = true
                }
            )
            .background(
                NavigationLink(
                    destination: SafariView(url: URL(string: "https://www.tripadvisor.com/Restaurants")!),
                    isActive: $navigateToFoodLink
                ) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(isSelected ? Color.green : Color.black)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.green)
                }
            }
        }
        .foregroundColor(.black)
    }
}

struct SingleTripView_Previews: PreviewProvider {
    static var previews: some View {
        SingleTripView()
    }
}
