import UIKit

protocol ITabBarModule: AnyObject {
    func getTabBarPage(parameters: [String: Any]?) -> UIViewController
    // Module generator
}

protocol ITabBarViewController: AnyObject {
    // Presenter to View
}

protocol ITabBarPresenter: AnyObject {
    var viewModel: TabbarViewModel? { get set }
    
    func viewDidLoad(view: ITabBarViewController)
    func getParameters() -> [String: Any]?
    // View to Presenter
    // & Interactor to Presenter
}

protocol ITabBarInteractor: AnyObject {
    // Presenter to Interactor
}

protocol ITabBarRouter: AnyObject {
    // Presenter to Router
}
