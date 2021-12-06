//
//  Message.swift
//  SwiftUISample
//
//  Created by kangnux on 2021/12/06.
//

import LinkPresentation

struct Message: Identifiable {
    var id = UUID().uuidString
    var messageString: String
    var date: Date = Date()
    var previewLoading: Bool = false
    var linkMetaData: LPLinkMetadata?
    var linkURL: URL?
}
