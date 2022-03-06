//
//  BannerModel.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

import Foundation


struct Banner: Codable {
    var id: Int?
    var title, resultDescription, buttonText: String?
    var expiryStatus: Bool?
    var createdAt, startDate, expiryDate: String?
    var image: String?
    var priority: Int?
    var photo: String?
    var link, level: String?
    var isAvailable: Bool?
    var branch: Int?
    let dataType  = "banner"
    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case buttonText = "button_text"
        case expiryStatus = "expiry_status"
        case createdAt = "created_at"
        case startDate = "start_date"
        case expiryDate = "expiry_date"
        case image, priority, photo, link, level
        case isAvailable = "is_available"
        case branch
    }
}
