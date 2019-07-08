class MallGoodsListModel {
  String code;
  String message;
  List<MallGoodsListData> data;

  MallGoodsListModel({this.code, this.message, this.data});

  MallGoodsListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<MallGoodsListData>();
      json['data'].forEach((v) {
        data.add(new MallGoodsListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MallGoodsListData {
  String image;
  double oriPrice;
  double presentPrice;
  String goodsName;
  String goodsId;

  MallGoodsListData(
      {this.image,
      this.oriPrice,
      this.presentPrice,
      this.goodsName,
      this.goodsId});

  MallGoodsListData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    return data;
  }
}
