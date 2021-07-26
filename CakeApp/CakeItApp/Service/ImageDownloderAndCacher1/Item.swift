//
//  Item
//  EngineeringChallenge
//
//  Created by Artur on 02/06/21.
//
import UIKit

class Item: Hashable {
    
    var image: UIImage!
    let url: URL!
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init(image: UIImage, url: URL) {
        self.image = image
        self.url = url
    }

}
