import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_gold_price/featuers/coin/data/repo/coinrepo.dart';
import 'package:silver_gold_price/featuers/coin/presentation/cubit/coinstates.dart';

class CoinCubit extends Cubit<CoinState> {
  final CoinRepo coinRepo;

  CoinCubit(this.coinRepo) : super(CoinInitial());

  Future<void> fetchCoinPrice(String symbol) async {
    emit(CoinLoading());
    
    final result = await coinRepo.getCoinPrice(symbol);
    
    result.fold(
      (error) => emit(CoinError(error)),
      // (model) هنا أصبحت CoinModel وليست double
      (model) => emit(CoinSuccess(model)), 
    );
  }
}