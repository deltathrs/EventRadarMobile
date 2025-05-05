part of 'ad_slider_cubit.dart';

@immutable
sealed class AdSliderState {}

final class AdSliderInitial extends AdSliderState {}

final class AdSliderLoading extends AdSliderState {}

final class AdSliderLoaded extends AdSliderState {
  final List<AdSliderModel> adSliderList;

  AdSliderLoaded({required this.adSliderList});
}

final class AdSliderError extends AdSliderState {
  final String error;

  AdSliderError({required this.error});
}
