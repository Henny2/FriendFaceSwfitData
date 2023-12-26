//
//  FriendFaceSwiftDataApp.swift
//  FriendFaceSwiftData
//
//  Created by Henrieke Baunack on 12/25/23.
//

import SwiftUI
import SwiftData

@main
struct FriendFaceSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
    }
}
