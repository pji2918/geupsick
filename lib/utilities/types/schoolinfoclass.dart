class SchoolData {
  List<SchoolInfo>? schoolInfo;

  SchoolData({this.schoolInfo});

  SchoolData.fromJson(Map<String, dynamic> json) {
    if (json['schoolInfo'] != null) {
      schoolInfo = <SchoolInfo>[];
      json['schoolInfo'].forEach((v) {
        schoolInfo!.add(SchoolInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (schoolInfo != null) {
      data['schoolInfo'] = schoolInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SchoolInfo {
  List<Head>? head;
  List<Row>? row;

  SchoolInfo({this.head, this.row});

  SchoolInfo.fromJson(Map<String, dynamic> json) {
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
  String? eNGSCHULNM;
  String? sCHULKNDSCNM;
  String? lCTNSCNM;
  String? jUORGNM;
  String? fONDSCNM;
  String? oRGRDNZC;
  String? oRGRDNMA;
  String? oRGRDNDA;
  String? oRGTELNO;
  String? hMPGADRES;
  String? cOEDUSCNM;
  String? oRGFAXNO;
  String? hSSCNM;
  String? iNDSTSPECLCCCCLEXSTYN;
  String? hSGNRLBUSNSSCNM;
  String? sPCLYPURPSHSORDNM;
  String? eNEBFESEHFSCNM;
  String? dGHTSCNM;
  String? fONDYMD;
  String? fOASMEMRD;
  String? lOADDTM;

  Row({
    this.aTPTOFCDCSCCODE,
    this.aTPTOFCDCSCNM,
    this.sDSCHULCODE,
    this.sCHULNM,
    this.eNGSCHULNM,
    this.sCHULKNDSCNM,
    this.lCTNSCNM,
    this.jUORGNM,
    this.fONDSCNM,
    this.oRGRDNZC,
    this.oRGRDNMA,
    this.oRGRDNDA,
    this.oRGTELNO,
    this.hMPGADRES,
    this.cOEDUSCNM,
    this.oRGFAXNO,
    this.hSSCNM,
    this.iNDSTSPECLCCCCLEXSTYN,
    this.hSGNRLBUSNSSCNM,
    this.sPCLYPURPSHSORDNM,
    this.eNEBFESEHFSCNM,
    this.dGHTSCNM,
    this.fONDYMD,
    this.fOASMEMRD,
    this.lOADDTM,
  });

  Row.fromJson(Map<String, dynamic> json) {
    aTPTOFCDCSCCODE = json['ATPT_OFCDC_SC_CODE'];
    aTPTOFCDCSCNM = json['ATPT_OFCDC_SC_NM'];
    sDSCHULCODE = json['SD_SCHUL_CODE'];
    sCHULNM = json['SCHUL_NM'];
    eNGSCHULNM = json['ENG_SCHUL_NM'];
    sCHULKNDSCNM = json['SCHUL_KND_SC_NM'];
    lCTNSCNM = json['LCTN_SC_NM'];
    jUORGNM = json['JU_ORG_NM'];
    fONDSCNM = json['FOND_SC_NM'];
    oRGRDNZC = json['ORG_RDNZC'];
    oRGRDNMA = json['ORG_RDNMA'];
    oRGRDNDA = json['ORG_RDNDA'];
    oRGTELNO = json['ORG_TELNO'];
    hMPGADRES = json['HMPG_ADRES'];
    cOEDUSCNM = json['COEDU_SC_NM'];
    oRGFAXNO = json['ORG_FAXNO'];
    hSSCNM = json['HS_SC_NM'];
    iNDSTSPECLCCCCLEXSTYN = json['INDST_SPECL_CCCCL_EXST_YN'];
    hSGNRLBUSNSSCNM = json['HS_GNRL_BUSNS_SC_NM'];
    sPCLYPURPSHSORDNM = json['SPCLY_PURPS_HS_ORD_NM'];
    eNEBFESEHFSCNM = json['ENE_BFE_SEHF_SC_NM'];
    dGHTSCNM = json['DGHT_SC_NM'];
    fONDYMD = json['FOND_YMD'];
    fOASMEMRD = json['FOAS_MEMRD'];
    lOADDTM = json['LOAD_DTM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ATPT_OFCDC_SC_CODE'] = aTPTOFCDCSCCODE;
    data['ATPT_OFCDC_SC_NM'] = aTPTOFCDCSCNM;
    data['SD_SCHUL_CODE'] = sDSCHULCODE;
    data['SCHUL_NM'] = sCHULNM;
    data['ENG_SCHUL_NM'] = eNGSCHULNM;
    data['SCHUL_KND_SC_NM'] = sCHULKNDSCNM;
    data['LCTN_SC_NM'] = lCTNSCNM;
    data['JU_ORG_NM'] = jUORGNM;
    data['FOND_SC_NM'] = fONDSCNM;
    data['ORG_RDNZC'] = oRGRDNZC;
    data['ORG_RDNMA'] = oRGRDNMA;
    data['ORG_RDNDA'] = oRGRDNDA;
    data['ORG_TELNO'] = oRGTELNO;
    data['HMPG_ADRES'] = hMPGADRES;
    data['COEDU_SC_NM'] = cOEDUSCNM;
    data['ORG_FAXNO'] = oRGFAXNO;
    data['HS_SC_NM'] = hSSCNM;
    data['INDST_SPECL_CCCCL_EXST_YN'] = iNDSTSPECLCCCCLEXSTYN;
    data['HS_GNRL_BUSNS_SC_NM'] = hSGNRLBUSNSSCNM;
    data['SPCLY_PURPS_HS_ORD_NM'] = sPCLYPURPSHSORDNM;
    data['ENE_BFE_SEHF_SC_NM'] = eNEBFESEHFSCNM;
    data['DGHT_SC_NM'] = dGHTSCNM;
    data['FOND_YMD'] = fONDYMD;
    data['FOAS_MEMRD'] = fOASMEMRD;
    data['LOAD_DTM'] = lOADDTM;
    return data;
  }
}
