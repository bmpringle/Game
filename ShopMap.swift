class ShopMap{

    var moneyinshop: Int
    var shoplist = [ItemInShop]()

    struct ItemInShop {
        var item: Item
        var cost: Int 
    }

    struct DataToMap{
        var itemShop: ItemInShop
        var money: Int
    }

    init(money: Int) {
        moneyinshop=money
    }

    func addItemToShop(item: Item, price: Int) {
        shoplist.append(ItemInShop(item: item, cost: price))
    }

    func runshop() -> DataToMap {
        print("The shop is selling:")
        for i in 0..<shoplist.count {
            print("\(i+1). " + shoplist[i].item.name)     
        }
        let s = string_unwrapper(str:inputForced())

        for i in 0..<shoplist.count {
            if(s.lowercased() == shoplist[i].item.name.lowercased() || s.lowercased() == "\(i+1)") {
                if(shoplist[i].cost <= moneyinshop) {
                    print("You bought the \(shoplist[i].item.name) for \(shoplist[i].cost).")
                    moneyinshop=moneyinshop-shoplist[i].cost
                    return DataToMap(itemShop: shoplist[i], money:moneyinshop)
                }else{
                    print("You don't have enough money to buy that item.")
                }
            }
        }
        return DataToMap(itemShop: ItemInShop(item: Item(itemname: "nil"), cost: 1), money: moneyinshop)
    }
}