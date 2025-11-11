# neis_school_client.api.DefaultApi

## Load the API package
```dart
import 'package:neis_school_client/api.dart';
```

All URIs are relative to *https://open.neis.go.kr*

Method | HTTP request | Description
------------- | ------------- | -------------
[**hubSchoolInfoGet**](DefaultApi.md#hubschoolinfoget) | **GET** /hub/schoolInfo | Retrieve school basic information


# **hubSchoolInfoGet**
> HubSchoolInfoGet200Response hubSchoolInfoGet(key, type, pIndex, pSize, ATPT_OFCDC_SC_CODE, SD_SCHUL_CODE, SCHUL_NM, SCHUL_KND_SC_NM, LCTN_SC_NM, FOND_SC_NM)

Retrieve school basic information

Returns school information. Supports pagination and filters.

### Example
```dart
import 'package:neis_school_client/api.dart';

final api = NeisSchoolClient().getDefaultApi();
final String key = key_example; // String | 인증키 (example: sample key)
final String type = type_example; // String | 호출 문서 포맷 (기본값: xml)
final int pIndex = 56; // int | 페이지 위치 (기본값: 1)
final int pSize = 56; // int | 페이지 당 요청 숫자 (기본값: 100)
final String ATPT_OFCDC_SC_CODE = ATPT_OFCDC_SC_CODE_example; // String | 시도교육청코드
final String SD_SCHUL_CODE = SD_SCHUL_CODE_example; // String | 행정표준코드
final String SCHUL_NM = SCHUL_NM_example; // String | 학교명
final String SCHUL_KND_SC_NM = SCHUL_KND_SC_NM_example; // String | 학교종류명
final String LCTN_SC_NM = LCTN_SC_NM_example; // String | 시도명
final String FOND_SC_NM = FOND_SC_NM_example; // String | 설립명

try {
    final response = api.hubSchoolInfoGet(key, type, pIndex, pSize, ATPT_OFCDC_SC_CODE, SD_SCHUL_CODE, SCHUL_NM, SCHUL_KND_SC_NM, LCTN_SC_NM, FOND_SC_NM);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->hubSchoolInfoGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **key** | **String**| 인증키 (example: sample key) | 
 **type** | **String**| 호출 문서 포맷 (기본값: xml) | 
 **pIndex** | **int**| 페이지 위치 (기본값: 1) | [default to 1]
 **pSize** | **int**| 페이지 당 요청 숫자 (기본값: 100) | [default to 100]
 **ATPT_OFCDC_SC_CODE** | **String**| 시도교육청코드 | [optional] 
 **SD_SCHUL_CODE** | **String**| 행정표준코드 | [optional] 
 **SCHUL_NM** | **String**| 학교명 | [optional] 
 **SCHUL_KND_SC_NM** | **String**| 학교종류명 | [optional] 
 **LCTN_SC_NM** | **String**| 시도명 | [optional] 
 **FOND_SC_NM** | **String**| 설립명 | [optional] 

### Return type

[**HubSchoolInfoGet200Response**](HubSchoolInfoGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

