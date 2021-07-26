//  Created by Roy DeVatt on 06/25/21.
import Foundation

enum NetworkError: Error {
    case parsinFailed(message:String)
    case errorWith(message:String)
    case networkNotAvailalbe
    case malformedURL(message:String)
}
