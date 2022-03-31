//
//  ProductItem.swift
//  Shopping List
//
//  Created by Sebastian Zdybiowski on 24/03/2022.
//

import Foundation

struct ProductItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var quantity: Int
    var price: Double
    var isPromotional: Bool
    var promotionDescription: String
    var additionalInfo: String
}
