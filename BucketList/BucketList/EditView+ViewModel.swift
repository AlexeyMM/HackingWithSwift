//
//  EditView+ViewModel.swift
//  BucketList
//
//  Created by Alexey Morozov on 17.03.2022.
//

import Foundation

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        @Published var name: String = ""
        @Published var description: String = ""
        
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
        @Published var location: Location
        var onSave: (Location) -> Void
        
        init(location: Location, onSave: @escaping (Location) -> Void) {
            self.onSave = onSave
            
            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
            _location = Published(wrappedValue: location)
        }
        
        func save() {
            let newLocation = Location(id: UUID(), name: name, description: description, latitude: location.latitude, longitude: location.longitude)
            onSave(newLocation)
        }
        
        func update(from page: Page) {
            name = page.title
            description = page.description
        }
        
        var wikiUrl: String {
            "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        }
        
        
        func searchNearbyPlaces() async {
            guard let url = URL(string: wikiUrl) else {
                loadingState = .failed
                return
            }
            
            do {
                let (data, _ ) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
    }
}
