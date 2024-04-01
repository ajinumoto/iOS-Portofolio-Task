//
//  DetailPortofolioViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import UIKit

class DetailPortofolioViewController: UIViewController, DetailPortofolioPresenterToViewProtocol {

    var presenter: DetailPortofolioViewToPresenterProtocol?
    
    private var tableView: UITableView!
    private var emptyLabel: UILabel!
    
    private let cellIdentifier = "DetailPortofolioCell"
    
    var transactionData = [PieModelData]() {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        updateUI()
    }
    
    private func setupView() {
        title = "Detail Transaksi"
        view.backgroundColor = .white
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        emptyLabel = UILabel()
        emptyLabel.text = "Belum ada riwayat transaksi"
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .black
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(emptyLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func updateUI() {
        let isEmpty = transactionData.isEmpty
        emptyLabel.isHidden = !isEmpty
        tableView.isHidden = isEmpty
    }
}

extension DetailPortofolioViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HistoryTableViewCell
        let transaction = transactionData[indexPath.row]
        cell.valueLabel.text = transaction.nominal.toIDR() ?? ""
        cell.titleLabel.text = transaction.trxDate
        
        return cell
    }
}

extension DetailPortofolioViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


#Preview {
    var controller = DetailPortofolioRouter.createModule(pieModel: [PieModelData(trxDate: "12 Desember 1996", nominal: 500000), PieModelData(trxDate: "12 Desember 1996", nominal: 500000)])
    
    return controller
}
