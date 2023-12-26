//
//  UserView.swift
//  FriendFaceSwiftData
//
//  Created by Henrieke Baunack on 12/25/23.
//

import SwiftUI
import SwiftData

struct UserView: View {
    let user: User
    var body: some View {
        VStack (alignment: .center){
            Text(user.name).font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.top)
            Text(user.isActive ? "online" : "offline").fontDesign(.monospaced)
            Text(user.about).italic().padding()
            VStack(alignment: .center) {
                Text("Friends:").font(.headline)
                ForEach(user.friends, id: \.id){ friend in
                    Text(friend.name)
                }
            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding()
            Spacer()
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let example = User(id: "1", isActive: true, name: "Henny", age: 27, company: "KForce", email: "some@email.com", address: "Neverland", about: "This is me! Don't ask questions.", registered: Date.now, tags: ["active", "new"], friends: [Friend(id: "2", name: "Amy")])
        
        return UserView(user: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
