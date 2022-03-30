//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Alexey Morozov on 13.03.2022.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct FetchExampleView: View {
    @State var results = [Result]()
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                image.resizable().frame(width: 200, height: 200)
            } placeholder: {
                ProgressView()
            }.frame(width: 200, height: 200)
            List(results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResult = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResult.results
            }
        } catch {
            return
        }
        
    }
}

struct FetchExampleView_Previews: PreviewProvider {
    static var previews: some View {
        FetchExampleView()
    }
}
