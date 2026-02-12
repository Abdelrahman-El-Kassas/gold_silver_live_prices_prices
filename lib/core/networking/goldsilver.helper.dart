import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';

// كلاس لتمثيل النتيجة (السعر + حالة البيانات)
class PriceResult {
  final double? pricePerGram;
  final bool isFromCache; // هل البيانات من الكاش؟
  final String? errorMessage; // رسالة الخطأ للعرض

  PriceResult({this.pricePerGram, required this.isFromCache, this.errorMessage});
}

class GoldSilverHelper {
  final Dio _dio = Dio();

  // مفتاح لحفظ البيانات في الهاتف
  String _getCacheKey(String symbol) => 'last_price_$symbol';

  Future<PriceResult> getPricePerGram({required String symbol}) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = _getCacheKey(symbol);

    try {
      final response = await _dio.get(
        ApiConstants.baseUrl,
        queryParameters: {
          'function': 'CURRENCY_EXCHANGE_RATE',
          'from_currency': symbol,
          'to_currency': 'USD',
          'apikey': ApiConstants.apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // 1. التحقق هل تعديت الحد المسموح؟ (Alpha Vantage يرسل Information عند التعدي)
        if (data.containsKey('Information') || data.containsKey('Note')) {
          // لقد تعديت الحد -> هات آخر سعر محفوظ
          double? lastPrice = prefs.getDouble(cacheKey);
          return PriceResult(
            pricePerGram: lastPrice,
            isFromCache: true,
            errorMessage: 'Price in last check was ',
          );
        }

        // 2. التحقق من وجود البيانات الصحيحة
        final rateData = data['Realtime Currency Exchange Rate'];
        if (rateData != null) {
          String priceString = rateData['5. Exchange Rate'];
          double pricePerOunce = double.parse(priceString);
          double pricePerGram = pricePerOunce / ApiConstants.troyOunceToGram;

          // **حفظ السعر الجديد في الكاش**
          await prefs.setDouble(cacheKey, pricePerGram);

          return PriceResult(
            pricePerGram: pricePerGram,
            isFromCache: false, // بيانات جديدة
          );
        }
      }
    } catch (e) {
      print('Network Error: $e');
    }

    // في حالة حدوث أي خطأ آخر (فصل نت مثلاً)، نعرض آخر سعر أيضاً
    double? lastPrice = prefs.getDouble(cacheKey);
    return PriceResult(
      pricePerGram: lastPrice,
      isFromCache: true,
      errorMessage: 'there is wrong in connection,Last price is ',
    );
  }
}