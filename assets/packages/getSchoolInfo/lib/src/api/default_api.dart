//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:neis_school_client/src/api_util.dart';
import 'package:neis_school_client/src/model/hub_school_info_get200_response.dart';

class DefaultApi {
  final Dio _dio;

  final Serializers _serializers;

  const DefaultApi(this._dio, this._serializers);

  /// Retrieve school basic information
  /// Returns school information. Supports pagination and filters.
  ///
  /// Parameters:
  /// * [key] - 인증키 (example: sample key)
  /// * [type] - 호출 문서 포맷 (기본값: xml)
  /// * [pIndex] - 페이지 위치 (기본값: 1)
  /// * [pSize] - 페이지 당 요청 숫자 (기본값: 100)
  /// * [ATPT_OFCDC_SC_CODE] - 시도교육청코드
  /// * [SD_SCHUL_CODE] - 행정표준코드
  /// * [SCHUL_NM] - 학교명
  /// * [SCHUL_KND_SC_NM] - 학교종류명
  /// * [LCTN_SC_NM] - 시도명
  /// * [FOND_SC_NM] - 설립명
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [HubSchoolInfoGet200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<HubSchoolInfoGet200Response>> hubSchoolInfoGet({
    required String key,
    required String type,
    int pIndex = 1,
    int pSize = 100,
    String? ATPT_OFCDC_SC_CODE,
    String? SD_SCHUL_CODE,
    String? SCHUL_NM,
    String? SCHUL_KND_SC_NM,
    String? LCTN_SC_NM,
    String? FOND_SC_NM,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/hub/schoolInfo';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      r'Key': encodeQueryParameter(_serializers, key, const FullType(String)),
      r'Type': encodeQueryParameter(_serializers, type, const FullType(String)),
      r'pIndex':
          encodeQueryParameter(_serializers, pIndex, const FullType(int)),
      r'pSize': encodeQueryParameter(_serializers, pSize, const FullType(int)),
      if (ATPT_OFCDC_SC_CODE != null)
        r'ATPT_OFCDC_SC_CODE': encodeQueryParameter(
            _serializers, ATPT_OFCDC_SC_CODE, const FullType(String)),
      if (SD_SCHUL_CODE != null)
        r'SD_SCHUL_CODE': encodeQueryParameter(
            _serializers, SD_SCHUL_CODE, const FullType(String)),
      if (SCHUL_NM != null)
        r'SCHUL_NM': encodeQueryParameter(
            _serializers, SCHUL_NM, const FullType(String)),
      if (SCHUL_KND_SC_NM != null)
        r'SCHUL_KND_SC_NM': encodeQueryParameter(
            _serializers, SCHUL_KND_SC_NM, const FullType(String)),
      if (LCTN_SC_NM != null)
        r'LCTN_SC_NM': encodeQueryParameter(
            _serializers, LCTN_SC_NM, const FullType(String)),
      if (FOND_SC_NM != null)
        r'FOND_SC_NM': encodeQueryParameter(
            _serializers, FOND_SC_NM, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    HubSchoolInfoGet200Response? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
              rawResponse,
              specifiedType: const FullType(HubSchoolInfoGet200Response),
            ) as HubSchoolInfoGet200Response;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<HubSchoolInfoGet200Response>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }
}
