class DrinkModel {
  late String key;
  late String name;
  late  String price;
  late  String image;
  DrinkModel(
      {required this.key,
      required this.name,
      required this.price,
      required this.image});
  DrinkModel.fromJson(Map<String,dynamic> json){
    key =json['key'];
    price =json['price'];
    name =json['name'];
    image =json['image'];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data =new Map<String,dynamic>();
    data['key']=this.key;
    data['name']=this.name;
    data['price']=this.price;
    data['image']=this.image;
    return data;
  }
}
