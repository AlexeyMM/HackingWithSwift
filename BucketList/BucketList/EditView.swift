//
//  EditView.swift
//  BucketList
//
//  Created by Alexey Morozov on 17.03.2022.
//

import SwiftUI
import MapKit

struct EditView: View {
    @Environment(\.dismiss) var dismis
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Group {
                                Text(page.title).font(.headline)
                                + Text(": ")
                                + Text(page.description).italic()
                            }
                            .onTapGesture {
                                viewModel.update(from: page)
                            }
                        }
                    case .failed:
                        Text("Please, try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    viewModel.save()
                    dismis()
                }
            }
            .task {
                await viewModel.searchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = StateObject(wrappedValue: ViewModel(location: location, onSave: onSave))
    }
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in
            
        }
    }
}

