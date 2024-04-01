//
//  PaymentStatusViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import UIKit

class PaymentStatusViewController: UIViewController, PaymentStatusPresenterToViewProtocol {
    var presenter: PaymentStatusViewToPresenterProtocol?
    
    private let localStorage = UserDefaults.standard
    
    private var stackView: UIStackView!
    
    private var successImage: UIImageView!
    private var successLabel: UILabel!
    
    private var dateLabel: UILabel!
    private var transactionIDLabel: UILabel!
    private var merchantNameLabel: UILabel!
    private var bankNameLabel: UILabel!
    private var amountLabel: UILabel!
    
    private var confirmationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Status Pembayaran"
        
        view.backgroundColor = .white
        
        successLabel.text = "Pembayaran Berhasil"
        
        let paymentDate = presenter?.payment?.date ?? Date()
        dateLabel.text = "Waktu Transaksi: \(paymentDate.withFormat("dd MMMM yyyy HH:mm", locale: "id_ID"))"
        
        transactionIDLabel.text = "ID Transaksi: \(presenter?.payment?.transactionID ?? "")"
        merchantNameLabel.text = "Merchant: \(presenter?.payment?.merchantName ?? "")"
        bankNameLabel.text = "Bank: \(presenter?.payment?.bankName ?? "")"
        amountLabel.text = presenter?.payment?.amountValue.toIDR() ?? "Rp. 0"
    }
    
    override func loadView() {
        super.loadView()
        attacthComponent()
        
        stackView.addArrangedSubview(successImage)
        stackView.addArrangedSubview(successLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(transactionIDLabel)
        
        stackView.setCustomSpacing(42.0, after: transactionIDLabel)
        
        stackView.addArrangedSubview(merchantNameLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(bankNameLabel)
        
        self.view.addSubview(stackView)
        self.view.addSubview(confirmationButton)
        
        NSLayoutConstraint.activate([
            successImage.heightAnchor.constraint(equalToConstant: 62)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 18),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
        
        NSLayoutConstraint.activate([
            confirmationButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            confirmationButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            confirmationButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationItem.setHidesBackButton(false, animated: false)
    }
    
    private func attacthComponent() {
        stackView = initStackView()
        
        successImage = UIImageView()
        
        successImage.image = UIImage(systemName: "checkmark.seal.fill")
        successImage.contentMode = .scaleAspectFit
        successImage.tintColor = .theme.primaryColor
        
        successLabel = UILabel()
        successLabel.font = .boldSystemFont(ofSize: 16)
        successLabel.textAlignment = .center
        successLabel.textColor = .theme.primaryColor
        successLabel.textColor = .black
        
        dateLabel = initListLabel()
        merchantNameLabel = initListLabel()
        bankNameLabel = initListLabel()
        
        amountLabel = UILabel()
        amountLabel.font = .boldSystemFont(ofSize: 28)
        amountLabel.textAlignment = .center
        amountLabel.textColor = .black
        
        transactionIDLabel = UILabel()
        transactionIDLabel.font = .monospacedSystemFont(ofSize: 12, weight: .light)
        transactionIDLabel.textAlignment = .center
        transactionIDLabel.textColor = .black
        
        confirmationButton = primaryButton(title: "Selesai", action: #selector(finishedAction(_:)))
    }
    
    
    @objc func finishedAction(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
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
}

#Preview {
    var controller = PaymentStatusRouter.createModule(PaymentEntity(bankName: "BNI", transactionID: "ID12345678", merchantName: "Toko Sumber Bahagia", amountValue: 25000, date: Date()))
    
    return controller
}
