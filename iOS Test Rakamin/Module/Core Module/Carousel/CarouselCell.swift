//
//  CarouselCell.swift
//  carousel
//
//

import UIKit

class CarouselCell: UICollectionViewCell {
    
    // MARK: - SubViews
    
    private lazy var imageView = UIImageView()
    private lazy var textLabel = UILabel()
    private lazy var loadingIndicator = UIActivityIndicatorView(style: .medium)
    // MARK: - Properties
    
    static let cellId = "CarouselCell"
    private var detailURL: URL?
    private var isLoading = false
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Setups

private extension CarouselCell {
    func setupUI() {
        backgroundColor = .clear
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = .systemFont(ofSize: 18)
        textLabel.textColor = .black
        
        addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Public

extension CarouselCell {
    public func configure(imageURL: URL?, text: String, detailURL: URL?, imageCache: NSCache<NSString, UIImage>, imageLoaderQueue: DispatchQueue) {
        // Load image asynchronously
        isLoading = true
        loadingIndicator.startAnimating()
        
        
        self.textLabel.text = text
        
        self.detailURL = detailURL
        
        guard let imageURL else {
            return
        }
        
        imageLoaderQueue.async {
            if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as NSString) {
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                    self?.loadingIndicator.stopAnimating()
                    self?.imageView.image = cachedImage
                }
                return
            }
            
            if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                    self?.loadingIndicator.stopAnimating()
                    self?.imageView.image = image
                }
            }
        }
    }
    
    @objc private func imageTapped() {
        if let url = detailURL {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
