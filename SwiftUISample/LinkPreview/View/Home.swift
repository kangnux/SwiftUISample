//
//  Home.swift
//  SwiftUISample
//
//  Created by kangnux on 2021/12/06.
//

import SwiftUI
import LinkPresentation

struct Home: View {
    @StateObject var messageData: MessageViewModel = MessageViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ScrollViewReader { value in
                    VStack (spacing: 15) {
                        ForEach(messageData.messages, id: \.id) { message in
                            CardView(message: message)
                        }
                    }
                    .onChange(of: messageData.messages.count) { _ in
                        value.scrollTo(messageData.messages.last?.id,
                                       anchor: .bottom)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 12) {
                    TextField("Enter Message",text: $messageData.message)
                        .textFieldStyle(.roundedBorder)
                        .textCase(.lowercase)
                        .textInputAutocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    Button {
                        messageData.sendMessage()
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.title3)
                    }
                }
                .padding()
                .padding(.top)
                .background(.ultraThinMaterial)
            }
            .navigationTitle("Link Preview")
        }
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    func CardView(message: Message) -> some View {
        Group {
            if message.previewLoading {
                Group {
                    if let metaData = message.linkMetaData {
                        LinkPreview(metaData: metaData)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: getRect().width - 80, alignment: .leading)
                            .cornerRadius(15)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    } else {
                        HStack(spacing: 10) {
                            Text(message.linkURL?.host ?? "")
                                .font(.caption)
                            
                            ProgressView()
                                .tint(.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.gray.opacity(0.35))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            } else {
                Text(message.messageString)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .frame(width: getRect().width - 80, alignment: .trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
