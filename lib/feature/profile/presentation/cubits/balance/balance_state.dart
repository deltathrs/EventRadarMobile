part of 'balance_cubit.dart';

@immutable
sealed class BalanceState {}

final class BalanceInitial extends BalanceState {}

final class BalanceLoading extends BalanceState {}

final class BalanceLoaded extends BalanceState {
  final BalanceModel balance;

  BalanceLoaded({required this.balance});
}

final class BalanceFailed extends BalanceState {
  final String message;

  BalanceFailed({required this.message});
}
