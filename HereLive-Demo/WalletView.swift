//
//  WalletView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

import SwiftUI

struct WalletView: View {
    @State private var balance: Double = 1000.00
    @State private var amountToAdd: String = ""
    @State private var newCategoryName: String = ""
    @State private var newCategoryGoalAmount: String = ""
    @State private var savingCategories: [SavingCategory] = [
        SavingCategory(name: "Trip to Disneyland", goalAmount: 500.00, savedAmount: 100.00)
    ]
    @State private var showingAddCategory = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Wallet Balance").foregroundColor(.orange)) {
                    Text("$\(balance, specifier: "%.2f")")
                        .font(.title2)
                        .foregroundColor(.green)
                }

                Section(header: Text("Add Funds").foregroundColor(.orange)) {
                    TextField("Amount", text: $amountToAdd)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Add to Wallet") {
                        addFunds()
                    }
                    .foregroundColor(.green)
                }
                
                ForEach(savingCategories.indices, id: \.self) { index in
                    SavingCategoryView(category: $savingCategories[index], balance: $balance)
                }

                Button(action: {
                    showingAddCategory.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.orange)
                        Text("Add Saving Category")
                            .foregroundColor(.green)
                    }
                }
                .sheet(isPresented: $showingAddCategory) {
                    AddSavingCategoryView(newCategoryName: $newCategoryName, newCategoryGoalAmount: $newCategoryGoalAmount, onSave: addNewCategory)
                }
            }
            .navigationTitle("My Wallet")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .foregroundColor(.orange)
                    }
                }
            }
        }
    }

    private func addFunds() {
        guard let amount = Double(amountToAdd), amount > 0 else {
            return
        }
        balance += amount
        amountToAdd = ""
    }

    private func addNewCategory() {
        guard !newCategoryName.isEmpty, let goalAmount = Double(newCategoryGoalAmount), goalAmount > 0 else { return }
        let newCategory = SavingCategory(name: newCategoryName, goalAmount: goalAmount, savedAmount: 0.00)
        savingCategories.append(newCategory)
        newCategoryName = ""
        newCategoryGoalAmount = ""
    }
}

struct SavingCategoryView: View {
    @Binding var category: SavingCategory
    @Binding var balance: Double

    var body: some View {
        VStack(alignment: .leading) {
            Text(category.name)
                .font(.headline)
                .foregroundColor(.orange)
            Text("Saved: $\(category.savedAmount, specifier: "%.2f") / $\(category.goalAmount, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(.green)

            if category.goalAmount > 0 {
                Slider(value: Binding(
                    get: { self.category.savedAmount },
                    set: { newValue in
                        self.category.savedAmount = min(newValue, self.category.goalAmount)
                    }),
                    in: 0...max(1, category.goalAmount),
                    step: 1.0
                )

                Button("Add to Saving") {
                    addToSaving()
                }
                .buttonStyle(.bordered)
                .tint(.orange)
            } else {
                Text("Set a goal amount to start saving.")
                    .italic()
                    .foregroundColor(.gray)
            }
        }
    }

    private func addToSaving() {
        let amountToAdd = 50.00 // Example addition
        if balance >= amountToAdd && (category.savedAmount + amountToAdd <= category.goalAmount) {
            category.savedAmount += amountToAdd
            balance -= amountToAdd
        }
    }
}

struct AddSavingCategoryView: View {
    @Binding var newCategoryName: String
    @Binding var newCategoryGoalAmount: String
    var onSave: () -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Category Name", text: $newCategoryName)
                TextField("Goal Amount", text: $newCategoryGoalAmount)
                    .keyboardType(.decimalPad)
                Button("Save Category") {
                    onSave()
                }
                .foregroundColor(.green)
            }
            .navigationTitle("New Category")
            .navigationBarItems(leading: Button("Cancel") {
                newCategoryName = ""
                newCategoryGoalAmount = ""
            })
        }
    }
}

struct SavingCategory: Identifiable {
    let id = UUID()
    var name: String
    var goalAmount: Double
    var savedAmount: Double
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
