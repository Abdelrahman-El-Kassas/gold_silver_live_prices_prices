import 'package:silver_gold_price/featuers/coin/data/models/coinmodel.dart';

abstract class CoinState {}

class CoinInitial extends CoinState {}
class CoinLoading extends CoinState {}

class CoinSuccess extends CoinState {
  final CoinModel model; // <--- لازم تكون model
  CoinSuccess(this.model);
}

class CoinError extends CoinState {
  final String errorMsg;
  CoinError(this.errorMsg);
}