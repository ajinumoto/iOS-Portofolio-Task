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
            let isEmpty = payment.isEmpty
            emptyLable.isHidden = !isEmpty
            tableView.isHidden = isEmpty
        }
    }
    
    private let localStorage = UserDefaults.standard
    private var tableView: UITableView!
    private var emptyLable: UILabel!
    
    private let cell = "historyCell"
    
    private var confirmationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Riwayat Pembayaran"
        payment = getPaymentEntities()
        view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: cell)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        emptyLable = UILabel()
        emptyLable.text = "Belum ada riwayat transaksi"
        emptyLable.textAlignment = .center
        emptyLable.textColor = .black
        emptyLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyLable)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            emptyLable.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            emptyLable.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
    }
    
    private func getPaymentEntities() -> [PaymentEntity] {
        guard let paymentEntitiesData = UserDefaults.standard.array(forKey: "paymentEntities") as? [Data] else {
            return []
        }
        
        let decoder = JSONDecoder()
        let paymentEntities: [PaymentEntity] = paymentEntitiesData.compactMap { data in
            do {
                let paymentEntity = try decoder.decode(PaymentEntity.self, from: data)
                return paymentEntity
            } catch {
                print("Error decoding payment entity: \(error)")
                return nil
            }
        }
        
        return paymentEntities
    }
    
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! HistoryTableViewCell
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
