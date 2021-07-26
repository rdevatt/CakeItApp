//  Created by Roy DeVatt on 06/25/21.

import Foundation


class CakeDetailsViewModel {
    
    var title:String = ""
    var desc:String = ""
    var imageStr:String = ""
    
    init(cakeDetails:(title:String, desc:String, imageStr:String )) {
        self.title = cakeDetails.title
        self.desc = cakeDetails.desc
        self.imageStr = cakeDetails.imageStr
    }
}
