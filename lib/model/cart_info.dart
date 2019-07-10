class CartInfoModel {
  String goodsId;
  String goodsName;
  int count;
  double oriPrice;
  double price;
  String images;

  CartInfoModel(
      {this.goodsId,
      this.goodsName,
      this.count,
      this.oriPrice,
      this.price,
      this.images});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    oriPrice = json['oriPrice'];
    price = json['price'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['oriPrice'] = this.oriPrice;
    data['price'] = this.price;
    data['images'] = this.images;
    return data;
  }
}
