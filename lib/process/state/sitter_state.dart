import 'package:elssit/core/models/sitter_models/sitter_detail_data_model.dart';

abstract class SitState {}

class SitOtherState extends SitState {}

class SitDetailState extends SitState {
  SitDetailState({required this.sitInfo});
  SitDetailDataModel sitInfo;
}
