import UIKit

protocol IPortfolioModule: AnyObject {
    func getPortfolioPage(parameters: [String: Any]?) -> UIViewController
    // Module generator
}

protocol IPortfolioViewController: AnyObject {
    // Presenter to View
}

protocol IPortfolioPresenter: AnyObject {
    func viewDidLoad(view: IPortfolioViewController)

    // View to Presenter
    // & Interactor to Presenter
}

protocol IPortfolioInteractor: AnyObject {
    // Presenter to Interactor
}

protocol IPortfolioRouter: AnyObject {
    // Presenter to Router
}
