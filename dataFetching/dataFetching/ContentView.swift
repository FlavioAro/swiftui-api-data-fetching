//
//  ContentView.swift
//  dataFetching
//
//  Created by flavio on 04/11/22.
//

import SwiftUI

struct Product: Codable {
    var id: String
    var name: String
    var type: String
    var brand: String
    var description: String
}

struct ContentView: View {
    @State private var products = [Product]()
    
    var body: some View {
        NavigationView {
            List(products, id: \.id) { product in
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                        .foregroundColor(Color("skyBlue"))
                    Text(product.type)
                        .font(.body)
                        .foregroundColor(.secondary)
                    Text(product.brand)
                        .font(.body)
                        .foregroundColor(.secondary)
                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Products")
            .task {
                await fetchData()
            }
        }
    }
    
    func fetchData() async {
        // create url
        guard let url = URL(string: "https://6345b3cf745bd0dbd36f6dd5.mockapi.io/product") else {
            print("This URL does not Work")
            return
        }
        
        // fetch data from that url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode that data bruther
            if let decodedResponse = try? JSONDecoder().decode([Product].self, from: data) {
                products = decodedResponse
            }
        } catch {
            print("Bad news, this data isnt valid")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

