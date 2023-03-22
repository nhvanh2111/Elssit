import 'package:elssit/core/models/package_models/package_all_model.dart';

abstract class PackageState {}

class OtherPackageState extends PackageState {}

class GetAllPackageState extends PackageState {
  GetAllPackageState({required this.packageList});
  PackageAllModel packageList;
}
