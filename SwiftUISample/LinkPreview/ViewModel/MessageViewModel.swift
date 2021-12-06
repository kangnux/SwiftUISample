//
//  MessageViewModel.swift
//  SwiftUISample
//
//  Created by kangnux on 2021/12/06.
//

import Foundation
import UIKit
import LinkPresentation

class MessageViewModel: ObservableObject {
    @Published var message: String = ""
    @Published var messages: [Message] = []
    
    func sendMessage() {
        if !isMessageURL() {
            addToMessage()
        }
        
        guard let url = URL(string: message) else {
            return
        }
        
        let urlMessage = Message(messageString: message, previewLoading: true, linkURL: url)
        messages.append(urlMessage)
        
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url) { [self] meta , err in
            DispatchQueue.main.async {
                message = ""
                if let _ = err {
                    addToMessage()
                    return
                }
                
                guard let meta = meta else {
                    addToMessage()
                    return
                }
                
                if let index = messages.firstIndex(where: { $0.id == urlMessage.id }) {
                    messages[index].linkMetaData = meta
                }
            }
        }
    }
    
    func isMessageURL() -> Bool {
        if let url = URL(string: message) {
            return UIApplication.shared.canOpenURL(url)
        }
        
        return false
    }
    
    func addToMessage() {
        messages.append(Message(messageString: message))
        message = ""
    }
}
