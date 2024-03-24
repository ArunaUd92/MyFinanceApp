//
//  AccountDetails.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 23/03/2024.
//

import Foundation

struct AccountDetails: Codable, Identifiable {
    let id: String
    let accountNumber: String
    let balance: Double
    let date: String
}
