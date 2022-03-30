//
//  Prospects.swift
//  HotProspects
//
//  Created by Alexey Morozov on 20.03.2022.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    
    var name = "Anonymus"
    var emailAddress = ""
    var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    let saveKey = "prospects"
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func addProspect(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedValue = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decodedValue
                return
            }
        }
        
        people = []
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
}
