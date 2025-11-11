//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:neis_school_client/src/model/hub_school_info_get200_response_school_info_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hub_school_info_get200_response.g.dart';

/// HubSchoolInfoGet200Response
///
/// Properties:
/// * [resultCode] - 처리 코드
/// * [resultMsg] - 처리 메시지
/// * [schoolInfo] 
@BuiltValue()
abstract class HubSchoolInfoGet200Response implements Built<HubSchoolInfoGet200Response, HubSchoolInfoGet200ResponseBuilder> {
  /// 처리 코드
  @BuiltValueField(wireName: r'resultCode')
  String? get resultCode;

  /// 처리 메시지
  @BuiltValueField(wireName: r'resultMsg')
  String? get resultMsg;

  @BuiltValueField(wireName: r'schoolInfo')
  BuiltList<HubSchoolInfoGet200ResponseSchoolInfoInner>? get schoolInfo;

  HubSchoolInfoGet200Response._();

  factory HubSchoolInfoGet200Response([void updates(HubSchoolInfoGet200ResponseBuilder b)]) = _$HubSchoolInfoGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HubSchoolInfoGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HubSchoolInfoGet200Response> get serializer => _$HubSchoolInfoGet200ResponseSerializer();
}

class _$HubSchoolInfoGet200ResponseSerializer implements PrimitiveSerializer<HubSchoolInfoGet200Response> {
  @override
  final Iterable<Type> types = const [HubSchoolInfoGet200Response, _$HubSchoolInfoGet200Response];

  @override
  final String wireName = r'HubSchoolInfoGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HubSchoolInfoGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.resultCode != null) {
      yield r'resultCode';
      yield serializers.serialize(
        object.resultCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.resultMsg != null) {
      yield r'resultMsg';
      yield serializers.serialize(
        object.resultMsg,
        specifiedType: const FullType(String),
      );
    }
    if (object.schoolInfo != null) {
      yield r'schoolInfo';
      yield serializers.serialize(
        object.schoolInfo,
        specifiedType: const FullType(BuiltList, [FullType(HubSchoolInfoGet200ResponseSchoolInfoInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HubSchoolInfoGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HubSchoolInfoGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'resultCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.resultCode = valueDes;
          break;
        case r'resultMsg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.resultMsg = valueDes;
          break;
        case r'schoolInfo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HubSchoolInfoGet200ResponseSchoolInfoInner)]),
          ) as BuiltList<HubSchoolInfoGet200ResponseSchoolInfoInner>;
          result.schoolInfo.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HubSchoolInfoGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HubSchoolInfoGet200ResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

