//
//  ContentView.swift
//  dataFetching
//
//  Created by flavio on 06/11/22.
//

import SwiftUI

struct UserModel: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
}

struct ContentView: View {
    @State private var users = [UserModel]()
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                        .foregroundColor(Color("skyBlue"))
                    Text(user.username)
                        .font(.body)
                        .foregroundColor(.secondary)
                    Text(user.email)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .navigationBarTitle("Users API")
            .task {
                await fetchData()
            }
        }
    }
    
    func fetchData() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("This URL is not working!")
            return
            }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([UserModel].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("These data are not valid")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
