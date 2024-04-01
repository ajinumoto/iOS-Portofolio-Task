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
    var balanceLabel: UILabel!
    var transactionIDLabel: UILabel!
    var merchantNameLabel: UILabel!
    var amountTitleLabel: UILabel!
    var amountLabel: UILabel!
    private var confirmationButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayPaymentDetails()
    }

    private func setupUI() {
        self.title = "Detail Pembayaran"
        view.backgroundColor = .white
    }

    func displayPaymentDetails() {
        guard let qris = presenter?.qris else {
            showAlert(message: "Tidak dapat menemukan data QRIS")
            return
        }

        balanceLabel.text = "Saldo Anda: \(localStorage.integer(forKey: "balance").toIDR() ?? "Rp. 0")"
        transactionIDLabel.text = "ID Transaksi: \(qris.transactionID)"
        merchantNameLabel.text = "Merchant: \(qris.merchantName)"
        amountTitleLabel.text = "Nominal Transaksi:"
        amountLabel.text = "\(qris.amountValue.toIDR() ?? "Rp. 0")"
    }

    override func loadView() {
        super.loadView()
        attachComponents()
        addSubviews()
        activateConstraints()
    }

    private func attachComponents() {
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
        }
    }

    private func saveData(_ paymentEntity: PaymentEntity) throws {
        var paymentEntities = UserDefaults.standard.array(forKey: "paymentEntities") as? [Data] ?? []
        var lastBalance = localStorage.integer(forKey: "balance")

        guard lastBalance >= paymentEntity.amountValue else {
            showAlert(message: "Saldo Anda tidak mencukupi. Silakan isi saldo Anda terlebih dahulu")
            return
        }

        let encoder = JSONEncoder()
        let paymentEntityData = try encoder.encode(paymentEntity)
        paymentEntities.append(paymentEntityData)
        UserDefaults.standard.set(paymentEntities, forKey: "paymentEntities")

        lastBalance -= paymentEntity.amountValue
        localStorage.set(lastBalance, forKey: "balance")

        let detailView = PaymentStatusRouter.createModule(paymentEntity)
        detailView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailView, animated: true)
    }

    func showAlert(message: String) {
        let controller = UIAlertController(title: "Terjadi Kesalahan", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        controller.addAction(action)
        present(controller, animated: true)
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

    private func addSubviews() {
        view.addSubview(stackView)
        view.addSubview(balanceLabel)
        view.addSubview(confirmationButton)
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),

            balanceLabel.bottomAnchor.constraint(equalTo: confirmationButton.topAnchor, constant: -18),
            balanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            balanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),

            confirmationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            confirmationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            confirmationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
    }
}

#Preview {
    var controller = PaymentRouter.createModule(QRISModel(bankName: "BNI", transactionID: "ID12345678", merchantName: "Toko Sumber Bahagia", amountValue: 25000))
    return controller
}
