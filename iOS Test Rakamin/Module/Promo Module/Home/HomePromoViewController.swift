//
//  HomePromoViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import UIKit

class HomePromoViewController: UIViewController {
    var presenter: HomePromoViewToPresenterProtocol?
    
    private var carouselView: CarouselView?
    private let backgroundColor: UIColor = .white
    
    private var emptyLabel: UILabel!
    
    private var carouselData = [CarouselView.CarouselData]() {
        didSet {
            updateUIForCarouselData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        presenter?.getPromos()
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
        
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        title = "Promo"
    }
    
    private func setupUI() {
        view.backgroundColor = backgroundColor
        
        emptyLabel = UILabel()
        emptyLabel.text = "Sedang memuat promo..."
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .black
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        carouselView = CarouselView(delegate: self)
        if let carouselView = carouselView {
            view.addSubview(carouselView)
            carouselView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                carouselView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
                carouselView.leftAnchor.constraint(equalTo: view.leftAnchor),
                carouselView.rightAnchor.constraint(equalTo: view.rightAnchor),
                carouselView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
    }
    
    private func updateUIForCarouselData() {
        let isEmpty = carouselData.isEmpty
        emptyLabel.isHidden = !isEmpty
        carouselView?.isHidden = isEmpty
        carouselView?.configureView(with: carouselData)
    }
}

extension HomePromoViewController: CarouselViewDelegate {
    func currentPageDidChange(to page: Int) {
        // Handle current page change if needed
    }
}

extension HomePromoViewController: HomePromoPresenterToViewProtocol {
    func succesDelegate(promo: PromoResponse) {
        let data = promo.promos?.compactMap { promo in
            return CarouselView.CarouselData(imageURL: promo.imagesURL.toURL(), text: promo.name ?? "", detailURL: promo.detail.toURL())
        } ?? []
        
        carouselData = data
    }
    
    func errorDelegate() {
        carouselData = []
    }
    
    func loadingStateHasChanged(isLoading: Bool) {
        // Handle loading state change if needed
    }
}

#Preview {
    var controller = HomePromoRouter.createModule()
    return controller
}
