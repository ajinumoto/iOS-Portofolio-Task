//
//  HomePortofolioRouterViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import UIKit
import DGCharts
class HomePortofolioViewController: UIViewController {
    var presenter: HomePortofolioViewToPresenterProtocol?
    
    private var pieView: PieView!
    private var barView: BarView!
    private let backgroundColor: UIColor = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.black
        self.title = "Portofolio"
        presenter?.getPortofolio()
    }
    
    override func loadView() {
        super.loadView()
        pieView = PieView(frame: .zero, navigationController: navigationController)
        barView = BarView()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

private extension HomePortofolioViewController {
    func setupUI() {
        view.backgroundColor = backgroundColor
        
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.backgroundColor = .white
            
            return stackView
        }()
        
        stackView.addArrangedSubview(pieView)
        stackView.addArrangedSubview(barView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomePortofolioViewController: HomePortofolioPresenterToViewProtocol {
    
    func succesDelegate(portofolio: [PortofolioModel]) {
        guard let pieData = portofolio[safe: 0]?.data, let lineData = portofolio[safe: 1]?.data else {
            return
        }
        
        switch pieData {
        case .pie(let data):
            pieView.pieChartData = data
        default:
            return
        }
        
        switch lineData {
        case .line(let data):
            barView.barChartData = data
        default:
            return
        }
        
    }
}

#Preview {
    var controller = HomePortofolioRouter.createModule()
    
    return controller
}
