//
//  ContentView.swift
//  FriendFaceSwiftData
//
//  Created by Henrieke Baunack on 12/25/23.
//

// how to use URLSession and Codable to download and encode data from the internet
//https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui

// how to combine SwiftData and Codable
//https://www.hackingwithswift.com/quick-start/swiftdata/how-to-make-swiftdata-models-conform-to-codable

// why we need custom codable keys for SwiftData models to work with Codable
// https://www.donnywals.com/making-your-swiftdata-models-codable/

import SwiftUI
import SwiftData

struct ContentView: View {

    @Query var users : [User]
    @Environment(\.modelContext) var modelContext
    var numbers = [1,2,3,4]
    var body: some View {
        NavigationStack {
            VStack {
                List(users, id: \.id) { user in
                    VStack{
                        NavigationLink{
                            UserView(user: user)
                        } label: {
                            VStack{
                                HStack {
                                    Text(user.name).font(.headline)
                                    Spacer()
                                    Text(user.isActive ? "online" : "offline").fontDesign(.default).fontWeight(.light)
                                }
                                HStack{
                                    Text(user.company)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }.navigationTitle("Friends")
                .scrollContentBackground(.hidden)
        }
        .padding()
        .task {
            await loadData()
        }
    }
    
    func loadData () async {
        if(users.count > 0 ) { return }
        
        print("getting the data from the internet")
        // step 1: creating the URL we want to read from
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        // step2: fetching the data from the URL
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // making sure the date properties are decoded correctly
                let decodedData = try decoder.decode([User].self, from: data)
//                print(decodedData)
                for user in decodedData {
                    modelContext.insert(user)
                }
            } catch {
                print("There was an issue decoding the data")
            }
        } catch {
            print("There was an error fetching data from the URL")
        }
        
    }
}

#Preview {
    ContentView()
}
