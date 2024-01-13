import UIKit

protocol ILandingModule: AnyObject {
    func getLandingPage(parameters: [String: Any]?) -> UIViewController
}

protocol ILandingViewController: AnyObject {
    // Presenter to View
    func startLoader(_ completion: () -> Void?)
    func stopLoader(_ completion: () -> Void?)
    func showLandingPageData()
    func showErrorDialog(_ error: CustomError)
}

protocol ILandingPresenter: AnyObject {
    var viewModel: MarketListViewModel? { get set }
    func viewDidLoad(view: ILandingViewController)
    func getLandingPageData()
    func successFetchMarketData(_ data: MarketListViewModel?)
    func failedFetchMargetData(_ error: CustomError)
    func seeAllTopMarket()
    func seeAllWatchingMarket()
    func seeAllMarket()
    func seeMarketDetail(_ selectedMarket: MarketListDataViewModel?)
    // View to Presenter
    // & Interactor to Presenter
}

protocol ILandingInteractor: AnyObject {
    func fetchMarketData()
}

protocol ILandingRouter: AnyObject {
    func navigateToMarketListPage(_ parameters: [String: Any]?)
    func navigateToMarketDetailPage(_ parameters: [String: Any]?)
}
