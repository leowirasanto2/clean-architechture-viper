import UIKit

protocol IMarketListModule: AnyObject {
    func getMarketListPage(parameters: [String: Any]?) -> UIViewController
    // Module generator
}

protocol IMarketListViewController: AnyObject {
    func showMarketData()
    func startLoader(_ completion: () -> Void?)
    func stopLoader(_ completion: () -> Void?)
}

protocol IMarketListPresenter: AnyObject {
    var viewModel: MarketListViewModel? { get set }
    var pageTitle: String? { get }
    
    func viewDidLoad(view: IMarketListViewController)
    func getMarketData()
    func successFetchMarketData(_ data: MarketListViewModel?)
    func failedFetchMargetData(_ error: CustomError)
    func selectedData() -> [MarketListDataViewModel]?
    func seeMarketDetail(_ selectedMarket: MarketListDataViewModel?)
    // & Interactor to Presenter
}

protocol IMarketListInteractor: AnyObject {
    func fetchMarketData()
}

protocol IMarketListRouter: AnyObject {
    func navigateToMarketDetailPage(_ parameters: [String: Any]?)
}
