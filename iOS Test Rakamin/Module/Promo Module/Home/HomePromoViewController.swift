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
    
    private var emptyLable: UILabel!
    
    private var carouselData = [CarouselView.CarouselData]() {
        didSet {
            let isEmpty = carouselData.isEmpty
            emptyLable.isHidden = !isEmpty
            carouselView?.isHidden = isEmpty
            carouselView?.configureView(with: carouselData)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.black
        self.title = "Promo"
        presenter?.getPromos()
        
    }
    
    override func loadView() {
        super.loadView()
        
        carouselView = CarouselView(delegate: self)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
}

private extension HomePromoViewController {
    func setupUI() {
        view.backgroundColor = backgroundColor
        
        emptyLable = UILabel()
        emptyLable.text = "Sedang memuat promo..."
        emptyLable.textAlignment = .center
        emptyLable.textColor = .black
        emptyLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyLable)
        
        NSLayoutConstraint.activate([
            emptyLable.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            emptyLable.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        guard let carouselView = carouselView else { return }
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

// MARK: - CarouselViewDelegate

extension HomePromoViewController: CarouselViewDelegate {
    func currentPageDidChange(to page: Int) {
    }
}

extension HomePromoViewController: HomePromoPresenterToViewProtocol {
    func succesDelegate(promo: PromoResponse) {
        let data = promo.promos?.map({ promo in
            return CarouselView.CarouselData(imageURL: promo.imagesURL.toURL(), text: promo.name ?? "", detailURL: promo.detail.toURL())
        })
        
        carouselData = data ?? []
        
    }
    
    func errorDelegate() {
        carouselData = []
    }
    
    func loadingStateHasChanged(isLoading: Bool) {
        
    }
}

#Preview {
    var controller = HomePromoRouter.createModule()
    
    return controller
}
