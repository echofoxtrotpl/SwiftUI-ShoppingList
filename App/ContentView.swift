//
//  ContentView.swift
//  Shopping List
//
//  Created by Sebastian Zdybiowski on 24/03/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var products: Products
    @State private var showingAddProduct = false
    
    init() {
        self._products = StateObject(wrappedValue: Products())
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(products.items) { item in
                    NavigationLink {
                        EditView(product: item, updateProduct: products.updateProduct)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                HStack{
                                    Text("\(item.quantity) szt.")
                                        .font(.footnote)
                                    if !item.additionalInfo.isEmpty {
                                        Image(systemName: "exclamationmark.bubble")
                                            .font(.footnote)
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .padding(5)
                            
                            if item.isPromotional {
                                Spacer()
                                HStack (spacing: 0){
                                    Text(item.price, format: .currency(code: "PLN"))
                                    Text("/szt.")
                                }
                            }
                        }
                        .frame(height: 70)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .refreshable {
                await products.getAllProducts()
            }
            .navigationTitle("Zakupy")
            .toolbar {
                Button {
                    showingAddProduct = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddProduct) {
                AddView(products: products)
            }
            .task {
                await products.getAllProducts()
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        products.removeProduct(id: products.items[offsets.first!].id, offsets: offsets)
    }
}
