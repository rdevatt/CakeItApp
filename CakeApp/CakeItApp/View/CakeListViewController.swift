//  Created by Roy DeVatt on 06/25/21.


import UIKit

protocol CakeListViewProtocol:AnyObject {
    func updateUI()
    func showError()
}
class CakeListViewController: UIViewController ,Storyboarded, CakeListViewProtocol {
    
    @IBOutlet var tableView: UITableView!
    
    var viewModel:CakeListViewModelProtocol!  // ViewModel
    weak var coordinator: Coordinator?        // Coordinator

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = "🎂CakeItApp🍰"
        
        viewModel.fetchCakes()
    }
    
    func updateUI() {
        tableView.reloadData()
       // hideActivityIndicator()
    }
    
    func showError() {
        tableView.reloadData()
        //hideActivityIndicator()
    }
}

extension CakeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let cake = viewModel.getCakes(for: indexPath.row)

        coordinator?.goToCakeDetails(cakeDetails: cake)
    }
    
}

extension CakeListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as?  CakeTableViewCell else {
            return UITableViewCell()
        }
        
        let cake = viewModel.getCakes(for: indexPath.row)

        
        cell.configure(with: cake)
        return cell
    }

}

