

import UIKit

class SearchView: UIView {
    
    lazy var search: SearchBarComponent = {
        let view = SearchBarComponent()
        view.placeholder = "Digite sua pesquisa"
        view.barTintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var fastFilterComponent: FastFilterComponent = {
        let fastFilterComponent = FastFilterComponent(frame: .zero)
        fastFilterComponent.translatesAutoresizingMaskIntoConstraints = false
        return fastFilterComponent
    }()
    
    lazy var collectionView: FoodCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 105, height: 140)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let collectionViewInstance = FoodCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewInstance.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionViewInstance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchView: ViewCode{
    func buildViewHierarchy() {
        [self.search, self.fastFilterComponent, self.collectionView].forEach({ self.addSubview($0) })
    }
    
    func setupConstraints() {
        self.search.setupConstraints { view in
            [
                view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: self.fastFilterComponent.topAnchor, constant: -20)
            ]}
        
        self.fastFilterComponent.setupConstraints { view in
            [
                view.topAnchor.constraint(equalTo: self.search.bottomAnchor, constant: 20),
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                view.heightAnchor.constraint(equalToConstant: 100),
                view.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor)
            ]}
        
        self.collectionView.setupConstraints { view in
            [
                view.topAnchor.constraint(equalTo: self.fastFilterComponent.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -90)
            ]
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }
}
