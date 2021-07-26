//  Created by Roy DeVatt on 06/25/21.


import Foundation


protocol CakeListViewModelProtocol {
    var itemCount: Int {get}
    func fetchCakes()
    func getCakes(for row:Int)-> (title:String, desc:String, imageStr:String )

}

class CakeListViewModel: CakeListViewModelProtocol {
    
    weak private var delegate:CakeListViewProtocol!
    let service:Servicable!
    
    private var cakes:[Cake]?
    
    var itemCount: Int {
        return cakes?.count ?? 0
    }
    
    init(delegate:CakeListViewProtocol,
         service:Servicable = Service()) {
         self.delegate = delegate
         self.service = service
    }
    
    /*
     this method connect calls rest API to get data
     */
    func fetchCakes() {
            let networkClient = NetworkClient(baseUrl:EndPoints.baseUrl.rawValue, path:Path.cakeList.rawValue, params:"", method:"get")
        
            service.fetchData(networkClient:networkClient, type:Cake.self) { [weak self] (result)  in
                switch result {
                case .success(let result):
                    self?.cakes = result
                    DispatchQueue.main.async {
                        self?.delegate?.updateUI()
                    }
                case .failure(_):
                    self?.cakes = nil
                    DispatchQueue.main.async {
                        self?.delegate?.showError()
                    }
                }
            }
    }
    
    
    func getCakes(for row: Int) -> (title: String, desc: String, imageStr: String) {
        guard let _cakes = cakes,  _cakes.count >= row , row >= 0 else {
            return ("", "", "")
        }
        let cake = _cakes[row]
        return (cake.title, cake.desc, cake.image)
    }
}
