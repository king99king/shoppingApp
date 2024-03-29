

class AppData {
  static String? UserName = "userName";
}

class CategoryListLis {
  late String name;
  late String key;

  CategoryListLis({required this.name, required this.key});
  CategoryListLis.fromJson(Map<String, dynamic> json) {
    key = json['key'].toString();
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }
}

final List<CategoryListLis> CatList = [
  CategoryListLis(
    key: '',
    name: 'Chair',
  ),
  CategoryListLis(
    key: '',
    name: 'Lamb',
  ),
  CategoryListLis(
    key: '',
    name: 'Table',
  ),
  CategoryListLis(
    key: '',
    name: 'Sofa',
  ),
  CategoryListLis(
    key: '',
    name: 'Cupboard',
  ),
  CategoryListLis(
    key: '',
    name: 'Bed',
  ),
];

class CardItem {
  late String key;
  late String Img;
  late String Place;
  late String Name;
  late String Price;
  late String Detailes;
  late String category;
  late int rate;
  late int numItemsSold;
  late bool discount;

  CardItem(
      {required this.key,
      required this.Img,
      required this.Place,
      required this.Name,
      required this.Price,
      required this.Detailes,
      required this.rate,
      required this.category,
      required this.numItemsSold,
      required this.discount});

  CardItem.fromJson(Map<dynamic, dynamic> json) {
    key = json['key'].toString();
    Img = json['Img'];
    Place = json['Place'];
    Name = json['Name'];
    Detailes = json['Detailes'];
    rate = json['rate'];
    category = json['category'];
    numItemsSold = json['numItemsSold'];
    discount = json['discount'];
    Price = json['Price'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['Img'] = this.Img;
    data['Place'] = this.Place;
    data['Name'] = this.Name;
    data['Detailes'] = this.Detailes;
    data['rate'] = this.rate;
    data['category'] = this.category;
    data['numItemsSold'] = this.numItemsSold;
    data['discount'] = this.discount;
    data['Price'] = this.Price;
    return data;
  }
}



class CartItem {
  late String key;
  late String image;
  late String name;
  late String price;
  late int quantity;
  late double totalPrice;

  CartItem(
      {required this.key,
        required this.image,
        required this.name,
        required this.price,
        required this.quantity,
        required this.totalPrice,

      });

  CartItem.fromJson(Map<String, dynamic> json) {
    key = json['key'].toString();
    image = json['image'].toString();
    name = json['name'].toString();
    price = json['price'].toString();
    quantity=json['quantity'] as int;
    totalPrice=double.parse(json['totalPrice'].toString());
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['key'] = this.key;
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity']=this.quantity;
    data['totalPrice']=this.totalPrice;
    return data;
  }
}




class FavoriteItems {
  late String key;
  late String Img;
  late String Place;
  late String Name;
  late String Price;
  late String Detailes;
  late String category;
  late int rate;
  //late int? numItemsSold;
//  late bool discount;

  FavoriteItems(
      {required this.key,
        required this.Img,
        required this.Place,
        required this.Name,
        required this.Price,
        required this.Detailes
        });

  FavoriteItems.fromJson(Map<dynamic, dynamic> json) {
    key = json['key'].toString();
    Img = json['Img'].toString();
    Place = json['Place'].toString();
    Name = json['Name'].toString();
    Detailes = json['Detailes'].toString();
    Price = json['Price'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['Img'] = this.Img;
    data['Place'] = this.Place;
    data['Name'] = this.Name;
    data['Detailes'] = this.Detailes;
    data['Price'] = this.Price;
    return data;
  }
}



class CheckoutList {
  late String key;
  late String Img;
  late String Place;
  late String Name;
  late String Price;
  late String Detailes;
  late String category;
  late int rate;
  //late int? numItemsSold;
//  late bool discount;

  CheckoutList(
      {required this.key,
        required this.Img,
        required this.Place,
        required this.Name,
        required this.Price,
        required this.Detailes
      });

