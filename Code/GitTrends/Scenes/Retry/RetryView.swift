//
//  RetryView.swift

import UIKit
import Lottie

protocol RetryDelegate: AnyObject {
    func onRetryAction()
}

class RetryView: UIView {
    weak var delegate: RetryDelegate?
    @IBOutlet weak var animationView: AnimationView!
    
    override func awakeFromNib() {
        setupAnimationView()
    }
    
    private func setupAnimationView() {
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }
    
    // MARK: - IBAction
    
    @IBAction func onRetry(_ sender: Any) {
        if (delegate != nil) {
            delegate?.onRetryAction()
        }
    }
}
