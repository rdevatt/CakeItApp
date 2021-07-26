//  Created by Roy DeVatt on 06/25/21.


import UIKit
import Combine

class CakeDetailViewController: UIViewController, Storyboarded {
    
    @IBOutlet private weak var cakeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    

    var viewModel:CakeDetailsViewModel!
    
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.desc
        
        cancellable = loadImage(for: viewModel.imageStr).sink { [unowned self] image in
            self.cakeImageView.image = image
            
        }
    }
    deinit {
        cancellable?.cancel()
    }
    
    private func loadImage(for urlStr: String) -> AnyPublisher<UIImage?, Never> {
        return Just(urlStr)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: urlStr)!
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
}
