class CartModel {
  late String key;
  late String name;
  late String price;
  late String image;
  late int quantity;
  late double totalPrice;
  CartModel({
    required this.key,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.totalPrice,
  });
  CartModel.fromJson(Map<String,dynamic> json){
    key =json['key'];
    price =json['price'].toString();
    name =json['name'];
    image =json['image'];
    quantity=json['quantity'] as int;
    totalPrice=double.parse(json['totalPrice'].toString());
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data =new Map<String,dynamic>();
    data['key']=this.key;
    data['name']=this.name;
    data['price']=this.price.toString();
    data['image']=this.image;
    data['quantity']=this.quantity;
    data['totalPrice']=this.totalPrice;
    return data;
  }
}
