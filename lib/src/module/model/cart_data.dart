class CartData {
  final int id;
  final String name;
  final int qty;
  final int price;
  final String imgUrl;
  CartData({this.id, this.name, this.qty, this.price, this.imgUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'qty': qty,
      'price': price,
      'imgurl': imgUrl
    };
  }

  @override
  String toString() {
    return 'CartData{id: $id, name: $name, qty: $qty,price:$price,imgUrl:$imgUrl}';
  }
}
