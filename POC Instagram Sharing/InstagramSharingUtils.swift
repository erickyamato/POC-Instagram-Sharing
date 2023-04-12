//
//  InstagramSharingUtils.swift
//  POC Instagram Sharing
//
//  Created by Erick Yamat on 12/04/23.
//

import Foundation
import SwiftUI

struct InstagramSharingUtils {
    
    private static var instagramStoriesUrl: URL? {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier,
              let url = URL(string: "instagram-stories://share?source_application=\(bundleIdentifier)"),
              UIApplication.shared.canOpenURL(url) else { return nil }
        return url
    }
    
    static var canOpenInstagramStories: Bool {
        return instagramStoriesUrl != nil
    }
    
    static func shareToInstagramStories(_ image: UIImage) {
        
        guard let instagramStoriesUrl = instagramStoriesUrl else { return }
        
        let imageData = UIImage.pngData(image)
        guard let imageData = imageData() else { return }
        let pasteboardItem = ["com.instagram.sharedSticker.backgroundImage": imageData]
        let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)]
        
        UIPasteboard.general.setItems([pasteboardItem], options: pasteboardOptions)
        UIApplication.shared.open(instagramStoriesUrl, options: [:], completionHandler: nil)
        
    }
}
