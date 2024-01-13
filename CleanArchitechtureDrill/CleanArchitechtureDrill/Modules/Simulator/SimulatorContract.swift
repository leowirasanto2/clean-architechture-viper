import UIKit

protocol ISimulatorModule: AnyObject {
    func getSimulatorPage(parameters: [String: Any]?) -> UIViewController
    func getPreview() -> SimulatorViewController
}

protocol ISimulatorViewController: AnyObject {
    func showForm()
    func showResult()
}

protocol ISimulatorPresenter: AnyObject {
    var viewModel: SimulatorViewModel? { get set }
    var pageTitle: String? { get }
    func viewDidLoad(view: ISimulatorViewController)
    func calculate(investValue: Double, sellValue: Double)
    func getForm()
}

protocol ISimulatorInteractor: AnyObject {
    // Presenter to Interactor
}

protocol ISimulatorRouter: AnyObject {
    // Presenter to Router
}
