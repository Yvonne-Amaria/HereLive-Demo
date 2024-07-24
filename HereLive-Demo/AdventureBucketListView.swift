//
//  AdventureBucketListView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

import SwiftUI

struct AdventureBucketListView: View {
    @EnvironmentObject var bucketList: BucketListViewModel

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Adventure")) {
                    ForEach(bucketList.items.filter { $0.category == .adventure }) { item in
                        listItemView(item)
                    }
                }
                Section(header: Text("Event")) {
                    ForEach(bucketList.items.filter { $0.category == .event }) { item in
                        listItemView(item)
                    }
                }
            }
            .navigationTitle("Bucket List")
        }
    }

    private func listItemView(_ item: BucketListItem) -> some View {
        VStack {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text(item.location)
                .font(.headline)
                .foregroundColor(.orange)
        }
    }
}

class BucketListViewModel: ObservableObject {
    @Published var items: [BucketListItem] = []

    func addItem(_ item: BucketListItem) {
        items.append(item)
    }
}

struct BucketListItem: Identifiable {
    let id = UUID()
    let image: String
    let location: String
    let category: CategoryType
}

enum CategoryType {
    case adventure, event
}

struct AdventureBucketListView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureBucketListView()
            .environmentObject(BucketListViewModel())
    }
}
