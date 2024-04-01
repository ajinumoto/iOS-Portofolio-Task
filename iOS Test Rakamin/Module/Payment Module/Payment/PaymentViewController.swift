//
//  PaymentViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import UIKit

class PaymentViewController: UIViewController, PaymentPresenterToViewProtocol {
    var presenter: PaymentViewToPresenterProtocol?
    
    private let localStorage = UserDefaults.standard
    
    private var stackView: UIStackView!
    
    private var balanceLabel: UILabel!
    private var transactionIDLabel: UILabel!
    private var merchantNameLabel: UILabel!
    
    private var amountTitleLabel: UILabel!
    private var amountLabel: UILabel!
    
    private var confirmationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Pembayaran"
        view.backgroundColor = .white
        
        let lastBalance = localStorage.integer(forKey: "balance")
        
        balanceLabel.text = "Saldo Anda: \(lastBalance.toIDR() ?? "Rp. 0")"
        transactionIDLabel.text = "ID Transaksi: \(presenter?.qris?.transactionID ?? "")"
        merchantNameLabel.text = "Merchant: \(presenter?.qris?.merchantName ?? "")"
        amountTitleLabel.text = "Nominal Transaksi:"
        amountLabel.text = "\(presenter?.qris?.amountValue.toIDR() ?? "Rp. 0")"
    }
    
    override func loadView() {
        super.loadView()
        attacthComponent()
        
        stackView.addArrangedSubview(merchantNameLabel)
        stackView.addArrangedSubview(transactionIDLabel)
        stackView.addArrangedSubview(amountTitleLabel)
        stackView.addArrangedSubview(amountLabel)
        
        let bottomStackView = initStackView()
        bottomStackView.addArrangedSubview(balanceLabel)
        bottomStackView.addArrangedSubview(confirmationButton)
        
        self.view.addSubview(stackView)
        self.view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 18),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            bottomStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
    }
    
    private func attacthComponent() {
        stackView = initStackView()
        
        balanceLabel = initListLabel(alignment: .right)
        transactionIDLabel = initListLabel()
        merchantNameLabel = initListLabel()
        amountTitleLabel = initListLabel()
        amountLabel = UILabel()
        amountLabel.font = .boldSystemFont(ofSize: 28)
        amountLabel.textAlignment = .right
        amountLabel.textColor = .black
        
        confirmationButton = primaryButton(title: "Bayar", action: #selector(payAction(_:)))
    }
    
    
    @objc func payAction(_ sender: UIButton) {
        
        guard let qris = presenter?.qris else {
            showAlert(message: "Tidak dapat menemukan data QRIS")
            return
        }
        
        let paymentEntity = PaymentEntity(bankName: qris.bankName, transactionID: qris.transactionID, merchantName: qris.merchantName, amountValue: qris.amountValue, date: Date())
        
        do {
            try saveData(paymentEntity)
        } catch {
            showAlert(message: "Terjadi kesalahan penyimpanan data")
            return
        }
        
        let detailView = PaymentStatusRouter.createModule(paymentEntity)
        detailView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    private func saveData(_ paymentEntity: PaymentEntity) throws {
        
        var paymentEntities = UserDefaults.standard.array(forKey: "paymentEntities") as? [Data] ?? []
        var lastBalance = localStorage.integer(forKey: "balance")
        
        if lastBalance < paymentEntity.amountValue {
            showAlert(message: "Saldo anda tidak cukup. Silahkan isi saldo anda terlebih dahulu")
            return
        }
        
        let encoder = JSONEncoder()
        let paymentEntityData = try encoder.encode(paymentEntity)
        
        paymentEntities.append(paymentEntityData)
        
        UserDefaults.standard.set(paymentEntities, forKey: "paymentEntities")
        
        lastBalance -= paymentEntity.amountValue
        localStorage.set(lastBalance, forKey: "balance")
    }
    
    private func initStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
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
    
    private func initListLabel(alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
    }
    
    func showAlert(message: String){
        let controller = UIAlertController(
            title: "Terjadi Kesalahan",
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
        )
        
        controller.addAction(action)
        
        present(controller, animated: true, completion: nil)
    }
}

#Preview {
    var controller = PaymentRouter.createModule(QRISModel(bankName: "BNI", transactionID: "ID12345678", merchantName: "Toko Sumber Bahagia", amountValue: 25000))
    
    return controller
}