  CheckoutList.fromJson(Map<dynamic, dynamic> json) {
    key = json['key'].toString();
    Img = json['Img'].toString();
    Place = json['Place'].toString();
    Name = json['Name'].toString();
    Detailes = json['Detailes'].toString();
    Price = json['Price'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['Img'] = this.Img;
    data['Place'] = this.Place;
    data['Name'] = this.Name;
    data['Detailes'] = this.Detailes;
    data['Price'] = this.Price;
    return data;
  }
}































var ListOfItems = [
  // CardItem(
  //   Img: 'assets/images/chair.png',
  //   Place: 'Office',
  //   Name: 'Minimalist Chair',
  //   Price: '\$120',
  //   Detailes: 'Amazing stylish in multiple colors choice we have for you..\n'
  //       'Most selling item of this year...',
  //   rate: 5,
  //   // images: [
  //   //   "assets/images/chair.png",
  //   //   "assets/images/chair.png",
  //   //   "assets/images/chair.png"
  //   // ],
  //   category: 'Chair',
  //   numItemsSold: 23,
  //   discount: true,
  //   key: '',
  // ),
  CardItem(
    key: '',
    Img: 'assets/images/sofa.png',
    Place: 'Living Room',
    Name: 'Minimalist Sofa',
    Price: '\$175',
    Detailes: 'Amazing stylish in multiple colors choice we have for you..\n '
        'Most selling item of this year...',
    rate: 5,
    // images: [
    //   "assets/images/chair.png",
    //   "assets/images/chair.png",
    //   "assets/images/chair.png"
    // ],
    category: 'Chair',
    numItemsSold: 23,
    discount: true,
  ),
  CardItem(
    key: '',
    Img: 'assets/images/chair4.png',
    Place: 'Office',
    Name: 'Minimalist Chair',
    Price: '\$140',
    Detailes: 'Amazing stylish in multiple colors choice we have for you..\n '
        'Most selling item of this year...',
    rate: 5,
    // images: [
    //   "assets/images/chair.png",
    //   "assets/images/chair.png",
    //   "assets/images/chair.png"
    // ],
    category: 'Chair',
    numItemsSold: 23,
    discount: true,
  ),
  CardItem(
    key: '',
    Img: 'assets/images/chair3.png',
    Place: 'Office',
    Name: 'Minimalist Chair',
    Price: '\$132',
    Detailes: 'Amazing stylish in multiple colors choice we have for you..\n '
        'Most selling item of this year...',
    rate: 5,
    // images: [
    //   "assets/images/chair.png",
    //   "assets/images/chair.png",
    //   "assets/images/chair.png"
    // ],
    category: 'Chair',
    numItemsSold: 23,
    discount: true,
  ),
  CardItem(
    key: '',
    Img: 'assets/images/sofa2.png',
    Place: 'Living Room',
    Name: 'Minimalist Sofa',
    Price: '\$245',
    Detailes: 'Amazing stylish in multiple colors choice we have for you..\n '
        'Most selling item of this year...',
    rate: 5,
    // images: [
    //   "assets/images/chair.png",
    //   "assets/images/chair.png",
    //   "assets/images/chair.png"
    // ],
    category: 'Chair',
    numItemsSold: 23,
    discount: true,
  ),
  CardItem(
    key: '',
    Img: 'assets/images/bed.png',
    Place: 'Bed Room',
    Name: 'Minimalist Bed',
    Price: '\$450',
    Detailes: 'Amazing stylish in multiple colors choice we have for you..\n '
        'Most selling item of this year...',
    rate: 5,
    // images: [
    //   "assets/images/chair.png",
    //   "assets/images/chair.png",
    //   "assets/images/chair.png"
    // ],
    category: 'Chair',
    numItemsSold: 23,
    discount: false,
  ),
  CardItem(
    key: '',
    Img: 'assets/images/sofa3.png',
    Place: 'Living Room',
    Name: 'Minimalist Sofa',
    Price: '\$199',
    Detailes: 'Amazing stylish in multiple colors choice we have for you..\n '
        'Most selling item of this year...',
    rate: 5,
    // images: [
    //   "assets/images/chair.png",
    //   "assets/images/chair.png",
    //   "assets/images/chair.png"
    // ],
    category: 'Lamb',
    numItemsSold: 23,
    discount: true,
  ),
  CardItem(
    key: '',
    Img: 'assets/images/cupboard.png',
    Place: 'Bed Room',
    Name: 'Minimalist Cupboard',
    Price: '\$90',
    Detailes: 'Amazing stylish in multiple colors choice we have for you..\n '
        'Most selling item of this year...',
    rate: 5,
    // images: [
    //   "assets/images/chair.png",
    //   "assets/images/chair.png",
    //   "assets/images/chair.png"
    // ],
    category: 'Lamb',
    numItemsSold: 23,
    discount: false,
  ),
];

var ListOfFavorite = [];
var ListOfCartItems = [];
