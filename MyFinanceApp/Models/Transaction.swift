//
//  Transaction.swift
//  MyFinanceApp
//
//  Created by Aruna Udayanga on 23/03/2024.
//

import Foundation

struct Transaction: Codable, Identifiable, Equatable{
    let id: String
    let title: String
    let subtitle: String
    let amount: String
    
}
