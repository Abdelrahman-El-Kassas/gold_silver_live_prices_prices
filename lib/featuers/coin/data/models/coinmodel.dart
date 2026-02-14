class CoinModel {
  final String symbol;    // عشان نعرف هو XAU ولا XAG
  final double price;     // سعر الأونصة الخام (بالدولار)
  final String updatedAt; // وقت التحديث

  CoinModel({
    required this.symbol,
    required this.price,
    required this.updatedAt,
  });

  // Factory Constructor (زي القديم بالظبط)
  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      symbol: json['symbol'] ?? '',
      // تحويل آمن للسعر
      price: (json['price'] as num).toDouble(),
      // لاحظ حرف d عشان الـ API بتاعك
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  // ==========================================
  // المنطقة الذكية: الحسابات (Getters)
  // ==========================================

  // 1. حساب سعر الجرام الخام (عيار 24 أو فضة 999)
  // المعادلة: سعر الأونصة / 31.1035
  double get gramPrice => price / 31.1035;

  // --- حسابات الذهب (استخدمها لو الصفحة ذهب) ---
  double get gold21 => gramPrice * (21 / 24);
  double get gold18 => gramPrice * (18 / 24);

  // --- حسابات الفضة (استخدمها لو الصفحة فضة) ---
  double get silver925 => gramPrice * 0.925;
  double get silver800 => gramPrice * 0.800;
}