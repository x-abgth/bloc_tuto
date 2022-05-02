import 'package:bloc/bloc.dart';
import 'package:bloc_tuto/data/models/posts_model.dart';
import 'package:bloc_tuto/data/repositories/json_repository.dart';
import 'package:equatable/equatable.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final JsonRepository json;
  ApiBloc(this.json) : super(ApiInitial()) {
    on<LoadData>((event, emit) async {
      emit(ApiLoading());
      try {
        dynamic data;
        data = await json.getData();
        emit(ApiLoaded(posts: data));
      } catch (e) {
        emit(ApiErrors(errorMsg: e.toString()));
      }
    });
  }
}
