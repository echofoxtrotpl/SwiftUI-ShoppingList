//
//  EditView.swift
//  Shopping List
//
//  Created by Sebastian Zdybiowski on 24/03/2022.
//

import SwiftUI

struct EditView: View {
    @State var product: ProductItem
    @State var updateProduct: (ProductItem) async -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("Nazwa produktu", text: $product.name)
                Stepper("\(product.quantity) sztuk", value: $product.quantity)
                ZStack (alignment: .topLeading) {
                    if product.additionalInfo.isEmpty {
                        Text(" Dodatkowe informacje")
                            .opacity(product.additionalInfo.isEmpty ? 0.25 : 1)
                            .padding(.top, 10)
                    }
                    TextEditor(text: $product.additionalInfo)
                        .frame(minHeight: 80)
                }
            }
            
            Section {
                Toggle(isOn: $product.isPromotional) {
                    Text("Jest w promocji?")
                }
            }
            
            if product.isPromotional {
                Section (header: Text("Szczegóły promocji")) {
                    TextField("PLN", value: $product.price, format: .currency(code: "PLN"))
                        .keyboardType(.decimalPad)
                
                    ZStack (alignment: .topLeading) {
                        if product.promotionDescription.isEmpty {
                            Text(" Opis promocji")
                                .opacity(product.promotionDescription.isEmpty ? 0.25 : 1)
                                .padding(.top, 10)
                        }
                        TextEditor(text: $product.promotionDescription)
                            .frame(minHeight: 80)
                    }
                }
            }
        }
        .navigationTitle("Edytuj produkt")
        .toolbar {
            Button("Zapisz") {
                Task {
                    await updateProduct(product)
                    dismiss()
                }
            }
        }
    }
}
