import 'package:dartz/dartz.dart';
import 'package:silver_gold_price/core/networking/dio.helper.dart';
// تأكد من مسار الموديل (قد يختلف حسب مكان الملف عندك)
import 'package:silver_gold_price/featuers/coin/data/models/coinmodel.dart'; 

class CoinRepo {
  // الدالة يجب أن ترجع CoinModel وليس double
  Future<Either<String, CoinModel>> getCoinPrice(String symbol) async {
    try {
      final response = await DioHelper.getData(endpoint: symbol);
      
      // هنا المشكلة كانت سابقاً: لازم نحول الـ Map لـ Model
      return right(CoinModel.fromJson(response.data));
      
    } catch (e) {
      return left(e.toString());
    }
  }
}