class GeupsickInfo {
  List<MealServiceDietInfo>? mealServiceDietInfo;

  GeupsickInfo({this.mealServiceDietInfo});

  GeupsickInfo.fromJson(Map<String, dynamic> json) {
    if (json['mealServiceDietInfo'] != null) {
      mealServiceDietInfo = <MealServiceDietInfo>[];
      json['mealServiceDietInfo'].forEach((v) {
        mealServiceDietInfo!.add(MealServiceDietInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mealServiceDietInfo != null) {
      data['mealServiceDietInfo'] =
          mealServiceDietInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MealServiceDietInfo {
  List<Head>? head;
  List<Row>? row;

  MealServiceDietInfo({this.head, this.row});

  MealServiceDietInfo.fromJson(Map<String, dynamic> json) {
    if (json['head'] != null) {
      head = <Head>[];
      json['head'].forEach((v) {
        head!.add(Head.fromJson(v));
      });
    }
    if (json['row'] != null) {
      row = <Row>[];
      json['row'].forEach((v) {
        row!.add(Row.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (head != null) {
      data['head'] = head!.map((v) => v.toJson()).toList();
    }
    if (row != null) {
      data['row'] = row!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Head {
  int? listTotalCount;
  RESULT? rESULT;

  Head({this.listTotalCount, this.rESULT});

  Head.fromJson(Map<String, dynamic> json) {
    listTotalCount = json['list_total_count'];
    rESULT = json['RESULT'] != null ? RESULT.fromJson(json['RESULT']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['list_total_count'] = listTotalCount;
    if (rESULT != null) {
      data['RESULT'] = rESULT!.toJson();
    }
    return data;
  }
}

class RESULT {
  String? cODE;
  String? mESSAGE;

  RESULT({this.cODE, this.mESSAGE});

  RESULT.fromJson(Map<String, dynamic> json) {
    cODE = json['CODE'];
    mESSAGE = json['MESSAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CODE'] = cODE;
    data['MESSAGE'] = mESSAGE;
    return data;
  }
}

class Row {
  String? aTPTOFCDCSCCODE;
  String? aTPTOFCDCSCNM;
  String? sDSCHULCODE;
  String? sCHULNM;
  String? mMEALSCCODE;
  String? mMEALSCNM;
  String? mLSVYMD;
  dynamic mLSVFGR;
  String? dDISHNM;
  String? oRPLCINFO;
  String? cALINFO;
  String? nTRINFO;
  String? mLSVFROMYMD;
  String? mLSVTOYMD;
  String? lOADDTM;

  Row(
      {this.aTPTOFCDCSCCODE,
      this.aTPTOFCDCSCNM,
      this.sDSCHULCODE,
      this.sCHULNM,
      this.mMEALSCCODE,
      this.mMEALSCNM,
      this.mLSVYMD,
      this.mLSVFGR,
      this.dDISHNM,
      this.oRPLCINFO,
      this.cALINFO,
      this.nTRINFO,
      this.mLSVFROMYMD,
      this.mLSVTOYMD,
      this.lOADDTM});

  Row.fromJson(Map<String, dynamic> json) {
    aTPTOFCDCSCCODE = json['ATPT_OFCDC_SC_CODE'];
    aTPTOFCDCSCNM = json['ATPT_OFCDC_SC_NM'];
    sDSCHULCODE = json['SD_SCHUL_CODE'];
    sCHULNM = json['SCHUL_NM'];
    mMEALSCCODE = json['MMEAL_SC_CODE'];
    mMEALSCNM = json['MMEAL_SC_NM'];
    mLSVYMD = json['MLSV_YMD'];
    mLSVFGR = json['MLSV_FGR'];
    dDISHNM = json['DDISH_NM'];
    oRPLCINFO = json['ORPLC_INFO'];
    cALINFO = json['CAL_INFO'];
    nTRINFO = json['NTR_INFO'];
    mLSVFROMYMD = json['MLSV_FROM_YMD'];
    mLSVTOYMD = json['MLSV_TO_YMD'];
    lOADDTM = json['LOAD_DTM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ATPT_OFCDC_SC_CODE'] = aTPTOFCDCSCCODE;
    data['ATPT_OFCDC_SC_NM'] = aTPTOFCDCSCNM;
    data['SD_SCHUL_CODE'] = sDSCHULCODE;
    data['SCHUL_NM'] = sCHULNM;
    data['MMEAL_SC_CODE'] = mMEALSCCODE;
    data['MMEAL_SC_NM'] = mMEALSCNM;
    data['MLSV_YMD'] = mLSVYMD;
    data['MLSV_FGR'] = mLSVFGR;
    data['DDISH_NM'] = dDISHNM;
    data['ORPLC_INFO'] = oRPLCINFO;
    data['CAL_INFO'] = cALINFO;
    data['NTR_INFO'] = nTRINFO;
    data['MLSV_FROM_YMD'] = mLSVFROMYMD;
    data['MLSV_TO_YMD'] = mLSVTOYMD;
    data['LOAD_DTM'] = lOADDTM;
    return data;
  }
}
