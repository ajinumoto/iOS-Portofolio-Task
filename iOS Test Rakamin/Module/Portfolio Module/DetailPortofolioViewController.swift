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
    private var emptyLable: UILabel!
    
    private let cell = "DetailPortofolioCell"
    
    var tansactionData = [PieModelData]() {
        didSet {
            let isEmpty = tansactionData.isEmpty
            emptyLable.isHidden = !isEmpty
            tableView.isHidden = isEmpty
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Transaksi"
        tansactionData = presenter?.pieModel ?? []
        
        view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        emptyLable = UILabel()
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: cell)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
}

extension DetailPortofolioViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tansactionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! HistoryTableViewCell
        let tansactionData = tansactionData[safe: indexPath.row]
        cell.valueLabel.text = tansactionData?.nominal.toIDR() ?? ""
        cell.titleLabel.text = tansactionData?.trxDate
        
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
