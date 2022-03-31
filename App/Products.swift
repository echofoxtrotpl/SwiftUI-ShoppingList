//
//  Products.swift
//  Shopping List
//
//  Created by Sebastian Zdybiowski on 24/03/2022.
//

import Foundation

@MainActor
class Products : ObservableObject {
    @Published var items = [ProductItem]()
    private var baseURL = "https://example.com"
    
    func addProduct (_ product : ProductItem) async {
        items.append(product)
        
        guard let encoded = try? JSONEncoder().encode(product) else {
            print("Encoding product error")
            return
        }
        
        let url = URL(string: "\(baseURL)/products")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (_, _) = try await URLSession.shared.upload(for: request, from: encoded)
        } catch {
            print("Upload failed")
        }
    }
    
    func removeProduct (id: UUID, offsets: IndexSet) {
        let url = URL(string: "\(baseURL)/products?id=\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request).resume()
        
        items.remove(atOffsets: offsets)
    }
    
    func updateProduct (_ product: ProductItem) async {
        guard let encoded = try? JSONEncoder().encode(product) else {
            print("Encoding product error")
            return
        }
        
        let url = URL(string: "\(baseURL)/products")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            items.removeAll(where: { item in
                product.id == item.id
            })
            
            if let decodedResponse = try? JSONDecoder().decode(ProductItem.self, from: data) {
                items.append(decodedResponse)
            }
        } catch {
            print("Update failed")
        }
    }
    
    func getAllProducts () async {
        let url = URL(string: "\(baseURL)/products")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([ProductItem].self, from: data) {
                items = decodedResponse
            }
        } catch {
            print("Fetch error")
        }
    }
}
