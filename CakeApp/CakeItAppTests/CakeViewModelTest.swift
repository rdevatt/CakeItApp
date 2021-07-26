
import XCTest
@testable import CakeItApp

class CakeViewModelTest: XCTestCase {

    var mockService:MockService!
    var viewModel:CakeListViewModel!
   
    override func setUp() {
        mockService = MockService()
        let vc = CakeListViewController()
        viewModel = CakeListViewModel(delegate:vc, service:mockService)
    }

    func testSearchSuccess() {
        mockService.responseFileName = "ItemsSuccessResponse"
        viewModel.fetchCakes()
        let resultCount = viewModel.itemCount
        XCTAssertEqual(resultCount ,10, "Pets Search count not matching")
    }
    
    func testSearchFailure() {
        mockService.responseFileName = "ItemFailureResonse"
        viewModel.fetchCakes()
        let resultCount = viewModel.itemCount
        XCTAssertEqual(resultCount ,0, "Pets Search count not matching")
    }
    
    func testGetCakeDetails() {
        mockService.responseFileName = "ItemsSuccessResponse"
        viewModel.fetchCakes()
        var  cakeDetails = viewModel.getCakes(for: 1)
        
        XCTAssertEqual(cakeDetails.imageStr ,"https://s3-eu-west-1.amazonaws.com/s3.mediafileserver.co.uk/carnation/WebFiles/RecipeImages/lemoncheesecake_lg.jpg")
        XCTAssertEqual(cakeDetails.title ,"Lemon Cheesecake" , "Cake Name not matching")
        
        XCTAssertEqual(cakeDetails.desc ,"A cheesecake made of lemon", "Pet Name not matching")

        cakeDetails = viewModel.getCakes(for: -1)
        
        XCTAssertEqual(cakeDetails.imageStr ,"", "Pet Image URL not matching")
        XCTAssertEqual(cakeDetails.title ,"", "Pet Name not matching")
        
        XCTAssertEqual(cakeDetails.desc ,"", "Pet Name not matching")
    }
}
