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
    private var balanceLabel: UILabel!
    private var scanButton: UIButton!
    private var historyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.title = "Pembayaran"
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let localStorage = UserDefaults.standard
        
        if localStorage.object(forKey: "balance") != nil {
            let lastBalance = UserDefaults.standard.integer(forKey: "balance")
            balanceLabel.text = "Sisa Saldo Anda: \(lastBalance.toIDR() ?? "Rp. 0")"
        } else {
            let firstBalance = 500_000
            localStorage.set(firstBalance, forKey: "balance")
            balanceLabel.text = "Sisa Saldo Anda:  \(firstBalance.toIDR() ?? "Rp. 0")"
        }
        
    }
    
    override func loadView() {
        super.loadView()
        attacthComponent()
        
        stackView.addArrangedSubview(scanButton)
        stackView.addArrangedSubview(historyButton)
        stackView.addArrangedSubview(balanceLabel)
        
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 18),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
    }
    
    private func attacthComponent() {
        initStackView()
        scanButton = primaryButton(title: "Scan QR Pembayaran", action: #selector(scanAction(_:)))
        historyButton = primaryButton(title: "Riwayat Pembayaran", action: #selector(historyAction(_:)))
        initBalanceLabel()
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
    
    private func initStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func primaryButton(title: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.theme.primaryButtonTextColor, for: .normal)
        button.backgroundColor = .theme.primaryButtonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }
    
    private func initBalanceLabel() {
        balanceLabel = UILabel()
        balanceLabel.textAlignment = .right
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

#Preview {
    var controller = QRISHomeViewController()
    
    return controller
}

