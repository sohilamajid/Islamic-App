part of 'athkar_cubit.dart';

@immutable
sealed class AthkarState {}

final class AthkarInitial extends AthkarState {}
final class AthkarLoading extends AthkarState {}
final class AthkarGetSuccess extends AthkarState {
}

