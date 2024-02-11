import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 import '../../utilis/models/base_model.dart';
import 'base_state.dart';

class UserModuleBaseBloc<T> extends Cubit<UserModuleBaseState<T>> {
  UserModuleBaseBloc([T? data]) : super(data != null? UserModuleBaseState.success(data): const UserModuleBaseState.init());
  T? _data;

  T? get data => _data;

  set data(T? value){
    _data = value;
  }

  void loadingState(){
    emit(const UserModuleBaseState.loading());
  }

  void successState([T? data]){
    if(_data != data){
      _data = data;
    }
    emit(UserModuleBaseState.success(data));

  }

  void failedState(EducationRemoteBaseModel error, VoidCallback callback){
    emit(UserModuleBaseState.failure(error, callback));
  }

}