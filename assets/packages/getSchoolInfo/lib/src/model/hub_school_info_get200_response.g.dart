// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_school_info_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HubSchoolInfoGet200Response extends HubSchoolInfoGet200Response {
  @override
  final String? resultCode;
  @override
  final String? resultMsg;
  @override
  final BuiltList<HubSchoolInfoGet200ResponseSchoolInfoInner>? schoolInfo;

  factory _$HubSchoolInfoGet200Response(
          [void Function(HubSchoolInfoGet200ResponseBuilder)? updates]) =>
      (HubSchoolInfoGet200ResponseBuilder()..update(updates))._build();

  _$HubSchoolInfoGet200Response._(
      {this.resultCode, this.resultMsg, this.schoolInfo})
      : super._();
  @override
  HubSchoolInfoGet200Response rebuild(
          void Function(HubSchoolInfoGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HubSchoolInfoGet200ResponseBuilder toBuilder() =>
      HubSchoolInfoGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HubSchoolInfoGet200Response &&
        resultCode == other.resultCode &&
        resultMsg == other.resultMsg &&
        schoolInfo == other.schoolInfo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, resultCode.hashCode);
    _$hash = $jc(_$hash, resultMsg.hashCode);
    _$hash = $jc(_$hash, schoolInfo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HubSchoolInfoGet200Response')
          ..add('resultCode', resultCode)
          ..add('resultMsg', resultMsg)
          ..add('schoolInfo', schoolInfo))
        .toString();
  }
}

class HubSchoolInfoGet200ResponseBuilder
    implements
        Builder<HubSchoolInfoGet200Response,
            HubSchoolInfoGet200ResponseBuilder> {
  _$HubSchoolInfoGet200Response? _$v;

  String? _resultCode;
  String? get resultCode => _$this._resultCode;
  set resultCode(String? resultCode) => _$this._resultCode = resultCode;

  String? _resultMsg;
  String? get resultMsg => _$this._resultMsg;
  set resultMsg(String? resultMsg) => _$this._resultMsg = resultMsg;

  ListBuilder<HubSchoolInfoGet200ResponseSchoolInfoInner>? _schoolInfo;
  ListBuilder<HubSchoolInfoGet200ResponseSchoolInfoInner> get schoolInfo =>
      _$this._schoolInfo ??=
          ListBuilder<HubSchoolInfoGet200ResponseSchoolInfoInner>();
  set schoolInfo(
          ListBuilder<HubSchoolInfoGet200ResponseSchoolInfoInner>?
              schoolInfo) =>
      _$this._schoolInfo = schoolInfo;

  HubSchoolInfoGet200ResponseBuilder() {
    HubSchoolInfoGet200Response._defaults(this);
  }

  HubSchoolInfoGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _resultCode = $v.resultCode;
      _resultMsg = $v.resultMsg;
      _schoolInfo = $v.schoolInfo?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HubSchoolInfoGet200Response other) {
    _$v = other as _$HubSchoolInfoGet200Response;
  }

  @override
  void update(void Function(HubSchoolInfoGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HubSchoolInfoGet200Response build() => _build();

  _$HubSchoolInfoGet200Response _build() {
    _$HubSchoolInfoGet200Response _$result;
    try {
      _$result = _$v ??
          _$HubSchoolInfoGet200Response._(
            resultCode: resultCode,
            resultMsg: resultMsg,
            schoolInfo: _schoolInfo?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'schoolInfo';
        _schoolInfo?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'HubSchoolInfoGet200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
