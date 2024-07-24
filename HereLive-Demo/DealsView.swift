//
//  DealsView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/22/24.
//

import SwiftUI

struct DealsView: View {
    @StateObject var viewModel = DealsViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.deals) { deal in
                    DealCard(deal: deal, claimAction: {
                        viewModel.claimDeal(deal)
                    })
                    .padding(.vertical)
                }
            }
            .navigationTitle("Deals")
        }
    }
}

struct DealCard: View {
    var deal: Deal
    var claimAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(deal.title)
                .font(.headline)
                .foregroundColor(.white)
            Text(deal.description)
                .font(.subheadline)
                .foregroundColor(.white)
            Text(deal.discount)
                .bold()
                .foregroundColor(.white)
            Button("Claim Deal", action: claimAction)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black.opacity(0.2))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
        .background(deal.color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct DealsView_Previews: PreviewProvider {
    static var previews: some View {
        DealsView()
    }
}
