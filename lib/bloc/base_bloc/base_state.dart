 import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utilis/models/base_model.dart';

  part 'base_state.freezed.dart';

@immutable
@freezed
class UserModuleBaseState<T> with _$BaseState<T>{
  const factory UserModuleBaseState.init() = _Init;
  const factory UserModuleBaseState.loading() = _Loading;
  const factory UserModuleBaseState.success([T? model]) = _Success<T>;
  const factory UserModuleBaseState.failure(EducationRemoteBaseModel error, VoidCallback callback) = _Failure;
}