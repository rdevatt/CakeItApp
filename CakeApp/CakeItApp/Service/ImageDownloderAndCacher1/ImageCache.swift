//
//  ImageCache
//  EngineeringChallenge
//
//  Created by Artur on 02/06/21.
//
import UIKit
import Foundation
public class ImageCache {
    
    public static let publicCache = ImageCache()
    var placeholderImage = UIImage(systemName: "rectangle")!
    private let cachedImages = NSCache<NSString, UIImage>()
    private var loadingResponses = [URL: [(UIImage?) -> Swift.Void]]()
    
    public final func image(url: URL) -> UIImage? {
        return cachedImages.object(forKey: url.absoluteString as NSString)
    }
    /// - Tag: cache
    // Returns the cached image if available, otherwise asynchronously loads and caches it.
    final func load(url: URL, completion: @escaping ( UIImage?) -> Swift.Void) {
        // Check for a cached image.
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        // In case there are more than one requestor for the image, we append their completion block.
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        // Go fetch the image.

        ImageURLProtocol.urlSession().dataTask(with: url) { (data, response, error) in
            // Check for the error, then data and try to create the image.
            guard let responseData = data, let image = UIImage(data: responseData),
                let blocks = self.loadingResponses[url], error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            // Cache the image.
            self.cachedImages.setObject(image, forKey: url.absoluteString as NSString, cost: responseData.count)
            // Iterate over each requestor for the image and pass it back.
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
                return
            }
        }.resume()
    }
        
}
