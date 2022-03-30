//
//  UserDetailsView.swift
//  Friendface
//
//  Created by Alexey Morozov on 15.03.2022.
//

import SwiftUI
import CoreData

struct UserDetailsView: View {
    var user: CachedUser
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                HStack(alignment: .center) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 64, height: 64)
                        .scaledToFit()
                        .padding(.trailing, 24)
                    VStack(alignment: .leading) {
                        Text(user.name ?? "").font(.headline)
                        Text(user.company ?? "").font(.subheadline)
                        if user.isActive {
                            Text("active").font(.caption).foregroundColor(.gray)
                        }
                    }
                    Spacer()
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.vertical)
                
                
                if user.email != nil {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "at").foregroundColor(.gray)
                                .frame(width: 8, height: 8)
                                .scaledToFit()
                                .padding(.horizontal)
                            
                            Text(user.email!).font(.body)
                        }
                    }
                }
                
                if user.registered != nil {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "calendar").foregroundColor(.gray)
                                .frame(width: 8, height: 8)
                                .scaledToFit()
                                .padding(.horizontal)
                            
                            Text(user.registered!, style: .date).font(.body)
                        }
                    }
                }
                
                if user.about != nil {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Image(systemName: "pencil.circle").foregroundColor(.gray)
                                .frame(width: 8, height: 8)
                                .scaledToFit()
                                .padding(.horizontal)
                                .offset(y: 6)
                            
                            Text(user.about!).font(.body)
                        }
                    }
                }
                
                if user.friends != nil {
                NavigationLink {
                    List {
                        ForEach(user.friendsList) { friend in
                            Text(friend.wrappedName)
                        }
                    }
                    .listStyle(.grouped)
                    .navigationTitle("\(user.name ?? "") friends")
                    .navigationBarTitleDisplayMode(.inline)
                } label: {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Image(systemName: "person.2.fill").foregroundColor(.gray)
                                .frame(width: 8, height: 8)
                                .scaledToFit()
                                .padding(.horizontal)
                                .offset(y: 6)
                            
                            Text("Friends \(user.friendsList.count)").font(.body)
                            Spacer()
                        }
                    }
                }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Details")
    }
}


struct UserDetailsView_Previews: PreviewProvider {
    static var user = User(
        id: UUID(),
        name: "Alexey Morozov",
        age: 21,
        company: "Code Gang",
        isActive: true,
        about: "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.",
        email: "test@test.com",
        registered: Date.now,
        friends: []
    )
    
    static var previews: some View {
        let user = CachedUser()
        user.id = UUID()
        user.name = "Alexey Morozov"
        user.age = 21
        user.company = "Code Gang"
        user.isActive = true
        user.about = "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim."
        user.email = "test@test.com"
        user.registered = Date.now
        
        return NavigationView {
                
                UserDetailsView(user: user)
            }
        
    }
}
