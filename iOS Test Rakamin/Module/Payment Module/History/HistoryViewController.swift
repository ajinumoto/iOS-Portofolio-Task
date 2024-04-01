//
//  HistoryViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import UIKit

class HistoryViewController: UIViewController, HistoryPresenterToViewProtocol {
    var presenter: HistoryViewToPresenterProtocol?
        
    private var payment = [PaymentEntity]() {
        didSet {
            updateUI()
        }
    }
    
    private let localStorage = UserDefaults.standard
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Belum ada riwayat transaksi"
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellIdentifier = "historyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPaymentEntities()
    }
        
    private func setupUI() {
        self.title = "Riwayat Pembayaran"
        view.backgroundColor = .white
        view.addSubview(emptyLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func updateUI() {
        let isEmpty = payment.isEmpty
        emptyLabel.isHidden = !isEmpty
        tableView.isHidden = isEmpty
        tableView.reloadData()
    }
    
    private func loadPaymentEntities() {
        guard let paymentEntitiesData = UserDefaults.standard.array(forKey: "paymentEntities") as? [Data] else {
            return
        }
        
        let decoder = JSONDecoder()
        payment = paymentEntitiesData.compactMap { data in
            do {
                let paymentEntity = try decoder.decode(PaymentEntity.self, from: data)
                return paymentEntity
            } catch {
                print("Error decoding payment entity: \(error)")
                return nil
            }
        }
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HistoryTableViewCell
        let paymentData = payment[indexPath.row]
        cell.valueLabel.text = "-\(paymentData.amountValue.toIDR() ?? "Rp. 0")"
        cell.titleLabel.text = paymentData.merchantName
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

#Preview {
    var controller = HistoryRouter.createModule()
    return controller
}
