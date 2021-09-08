import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:kanban_app/constants/utils.dart';
import 'package:kanban_app/models/login_model.dart';

enum RequestNames {
  login,
  main,
  cardsGet,
  cardsPost,
}

String tokenn =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo4MTcsInVzZXJuYW1lIjoiemFrZXJtYW4iLCJleHAiOjE2MzA4NTg3MDUsImVtYWlsIjoiIiwib3JpZ19pYXQiOjE2MzA4NTUxMDV9.CBwptFcL1PHyzpHE1_IxfyeOR3-RLkFLw8wWQ5M1yUo";

class ApiProvider {
  var _token;
  var _box = Hive.box('myBox');
  Future<dynamic> requestPost(
    RequestNames requestName, {
    String? username,
    String? password,
    String? id,
    String? row,
    String? text,
  }) async {
    var responseJson;

    if (_box.containsKey('token')) {
      this._token = _box.get('token');
    }
    switch (requestName) {
      case RequestNames.login:
        try {
          log("logging the post login", name: "data");
          log("${username!.length} -- ${password!.length}", name: "data");
          log(LOGIN_REQUEST, name: "LOGIN REQ");
          final response = await http.post(
            Uri.parse(URL_DOMEN),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $tokenn',
            },
            body: jsonEncode(
              <String, String>{
                'username': username,
                'password': password,
              },
            ),
          );
          log(response.statusCode.toString(), name: "statusCode");
          responseJson = _response(response, requestName);
        } catch (e) {
          log(e.toString());
          return e;
        }
        return responseJson;
        break;
      case RequestNames.cardsGet:
        try {
          final response = await http.get(
            Uri.parse(CARDS_REQUEST),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'X-Auth': _token,
            },
          );
          log(response.statusCode.toString(), name: "Status");
          log(response.body.toString(), name: "dataBody");
          responseJson = _response(response, requestName);
        } catch (e) {
          log(e.toString());
          return e;
        }
        return responseJson;
        break;
      case RequestNames.cardsPost:
        try {
          log('${row!.length} -- ${text!.length}', name: 'Row and TEXT');
          final response = await http.post(
            Uri.parse(CARDS_REQUEST + id!),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              // 'X-Auth': _token,
            },
            body: jsonEncode(
              <String, String>{
                'row': row,
                'text': text,
              },
            ),
          );
          responseJson = _response(response, requestName);
        } catch (e) {
          log(e.toString());
          return e;
        }
        return responseJson;
        break;
      default:
        return Exception();
    }
  }

  dynamic _response(http.Response response, RequestNames requestname) {
    switch (response.statusCode) {
      case 200:
        if (requestname == RequestNames.login) {
          String? tokenToPut = response.headers["authorization"];
          // String tokenToPut = response.headers["token"];
          this._box.put('token', tokenToPut);
          log(tokenToPut!, name: "token");

          LoginModel _loginModel = loginModelFromJson(response.body);
          return _loginModel;
        } else if (requestname == RequestNames.cardsGet) {
          // DetailOrderModel _detailOrderModel =
          //     detailOrderModelFromJson(response.bodyBytes);
          String res = utf8.decode(response.bodyBytes);
          return res;
        } else if (requestname == RequestNames.cardsPost  ) {
          log("here", name: "HERE i am");
          // MyOrdersModel _myOrdersModel =
          //     myOrdersModelFromJson(response.bodyBytes);
          String res = utf8.decode(response.bodyBytes);
          // dynamic res = json.decode(utf8.decode(response.bodyBytes)));
          // log(res.toString(), name: "RequestNames.myOrders");

          return res;
          // return _myOrdersModel;
        }
        // else if (requestname == RequestNames.collegeDetail) {
        //   print('BEFORE REQUESTNAMES.COLLEGE_DETAIL');
        //   CollegeDetailModel _collegeDetailModel =
        //   collegeDetailModelFromJson(response.bodyBytes);
        //   // Map<String, dynamic> _map = json.decode(utf8.decode(response.bodyBytes));
        //
        //   log(_collegeDetailModel.toJson().toString(),
        //       name: "REQUESTNAMES.COLLEGE_DETAIL");
        //   return /*_map;*/ _collegeDetailModel;
        //
        //   // String res = utf8.decode(response.bodyBytes);
        //   // return res;
        // }
        break;
      case 400:
        log("IN THE 404");
        throw Exception("ASANICHE");
        break;
      // throw BadRequestException(response.body.toString());
      case 401:
        throw Exception();
        break;
      case 403:
        throw Exception();
        break;
      // throw UnauthorisedException(response.body.toString());
      case 500:
        throw Exception();
        break;
      default:
        throw Exception();
        break;
    }
  }
}
