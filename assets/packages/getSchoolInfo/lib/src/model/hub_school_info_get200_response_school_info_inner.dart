//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:neis_school_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hub_school_info_get200_response_school_info_inner.g.dart';

/// HubSchoolInfoGet200ResponseSchoolInfoInner
///
/// Properties:
/// * [ATPT_OFCDC_SC_CODE] - 시도교육청코드
/// * [ATPT_OFCDC_SC_NM] - 시도교육청명
/// * [SD_SCHUL_CODE] - 행정표준코드
/// * [SCHUL_NM] - 학교명
/// * [ENG_SCHUL_NM] - 영문학교명
/// * [SCHUL_KND_SC_NM] - 학교종류명
/// * [LCTN_SC_NM] - 시도명
/// * [JU_ORG_NM] - 관할조직명
/// * [FOND_SC_NM] - 설립명
/// * [ORG_RDNZC] - 도로명우편번호
/// * [ORG_RDNMA] - 도로명주소
/// * [ORG_RDNDA] - 도로명상세주소
/// * [ORG_TELNO] - 전화번호
/// * [HMPG_ADRES] - 홈페이지주소
/// * [COEDU_SC_NM] - 남녀공학구분명
/// * [ORG_FAXNO] - 팩스번호
/// * [HS_SC_NM] - 고등학교구분명
/// * [INDST_SPECL_CCCCL_EXST_YN] - 산업체특별학급존재여부
/// * [HS_GNRL_BUSNS_SC_NM] - 고등학교일반전문구분명
/// * [SPCLY_PURPS_HS_ORD_NM] - 특수목적고등학교계열명
/// * [ENE_BFE_SEHF_SC_NM] - 입시전후기구분명
/// * [DGHT_SC_NM] - 주야구분명
/// * [FOND_YMD] - 설립일자
/// * [FOAS_MEMRD] - 개교기념일
/// * [LOAD_DTM] - 수정일자
@BuiltValue()
abstract class HubSchoolInfoGet200ResponseSchoolInfoInner implements Built<HubSchoolInfoGet200ResponseSchoolInfoInner, HubSchoolInfoGet200ResponseSchoolInfoInnerBuilder> {
  /// 시도교육청코드
  @BuiltValueField(wireName: r'ATPT_OFCDC_SC_CODE')
  String? get ATPT_OFCDC_SC_CODE;

  /// 시도교육청명
  @BuiltValueField(wireName: r'ATPT_OFCDC_SC_NM')
  String? get ATPT_OFCDC_SC_NM;

  /// 행정표준코드
  @BuiltValueField(wireName: r'SD_SCHUL_CODE')
  String? get SD_SCHUL_CODE;

  /// 학교명
  @BuiltValueField(wireName: r'SCHUL_NM')
  String? get SCHUL_NM;

  /// 영문학교명
  @BuiltValueField(wireName: r'ENG_SCHUL_NM')
  String? get ENG_SCHUL_NM;

  /// 학교종류명
  @BuiltValueField(wireName: r'SCHUL_KND_SC_NM')
  String? get SCHUL_KND_SC_NM;

  /// 시도명
  @BuiltValueField(wireName: r'LCTN_SC_NM')
  String? get LCTN_SC_NM;

  /// 관할조직명
  @BuiltValueField(wireName: r'JU_ORG_NM')
  String? get JU_ORG_NM;

  /// 설립명
  @BuiltValueField(wireName: r'FOND_SC_NM')
  String? get FOND_SC_NM;

  /// 도로명우편번호
  @BuiltValueField(wireName: r'ORG_RDNZC')
  String? get ORG_RDNZC;

  /// 도로명주소
  @BuiltValueField(wireName: r'ORG_RDNMA')
  String? get ORG_RDNMA;

  /// 도로명상세주소
  @BuiltValueField(wireName: r'ORG_RDNDA')
  String? get ORG_RDNDA;

  /// 전화번호
  @BuiltValueField(wireName: r'ORG_TELNO')
  String? get ORG_TELNO;

  /// 홈페이지주소
  @BuiltValueField(wireName: r'HMPG_ADRES')
  String? get HMPG_ADRES;

  /// 남녀공학구분명
  @BuiltValueField(wireName: r'COEDU_SC_NM')
  String? get COEDU_SC_NM;

  /// 팩스번호
  @BuiltValueField(wireName: r'ORG_FAXNO')
  String? get ORG_FAXNO;

  /// 고등학교구분명
  @BuiltValueField(wireName: r'HS_SC_NM')
  String? get HS_SC_NM;

  /// 산업체특별학급존재여부
  @BuiltValueField(wireName: r'INDST_SPECL_CCCCL_EXST_YN')
  String? get INDST_SPECL_CCCCL_EXST_YN;

