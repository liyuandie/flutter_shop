// const serviceUrl = 'http://test.baixingliangfan.cn/baixing/';
// const serviceUrl =
//     'https://wxmini.baixingliangfan.cn/baixing/'; //小程序接口，charles获取
const serviceUrl = 'http://v.jspang.com:8088/baixing/';

const servicePath = {
  'homePageContent': serviceUrl + 'wxmini/homePageContent', //商店首页信息
  'homePageBelowConten':
      serviceUrl + 'wxmini/homePageBelowConten', // 首页商城底部火爆专区
  'getCategory': serviceUrl + 'wxmini/getCategory', // 商品类别信息
  'getMallGoods': serviceUrl + 'wxmini/getMallGoods', // 商品分类的商品列表信息
  'getGoodDetailById': serviceUrl + 'wxmini/getGoodDetailById', // 获取商品详细信息
};
