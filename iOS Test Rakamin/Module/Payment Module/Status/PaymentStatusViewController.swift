//
//  PaymentStatusViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import UIKit

class PaymentStatusViewController: UIViewController, PaymentStatusPresenterToViewProtocol {
    var presenter: PaymentStatusViewToPresenterProtocol?
    
    private var stackView: UIStackView!
    private var successImageView: UIImageView!
    var successLabel: UILabel!
    var dateLabel: UILabel!
    var transactionIDLabel: UILabel!
    var merchantNameLabel: UILabel!
    var bankNameLabel: UILabel!
    var amountLabel: UILabel!
    private var confirmationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupView()
        displayPaymentStatus()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationItem.setHidesBackButton(false, animated: false)
    }
    
    private func configureNavigationBar() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.setHidesBackButton(true, animated: false)
        title = "Status Pembayaran"
    }
    
    private func setupView() {
        view.backgroundColor = .white
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        successImageView = UIImageView()
        successImageView.image = UIImage(systemName: "checkmark.seal.fill")
        successImageView.contentMode = .scaleAspectFit
        successImageView.tintColor = .theme.primaryColor
        successLabel = UILabel()
        successLabel.font = .boldSystemFont(ofSize: 16)
        successLabel.textAlignment = .center
        successLabel.textColor = .theme.primaryColor
        successLabel.textColor = .black
        dateLabel = createLabel()
        merchantNameLabel = createLabel()
        bankNameLabel = createLabel()
        amountLabel = createLabel()
        amountLabel.font = .boldSystemFont(ofSize: 28)
        transactionIDLabel = createLabel()
        transactionIDLabel.font = .monospacedSystemFont(ofSize: 12, weight: .light)
        confirmationButton = createButton(title: "Selesai", action: #selector(finishedAction(_:)))
        
        view.addSubview(stackView)
        view.addSubview(confirmationButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
        
        NSLayoutConstraint.activate([
            confirmationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            confirmationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            confirmationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
        
        successImageView.heightAnchor.constraint(equalToConstant: 62).isActive = true
        stackView.addArrangedSubview(successImageView)
        stackView.addArrangedSubview(successLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(transactionIDLabel)
        stackView.setCustomSpacing(42.0, after: transactionIDLabel)
        stackView.addArrangedSubview(merchantNameLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(bankNameLabel)
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }
    
    func displayPaymentStatus() {
        guard let payment = presenter?.payment else { return }
        successLabel.text = "Pembayaran Berhasil"
        dateLabel.text = "Waktu Transaksi: \(payment.date.withFormat("dd MMMM yyyy HH:mm", locale: "id_ID"))"
        transactionIDLabel.text = "ID Transaksi: \(payment.transactionID)"
        merchantNameLabel.text = "Merchant: \(payment.merchantName)"
        bankNameLabel.text = "Bank: \(payment.bankName)"
        amountLabel.text = payment.amountValue.toIDR() ?? "Rp. 0"
    }
    
    @objc private func finishedAction(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
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
}

#Preview {
    var controller = PaymentStatusRouter.createModule(PaymentEntity(bankName: "BNI", transactionID: "ID12345678", merchantName: "Toko Sumber Bahagia", amountValue: 25000, date: Date()))
    return controller
}
