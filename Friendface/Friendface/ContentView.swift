//
//  ContentView.swift
//  Friendface
//
//  Created by Alexey Morozov on 15.03.2022.
//

import SwiftUI
import CoreData

struct UserListItem: View {
    var user: CachedUser
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 32, height: 32)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                if user.isActive {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                        .offset(x: 4, y: 4)
                }
                
            }
            .padding(.vertical)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 4) {
                    Text(user.name ?? "")
                        .font(.headline)
                    
                }
                Text(user.company ?? "")
                    .font(.subheadline)
            }
        }
    }
}

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<CachedUser>
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            List{
                ForEach(users) { user in
                    NavigationLink {
                        UserDetailsView(user: user)
                    } label: {
                        UserListItem(user: user)
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Friendface")
            .task {
                await loadUsers()
            }
        }
    }
    
    func loadUsers() async {
        do {
            let url = URL(string:  "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let users = try decoder.decode([User].self, from: data)
            await MainActor.run {
                cacheUser(users: users)
            }
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    func cacheUser(users: [User]) {
        do {
        for user in users {
            let cachedUser = CachedUser(context: moc)
            cachedUser.id = user.id
            cachedUser.name = user.name
            cachedUser.registered = user.registered
            cachedUser.email = user.email
            cachedUser.about = user.about
            cachedUser.age = Int16(user.age)
            cachedUser.isActive = user.isActive
            cachedUser.company = user.company
            cachedUser.friends = []
            
            for friend in user.friends {
                let cachedFriend = CachedFriend(context: moc)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                
                cachedUser.addToFriends(cachedFriend)
            }
            
        }
        
            try moc.save()
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
