//  Created by Roy DeVatt on 06/25/21.


import UIKit
import Combine

class CakeTableViewCell: UITableViewCell {
    @IBOutlet weak var cakeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        cakeImageView.image = nil
        cakeImageView.alpha = 0.0
        animator?.stopAnimation(true)
        cancellable?.cancel()
    }
    
    public func configure(with cake:(title:String, desc:String, imageStr:String )) {
        titleLabel.text = cake.title
        descLabel.text = cake.desc
        cancellable = loadImage(for: cake.imageStr).sink { [unowned self] image in self.showImage(image: image) }
    }
    
    private func showImage(image: UIImage?) {
        cakeImageView.alpha = 0.0
        animator?.stopAnimation(false)
        cakeImageView.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.cakeImageView.alpha = 1.0
        })
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