  /// 고등학교일반전문구분명
  @BuiltValueField(wireName: r'HS_GNRL_BUSNS_SC_NM')
  String? get HS_GNRL_BUSNS_SC_NM;

  /// 특수목적고등학교계열명
  @BuiltValueField(wireName: r'SPCLY_PURPS_HS_ORD_NM')
  String? get SPCLY_PURPS_HS_ORD_NM;

  /// 입시전후기구분명
  @BuiltValueField(wireName: r'ENE_BFE_SEHF_SC_NM')
  String? get ENE_BFE_SEHF_SC_NM;

  /// 주야구분명
  @BuiltValueField(wireName: r'DGHT_SC_NM')
  String? get DGHT_SC_NM;

  /// 설립일자
  @BuiltValueField(wireName: r'FOND_YMD')
  Date? get FOND_YMD;

  /// 개교기념일
  @BuiltValueField(wireName: r'FOAS_MEMRD')
  Date? get FOAS_MEMRD;

  /// 수정일자
  @BuiltValueField(wireName: r'LOAD_DTM')
  DateTime? get LOAD_DTM;

  HubSchoolInfoGet200ResponseSchoolInfoInner._();

  factory HubSchoolInfoGet200ResponseSchoolInfoInner([void updates(HubSchoolInfoGet200ResponseSchoolInfoInnerBuilder b)]) = _$HubSchoolInfoGet200ResponseSchoolInfoInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HubSchoolInfoGet200ResponseSchoolInfoInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HubSchoolInfoGet200ResponseSchoolInfoInner> get serializer => _$HubSchoolInfoGet200ResponseSchoolInfoInnerSerializer();
}

class _$HubSchoolInfoGet200ResponseSchoolInfoInnerSerializer implements PrimitiveSerializer<HubSchoolInfoGet200ResponseSchoolInfoInner> {
  @override
  final Iterable<Type> types = const [HubSchoolInfoGet200ResponseSchoolInfoInner, _$HubSchoolInfoGet200ResponseSchoolInfoInner];

