import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../localdb/appSharedPrefre.dart';
import '../utils/helpers.dart';

typedef ProgressUpdate = void Function(int sentBytes, int totalBytes);

enum HttpRequest { get, put, post,patch, delete, upload,putWithMedia }

class HttpService {
  HttpService._();

  static final HttpService instance = HttpService._();

  final String _baseUrl ="https://car-rental.sukrit.work/api/v1";


  Future<Map> _request(HttpRequest type, String url, data,
      [filePaths, ProgressUpdate? onProgressUpdate]) async {
    debugPrint('--------------------------------------------------------------------------------------');
    debugPrint('$type - $url');
    log('data - $data');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var token = await SharedPrefre.getAuthToken();
   // log('++++token $token');
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    if (data != null) {
      log("++http_service  data "+jsonEncode(data));
    }

    try {
      var response;
      final startTime = DateTime
          .now()
          .millisecondsSinceEpoch;
      if (type == HttpRequest.get) {
        response = await http.get(Uri.parse(url), headers: headers);
      }
      if (type == HttpRequest.put) {
        response = await http.put(Uri.parse(url),
            headers: headers, body: jsonEncode(data));
      }
      if (type == HttpRequest.post) {
        response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(data));
      }
      if (type == HttpRequest.patch) {
        response = await http.patch(Uri.parse(url),
            headers: headers, body: jsonEncode(data));
      }
      if (type == HttpRequest.upload || type == HttpRequest.putWithMedia) {
        var request = MultipartRequest(
            type == HttpRequest.upload ? 'POST' : 'PUT',
            Uri.parse(url),
            onProgress: (int bytes, int total) {
              onProgressUpdate?.call(bytes, total);
            });

        request.headers.addAll(headers);
        data.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        if (filePaths != null && filePaths.isNotEmpty) {
          for (var f in filePaths) {
            final key = f['key'];
            final path = f['path'];

            debugPrint('adding file: key=$key, path=$path');

            request.files.add(
              await http.MultipartFile.fromPath(key, path),
            );
          }
        }
        response = await request.send();
      }
      if (type == HttpRequest.delete) {
        response = await http.delete(Uri.parse(url), headers: headers,body: jsonEncode(data));
      }
      final endTime = DateTime
          .now()
          .millisecondsSinceEpoch;
      debugPrint(
          '$type - $url, status: ${response.statusCode}, response time: ${(endTime - startTime) / 1000}s');
      debugPrint('response: $response');
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 400 ||response.statusCode == 409|| response.statusCode == 401 || response.statusCode == 422) {
        var body = (type == HttpRequest.upload || type == HttpRequest.putWithMedia)
            ? jsonDecode(await response.stream.bytesToString())
            : jsonDecode(response.body);
        log('url=$url \nResponse body: ${jsonEncode(body)}');
        final int statusCode = body['statusCode'] ?? response.statusCode;
        if (statusCode == 200 ||response.statusCode == 201) {
          return body;
        }
        else if (statusCode == 401) {
          Helpers.signout();
        }
        else {
          final msg = body['message'];
          if (msg != null && msg.toString().isNotEmpty) {
            Helpers.toast(msg);
          }
          return body; // Early return to avoid calling toast again
        }
      }

      debugPrint(
          '--------------------------------------------------------------------------------------');
    } catch (e, st) {
      Helpers.toast(e.toString());
      debugPrintStack(stackTrace: st);
    }
    return Future(() => {});
  }


  Future<Map> requestLoginOtp(data) {
    return _request(HttpRequest.post, '$_baseUrl/mobile/auth/login', data);
  }
  Future<Map> verifyLoginOtp(data) {
    return _request(HttpRequest.post, '$_baseUrl/mobile/auth/verify-otp', data);
  }
  Future<Map> getProfile() {
    return _request(HttpRequest.get, '$_baseUrl/mobile/user/profile', null);
  }

  Future<Map> updateContactDetails( data,filePaths) {
    return _request(
        HttpRequest.putWithMedia, '$_baseUrl/mobile/lessors/update-contact', data, filePaths);
  }
  Future<Map> updateGSTDetails( data) {
    return _request(
        HttpRequest.put, '$_baseUrl/mobile/lessors/update-gst', data);
  }
  Future<Map> updateBankDetails( data,filePaths) {
    return _request(
        HttpRequest.putWithMedia, '$_baseUrl/mobile/lessors/update-bank', data,filePaths);
  }
  Future<Map> lessorAddVehicles( data) {
    return _request(
        HttpRequest.post, '$_baseUrl/mobile/vehicles/add-update-vehicle', data);
  }
  Future<Map> addUpdateVehicleDigio( data) {
    return _request(
        HttpRequest.post, '$_baseUrl/mobile/vehicles/add-update-vehicle-from-digio', data);
  }

  Future<Map> getVehiclesByLessorId( lessorId) {
    return _request(
        HttpRequest.get, '$_baseUrl/mobile/vehicles/lessorId/$lessorId', null);
  }



  Future<dynamic> getDesignationList(data) async {
    return _request(HttpRequest.post, '$_baseUrl/mobile/category/get-values-by-name',data);
  }
  Future<dynamic> getVehicleBrandList(data) async {
    return _request(HttpRequest.post, '$_baseUrl/mobile/category/get-values-by-name',data);
  }
  Future<dynamic> getVehicleColorsList(data) async {
    return _request(HttpRequest.post, '$_baseUrl/mobile/category/get-values-by-name',data);
  }
  Future<dynamic> getVehicleModelList(data) async {
    return _request(HttpRequest.post, '$_baseUrl/mobile/category/get-entities',data);
  }
  Future<dynamic> getVehicleVariantList(data) async {
    return _request(HttpRequest.post, '$_baseUrl/mobile/category/get-attributes',data);
  }
  Future<dynamic> gstLessorDetails(data) async {
    return _request(HttpRequest.post, '$_baseUrl/mobile/lessors/gst-verify',data);
  }
  Future<dynamic> vehicleRcVerification(data) async {
    return _request(HttpRequest.post, '$_baseUrl/mobile/vehicles/rc-verify',data);
  }
}


class MultipartRequest extends http.MultipartRequest {
  /// Creates a new [MultipartRequest].
  MultipartRequest(String method, Uri url, {required this.onProgress})
      : super(method, url);

  final void Function(int bytes, int totalBytes) onProgress;

  /// Freezes all mutable fields and returns a
  /// single-subscription [http.ByteStream]
  /// that will emit the request body.
  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = contentLength;
    var bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress.call(bytes, total);
        sink.add(data);
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }

}
