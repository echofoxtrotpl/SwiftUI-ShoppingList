//
//  AddView.swift
//  Shopping List
//
//  Created by Sebastian Zdybiowski on 24/03/2022.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var products: Products
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var quantity = 1
    @State private var price = 0.0
    @State private var isPromotional = false
    @State private var promotionDescription = ""
    @State private var additionalInfo = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Nazwa produktu", text: $name)
                    Stepper("\(quantity) sztuk", value: $quantity)
                    ZStack (alignment: .topLeading) {
                        if additionalInfo.isEmpty {
                            Text(" Dodatkowe informacje")
                                .opacity(additionalInfo.isEmpty ? 0.25 : 1)
                                .padding(.top, 10)
                        }
                        TextEditor(text: $additionalInfo)
                            .frame(minHeight: 80)

                    }
                }
                
                Section {
                    Toggle(isOn: $isPromotional) {
                        Text("Jest w promocji?")
                    }
                }
                    
                if isPromotional {
                    Section (header: Text("Szczegóły promocji")) {
                        TextField("PLN", value: $price, format: .currency(code: "PLN"))
                            .keyboardType(.decimalPad)
                        ZStack (alignment: .topLeading) {
                            if promotionDescription.isEmpty {
                                Text(" Opis promocji")
                                    .opacity(promotionDescription.isEmpty ? 0.25 : 1)
                                    .padding(.top, 10)
                            }
                            TextEditor(text: $promotionDescription)
                                .frame(minHeight: 80)
                        }
                    }
                }
            }
            .navigationTitle("Dodaj produkt")
            .toolbar {
                Button("Zapisz") {
                    Task {
                        await products.addProduct(ProductItem(name: name, quantity: quantity, price: price, isPromotional: isPromotional, promotionDescription: promotionDescription, additionalInfo: additionalInfo))
                        
                        dismiss()
                    }
                }
            }
        }
    }
}
