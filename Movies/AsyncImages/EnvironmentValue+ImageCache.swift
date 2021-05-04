//
//  EnvironmentValue+ImageCache.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TempImageCache()
}

extension EnvironmentValues{
    var imageCache : ImageCache{
        get { self[ImageCacheKey.self]}
        set { self[ImageCacheKey.self] = newValue }
    }
    
}
