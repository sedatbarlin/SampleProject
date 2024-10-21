//
//  Sponsor.swift
//  SampleProject
//
//  Created by Sedat on 21.10.2024.
//

import Foundation

// MARK: - Welcome (for Sponsors)
struct SponsorResponse: Codable {
    let status: Int
    let message: String?
    let data: [SponsorCategory]
}

// MARK: - SponsorCategory
struct SponsorCategory: Codable {
    let id: Int
    let name: String?
    let createdAt: String
    let updatedAt: UpdatedAt
    let order: Int
    let sponsors: [Sponsor]

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case order, sponsors
    }
}

// MARK: - Sponsor
struct Sponsor: Codable {
    let id: Int
    let title, logoPath: String
    let order: Int
    let createdAt, updatedAt: String
    let categoryID: Int

    enum CodingKeys: String, CodingKey {
        case id, title
        case logoPath = "logo_path"
        case order
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case categoryID = "category_id"
    }
}

enum UpdatedAt: String, Codable {
    case the20241019T072308000000Z = "2024-10-19T07:23:08.000000Z"
    case the20241019T072337000000Z = "2024-10-19T07:23:37.000000Z"
}
