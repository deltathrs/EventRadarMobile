part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileDataModel profile;

  ProfileLoaded({required this.profile});
}

final class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}

final class TicketListLoading extends ProfileState {}

final class TicketListLoaded extends ProfileState {
  final List<TicketDetailModel> tickets;
  final List<ListEoModel> eoModel;

  TicketListLoaded({required this.tickets, required this.eoModel});
}

final class TicketListFailed extends ProfileState {
  final String message;

  TicketListFailed({required this.message});
}

final class EoDataLoading extends ProfileState {}

final class EoDataLoaded extends ProfileState {
  final ListEoModel eoModel;

  EoDataLoaded({required this.eoModel});
}

final class EoDataFailed extends ProfileState {
  final String message;

  EoDataFailed({required this.message});
}
