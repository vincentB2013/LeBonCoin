//
//  ContentView.swift
//  leboncoin
//
//  Created by 838410 on 14/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Item]()
    
    //let results = Bundle.main.decode([Item].self, from: "leboncoin.json")
    
    
    //détecté l'apparition d'un écran pour appeler l'API
    
    func loadData() async {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else {
            //"https://www.google.fr") else {

            print("Invalid URL")
            return
        }
        //let results = Bundle.main.decode([Item].self, from: "leboncoin.json")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            
                
          // ensure there is data returned from this HTTP response
            if let decodedResponse = try? JSONDecoder().decode([Item].self, from: data) {
                print(decodedResponse)
            }
             
            
        } catch {
            print("Pas réussi à se connecter")
        }
        

    }

    //let items = Bundle.main.decode([Item].self, from: "leboncoin.json")
    var body: some View {
        VStack {
            List {
                ForEach(results) { item in
                    //Section(item.id){
                    Text("toto \(item.id) \(item.category_id) \(item.creation_date) \(item.price) \(item.images_url.small) \(item.images_url.thumb)")
                    //}
                }
            }.task {
                await loadData()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
