import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/home/data/ad_slider_model.dart';
import 'package:event_radar2/feature/home/repository/adslider_repository.dart';
import 'package:meta/meta.dart';

part 'ad_slider_state.dart';

class AdSliderCubit extends Cubit<AdSliderState> {
  final AdsliderRepository adsliderRepository;
  AdSliderCubit({required this.adsliderRepository}) : super(AdSliderInitial());

  Future<void> getAdSliderList() async {
    emit(AdSliderLoading());
    try {
      final adSliderList = await adsliderRepository.getAdSliderList();
      emit(AdSliderLoaded(adSliderList: adSliderList));
    } catch (e) {
      emit(AdSliderError(error: e.toString()));
    }
  }
}
