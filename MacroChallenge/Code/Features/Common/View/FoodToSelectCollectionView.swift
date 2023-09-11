

import UIKit
 

class FoodToSelectCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout{
    
    weak var foodToSelectDelegate: FoodToSelectDelegate? = nil
//    weak var favoriteFoodDelegate: FavoriteFoodDelegate? = nil
    var shoppingList: ShoppingListModel?
    var foods: [Food] = [Food]() {
        didSet {
            self.reloadData()
        }
    }
    var currentMonth = String()
    private let spacing:CGFloat = 16.0
    
    var isShoppingList = false
    
    var arrData = [Food]() 
    var arrSelectedIndex = [IndexPath]()
    var arrSelectedData = [Food]()

    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(SelectionCellView.self, forCellWithReuseIdentifier: "SelectionCellView")
        self.delegate = self
        self.dataSource = self
        self.backgroundView = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FoodToSelectCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCellView", for: indexPath) as! SelectionCellView
        let currentStateSeasonality = self.foods[indexPath.row].seasonalities[self.foods[indexPath.row].seasonalities.firstIndex(where: { $0.month_name_seasonality == self.currentMonth }) ?? 0].state_seasonality
        
        cell.sazonality.image = UIImage.getImageSazonality(currentStateSeasonality)
        cell.foodImage.image = UIImage(named: "\(self.foods[indexPath.row].image_source_food)")
        cell.nameFood.text = foods[indexPath.row].name_food
        cell.backgroundColor = .SZColorBeige
        cell.layer.cornerRadius = .SZCornerRadiusMediumShape
        if !isShoppingList {
            if arrSelectedIndex.contains(indexPath) {
                cell.btnSelect.image = UIImage(named: "SZ.checkmark.circle.fill")
            }
            else {
                cell.btnSelect.image = UIImage(named: "SZ.checkmark.circle")
            }
        } else {
            cell.btnSelect.image = UIImage(named: "button_delete")
        }
        return cell
    }
    
    
}

extension FoodToSelectCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("OLA")
        if let shoppingList {
            if !isShoppingList {
                let strData = foods[indexPath.item]
                if arrSelectedIndex.contains(indexPath) {
                    arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
                    arrSelectedData = arrSelectedData.filter { $0.id_food != strData.id_food}
                }
                else {
                    ShoppingListManager.shared.addNewItemBoughtList(ShoppingListManager.shared.defaultKey, idBoughtList: shoppingList.id, idItem: foods[indexPath.row].id_food)
                    
                    foodToSelectDelegate?.didSelectFood(shoppingList: shoppingList, food: foods[indexPath.row])
    //               ShoppingListManager.shared.getAllBoughtList(ShoppingListManager.shared.defaultKey) {
    //                    let newShoppingLists = ShoppingListManager.shared.shoppingLists
    //                    self.shoppingList = newShoppingLists[newShoppingLists.firstIndex(where: { $0.id == self.shoppingList?.id }) ?? 0]
    //                    let foodToSelectCollectionView = FoodToSelectCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    //                    foodToSelectCollectionView.foods = [Food(id_food: 4, name_food: "s", image_source_food: "w", is_favorite_food: false, category_food: Category(id_category: 0, name_category: " "), seasonalities: [Seasonality(month_name_seasonality: "", state_seasonality: "")])]
    //                    NotificationCenter.default.post(name: .shoppingList, object: foodToSelectCollectionView)
    //                }
                    arrSelectedIndex.append(indexPath)
                    arrSelectedData.append(strData)
                }

                collectionView.reloadData()
            } else {
                //Apagar fruta aqui
            }
        }
        
       
    }
}