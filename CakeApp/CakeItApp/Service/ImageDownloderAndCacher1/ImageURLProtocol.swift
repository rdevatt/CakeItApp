//
//  ImageURLProtocol
//  EngineeringChallenge
//
//  Created by Artur on 02/06/21.
//
import UIKit

class ImageURLProtocol: URLProtocol {

    var cancelledOrComplete: Bool = false
    var block: DispatchWorkItem!
    
    private static let queue = OS_dispatch_queue_serial(label: "com.dev.EngineeringChallenge.imageLoaderURLProtocol")
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    class override func requestIsCacheEquivalent(_ aRequest: URLRequest, to bRequest: URLRequest) -> Bool {
        return false
    }
    
    static func urlSession() -> URLSession {
        let config = URLSessionConfiguration.default
     //   config.protocolClasses = [ImageURLProtocol.classForCoder()]
        return  URLSession(configuration: config)
    }
    
}
