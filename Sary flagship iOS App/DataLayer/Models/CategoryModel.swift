//
//  CategoryModel.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

import Foundation

// MARK: - Result
struct Group: Codable {
    var id: Int?
    var title: String?
    var data: [Category]?
    var dataType: String?
    var showTitle: Bool?
    var uiType: String?
    var rowCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, data
        case dataType = "data_type"
        case showTitle = "show_title"
        case uiType = "ui_type"
        case rowCount = "row_count"
    }
}

// MARK: - Datum
struct Category: Codable {
    var groupID: Int?
    var filters: [Filter]?
    var name: String?
    var image: String?
    var emptyContentImage: String?
    var emptyContentMessage: String?
    var hasData, showUnavailableItems, showInBrochureLink: Bool?
    var deepLink: String?

    enum CodingKeys: String, CodingKey {
        case groupID = "group_id"
        case filters, name, image
        case emptyContentImage = "empty_content_image"
        case emptyContentMessage = "empty_content_message"
        case hasData = "has_data"
        case showUnavailableItems = "show_unavailable_items"
        case showInBrochureLink = "show_in_brochure_link"
        case deepLink = "deep_link"
    }
}

// MARK: - Filter
struct Filter: Codable {
    var filterID: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case filterID = "filter_id"
        case name
    }
}
