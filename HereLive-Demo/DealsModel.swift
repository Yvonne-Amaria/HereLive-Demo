//
//  DealsModel.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import SwiftUI

class DealsViewModel: ObservableObject {
    @Published var deals: [Deal] = [
        Deal(title: "10% Off Your Next Adventure", description: "Valid on all outdoor activities.", discount: "10%", color: .green),
        Deal(title: "20% Off Dining", description: "Enjoy at selected restaurants.", discount: "20%", color: .blue),
        Deal(title: "Save 15% on Hotels", description: "Apply this on any hotel booking.", discount: "15%", color: .red)
    ]

    func claimDeal(_ deal: Deal) {
        // Implement claim logic here
        print("Claimed: \(deal.title)")
    }
}


struct Deal: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var discount: String
    var color: Color
}

