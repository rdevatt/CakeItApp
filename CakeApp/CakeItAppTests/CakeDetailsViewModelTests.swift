
import XCTest
@testable import CakeItApp

class CakeDetailsViewModelTests: XCTestCase {

    var viewModel:CakeDetailsViewModel!
    
    override func setUp() {
        viewModel = CakeDetailsViewModel(cakeDetails:("Lemon Cheesecake", "A cheesecake made of lemon", ""))
    }

    
    func testPetsDetails() {
        XCTAssertEqual(viewModel.title ,"Lemon Cheesecake", "Cake Name not matching")
        XCTAssertEqual(viewModel.desc ,"A cheesecake made of lemon", "cake height not matching")
    }

}
