//
//  MonthSelectionView.swift
//  MacroChallenge
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 31/05/23.
//

import UIKit

class MonthSelectionView: UIView {
    //MARK: - Views
    lazy var monthSelectionCollectionView: MonthSelectionCollectionView = {
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let spaceBetweenItems = 40.0
        collectionViewLayout.itemSize = CGSize(width: (self.bounds.width / 3 - spaceBetweenItems), height: (self.bounds.width / 3 - spaceBetweenItems))
        collectionViewLayout.minimumInteritemSpacing = 20
        collectionViewLayout.minimumLineSpacing = 20
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
        [self.monthSelectionCollectionView].forEach({self.addSubview($0)})
    }
    
    func setupConstraints() {
        self.monthSelectionCollectionView.setupConstraints { view in
            [
                view.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ]
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .blue
    }
}
