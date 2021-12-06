//
//  LinkPreview.swift
//  SwiftUISample
//
//  Created by kangnux on 2021/12/06.
//

import SwiftUI
import LinkPresentation

struct LinkPreview: UIViewRepresentable {
    var metaData: LPLinkMetadata
    
    func makeUIView(context: Context) -> LPLinkView {
        let preview = LPLinkView(metadata: metaData)
        return preview
    }
    
    func updateUIView(_ uiView: LPLinkView, context: Context) {
        uiView.metadata = metaData
    }
}
