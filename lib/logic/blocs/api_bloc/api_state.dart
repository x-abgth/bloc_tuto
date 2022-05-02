part of 'api_bloc.dart';

abstract class ApiState extends Equatable {
  const ApiState();
}

class ApiInitial extends ApiState {
  @override
  List<Object?> get props => [];
}

class ApiLoading extends ApiState {
  @override
  List<Object?> get props => [];
}

class ApiLoaded extends ApiState {
  final List<Posts> posts;
  const ApiLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class ApiErrors extends ApiState {
  final String errorMsg;
  const ApiErrors({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
