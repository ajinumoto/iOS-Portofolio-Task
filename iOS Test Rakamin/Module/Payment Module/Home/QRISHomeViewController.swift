//
//  QRISViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import UIKit

class QRISHomeViewController: UIViewController, QRISHomePresenterToViewProtocol {
    var presenter: QRISHomeViewToPresenterProtocol?
    
    private var stackView: UIStackView!
    var balanceLabel: UILabel!
    private var scanButton: UIButton!
    private var historyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBalance()
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        title = "Pembayaran"
    }
    
    private func setupUI() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scanButton = createButton(title: Constants.scanButtonTitle, action: #selector(scanAction(_:)))
        historyButton = createButton(title: Constants.historyButtonTitle, action: #selector(historyAction(_:)))
        balanceLabel = UILabel()
        balanceLabel.textAlignment = .right
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(scanButton)
        stackView.addArrangedSubview(historyButton)
        stackView.addArrangedSubview(balanceLabel)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
    }
    
    private func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.theme.primaryButtonTextColor, for: .normal)
        button.backgroundColor = .theme.primaryButtonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    func updateBalance() {
        let localStorage = UserDefaults.standard
        let balance = localStorage.integer(forKey: Constants.initialBalanceKey)
        if balance == 0 {
            localStorage.set(Constants.defaultInitialBalance, forKey: Constants.initialBalanceKey)
        }
        balanceLabel.text = Constants.balanceLabelPrefix + "\(balance.toIDR() ?? "Rp. 0")"
    }
    
    @objc func scanAction(_ sender: UIButton) {
        let qrScanner = QRScannerRouter.createModule()
        qrScanner.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(qrScanner, animated: true)
    }
    
    @objc func historyAction(_ sender: UIButton) {
        let controller = HistoryRouter.createModule()
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
}

#Preview {
    var controller = QRISHomeViewController()
    
    return controller
}

