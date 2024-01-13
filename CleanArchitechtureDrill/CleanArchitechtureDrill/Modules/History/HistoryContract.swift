import UIKit

protocol IHistoryModule: AnyObject {
    func getHistoryPage(parameters: [String: Any]?) -> UIViewController
    // Module generator
}

protocol IHistoryViewController: AnyObject {
    // Presenter to View
}

protocol IHistoryPresenter: AnyObject {
    func viewDidLoad(view: IHistoryViewController)

    // View to Presenter
    // & Interactor to Presenter
}

protocol IHistoryInteractor: AnyObject {
    // Presenter to Interactor
}

protocol IHistoryRouter: AnyObject {
    // Presenter to Router
}
