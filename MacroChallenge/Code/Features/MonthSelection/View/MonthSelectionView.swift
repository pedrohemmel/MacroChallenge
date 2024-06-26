//
//  MonthSelectionView.swift
//  MacroChallenge
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 31/05/23.
//

import UIKit

class MonthSelectionView: UIView {
    //MARK: - Views
    private var capsule: UIImageView = {
        let capsule = UIImageView(image: UIImage(named: "menuItem"))
        capsule.translatesAutoresizingMaskIntoConstraints = false
        return capsule
    }()
    
    private lazy var monthSelectionCollectionView: MonthSelectionCollectionView = {
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let spaceBetweenItems = 50.0
        collectionViewLayout.itemSize = CGSize(width: (self.bounds.width / 3 - spaceBetweenItems), height: (self.bounds.width / 3 - spaceBetweenItems))
        
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionViewLayout.minimumLineSpacing = 30
        collectionViewLayout.scrollDirection = .vertical
        
        let monthSelectionCollectionView = MonthSelectionCollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        monthSelectionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return monthSelectionCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ViewCode
extension MonthSelectionView: ViewCode {
    func buildViewHierarchy() {
        [self.capsule, self.monthSelectionCollectionView].forEach({self.addSubview($0)})
    }
    
    func setupConstraints() {
        self.capsule.setupConstraints { view in
            [
                view.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                view.bottomAnchor.constraint(equalTo: self.monthSelectionCollectionView.topAnchor, constant: -30)
            ]
        }
        self.monthSelectionCollectionView.setupConstraints { view in
            [
                view.topAnchor.constraint(equalTo: self.capsule.bottomAnchor, constant: 30),
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ]
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .SZColorPrimaryColor
    }
}

//MARK: - Functions here
extension MonthSelectionView {
    func setupMonthSelectionCollectionView(months: [String], monthSelectionDelegate: MCMonthSelectionDelegate, monthSelected: String) {
        self.monthSelectionCollectionView.setup(months: months, monthSelectionDelegate: monthSelectionDelegate, monthSelected: monthSelected)
    }
}
