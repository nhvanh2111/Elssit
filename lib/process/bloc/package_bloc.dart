import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/utils/globals.dart' as globals;
import '../../core/validators/validations.dart';
import 'package:elssit/core/utils/my_utils.dart';

import 'package:elssit/core/models/package_models/package_all_data_model.dart';
import 'package:elssit/core/models/package_models/package_all_model.dart';

import 'package:elssit/process/event/package_event.dart';
import 'package:elssit/process/state/package_state.dart';

class PackageBloc {
  final eventController = StreamController<PackageEvent>();

  final stateController = StreamController<PackageState>();

  PackageBloc() {
    eventController.stream.listen((event) {
      if (event is GetAllPackageEvent) {
        getAllPackage();
      }
    });
  }

  Future<void> getAllPackage() async {
    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api/v1/package/mobile/activate-packages");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllPackageState(
            packageList: PackageAllModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch package from the REST API');
      }
    } finally {}
  }
}
