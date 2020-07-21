import UIKit

final class BindableGestureRecognizer: UITapGestureRecognizer {
    private var action: (UITapGestureRecognizer?) -> Void

    init(action: @escaping (UITapGestureRecognizer?) -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(execute))
    }

    @objc private func execute() {
        action(self)
    }
}

extension UIView {
    func onTapped(_ closure: @escaping (UITapGestureRecognizer?) -> Void) {
        let tapHandler = BindableGestureRecognizer{
            closure($0)
        }
        self.addGestureRecognizer(tapHandler)
    }
}