  @override
  final String wireName = r'HubSchoolInfoGet200ResponseSchoolInfoInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HubSchoolInfoGet200ResponseSchoolInfoInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.ATPT_OFCDC_SC_CODE != null) {
      yield r'ATPT_OFCDC_SC_CODE';
      yield serializers.serialize(
        object.ATPT_OFCDC_SC_CODE,
        specifiedType: const FullType(String),
      );
    }
    if (object.ATPT_OFCDC_SC_NM != null) {
      yield r'ATPT_OFCDC_SC_NM';
      yield serializers.serialize(
        object.ATPT_OFCDC_SC_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.SD_SCHUL_CODE != null) {
      yield r'SD_SCHUL_CODE';
      yield serializers.serialize(
        object.SD_SCHUL_CODE,
        specifiedType: const FullType(String),
      );
    }
    if (object.SCHUL_NM != null) {
      yield r'SCHUL_NM';
      yield serializers.serialize(
        object.SCHUL_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.ENG_SCHUL_NM != null) {
      yield r'ENG_SCHUL_NM';
      yield serializers.serialize(
        object.ENG_SCHUL_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.SCHUL_KND_SC_NM != null) {
      yield r'SCHUL_KND_SC_NM';
      yield serializers.serialize(
        object.SCHUL_KND_SC_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.LCTN_SC_NM != null) {
      yield r'LCTN_SC_NM';
      yield serializers.serialize(
        object.LCTN_SC_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.JU_ORG_NM != null) {
      yield r'JU_ORG_NM';
      yield serializers.serialize(
        object.JU_ORG_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.FOND_SC_NM != null) {
      yield r'FOND_SC_NM';
      yield serializers.serialize(
        object.FOND_SC_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.ORG_RDNZC != null) {
      yield r'ORG_RDNZC';
      yield serializers.serialize(
        object.ORG_RDNZC,
        specifiedType: const FullType(String),
      );
    }
    if (object.ORG_RDNMA != null) {
      yield r'ORG_RDNMA';
      yield serializers.serialize(
        object.ORG_RDNMA,
        specifiedType: const FullType(String),
      );
    }
    if (object.ORG_RDNDA != null) {
      yield r'ORG_RDNDA';
      yield serializers.serialize(
        object.ORG_RDNDA,
        specifiedType: const FullType(String),
      );
    }
    if (object.ORG_TELNO != null) {
      yield r'ORG_TELNO';
      yield serializers.serialize(
        object.ORG_TELNO,
        specifiedType: const FullType(String),
      );
    }
    if (object.HMPG_ADRES != null) {
      yield r'HMPG_ADRES';
      yield serializers.serialize(
        object.HMPG_ADRES,
        specifiedType: const FullType(String),
      );
    }
    if (object.COEDU_SC_NM != null) {
      yield r'COEDU_SC_NM';
      yield serializers.serialize(
        object.COEDU_SC_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.ORG_FAXNO != null) {
      yield r'ORG_FAXNO';
      yield serializers.serialize(
        object.ORG_FAXNO,
        specifiedType: const FullType(String),
      );
    }
    if (object.HS_SC_NM != null) {
      yield r'HS_SC_NM';
      yield serializers.serialize(
        object.HS_SC_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.INDST_SPECL_CCCCL_EXST_YN != null) {
      yield r'INDST_SPECL_CCCCL_EXST_YN';
      yield serializers.serialize(
        object.INDST_SPECL_CCCCL_EXST_YN,
        specifiedType: const FullType(String),
      );
    }
    if (object.HS_GNRL_BUSNS_SC_NM != null) {
      yield r'HS_GNRL_BUSNS_SC_NM';
      yield serializers.serialize(
        object.HS_GNRL_BUSNS_SC_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.SPCLY_PURPS_HS_ORD_NM != null) {
      yield r'SPCLY_PURPS_HS_ORD_NM';
      yield serializers.serialize(
        object.SPCLY_PURPS_HS_ORD_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.ENE_BFE_SEHF_SC_NM != null) {
      yield r'ENE_BFE_SEHF_SC_NM';
      yield serializers.serialize(
        object.ENE_BFE_SEHF_SC_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.DGHT_SC_NM != null) {
      yield r'DGHT_SC_NM';
      yield serializers.serialize(
        object.DGHT_SC_NM,
        specifiedType: const FullType(String),
      );
    }
    if (object.FOND_YMD != null) {
      yield r'FOND_YMD';
      yield serializers.serialize(
        object.FOND_YMD,
        specifiedType: const FullType(Date),
      );
    }
    if (object.FOAS_MEMRD != null) {
      yield r'FOAS_MEMRD';
      yield serializers.serialize(
        object.FOAS_MEMRD,
        specifiedType: const FullType(Date),
      );
    }
    if (object.LOAD_DTM != null) {
      yield r'LOAD_DTM';
      yield serializers.serialize(
        object.LOAD_DTM,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HubSchoolInfoGet200ResponseSchoolInfoInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HubSchoolInfoGet200ResponseSchoolInfoInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'ATPT_OFCDC_SC_CODE':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ATPT_OFCDC_SC_CODE = valueDes;
          break;
        case r'ATPT_OFCDC_SC_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ATPT_OFCDC_SC_NM = valueDes;
          break;
        case r'SD_SCHUL_CODE':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.SD_SCHUL_CODE = valueDes;
          break;
        case r'SCHUL_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.SCHUL_NM = valueDes;
          break;
        case r'ENG_SCHUL_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ENG_SCHUL_NM = valueDes;
          break;
        case r'SCHUL_KND_SC_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.SCHUL_KND_SC_NM = valueDes;
          break;
        case r'LCTN_SC_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.LCTN_SC_NM = valueDes;
          break;
        case r'JU_ORG_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.JU_ORG_NM = valueDes;
          break;
        case r'FOND_SC_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.FOND_SC_NM = valueDes;
          break;
        case r'ORG_RDNZC':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ORG_RDNZC = valueDes;
          break;
        case r'ORG_RDNMA':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ORG_RDNMA = valueDes;
          break;
        case r'ORG_RDNDA':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ORG_RDNDA = valueDes;
          break;
        case r'ORG_TELNO':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ORG_TELNO = valueDes;
          break;
        case r'HMPG_ADRES':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.HMPG_ADRES = valueDes;
          break;
        case r'COEDU_SC_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.COEDU_SC_NM = valueDes;
          break;
        case r'ORG_FAXNO':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ORG_FAXNO = valueDes;
          break;
        case r'HS_SC_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.HS_SC_NM = valueDes;
          break;
        case r'INDST_SPECL_CCCCL_EXST_YN':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.INDST_SPECL_CCCCL_EXST_YN = valueDes;
          break;
        case r'HS_GNRL_BUSNS_SC_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.HS_GNRL_BUSNS_SC_NM = valueDes;
          break;
        case r'SPCLY_PURPS_HS_ORD_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.SPCLY_PURPS_HS_ORD_NM = valueDes;
          break;
        case r'ENE_BFE_SEHF_SC_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ENE_BFE_SEHF_SC_NM = valueDes;
          break;
        case r'DGHT_SC_NM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.DGHT_SC_NM = valueDes;
          break;
        case r'FOND_YMD':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.FOND_YMD = valueDes;
          break;
        case r'FOAS_MEMRD':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.FOAS_MEMRD = valueDes;
          break;
        case r'LOAD_DTM':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.LOAD_DTM = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HubSchoolInfoGet200ResponseSchoolInfoInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HubSchoolInfoGet200ResponseSchoolInfoInnerBuilder();
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

