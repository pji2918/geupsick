import 'package:test/test.dart';
import 'package:neis_school_client/neis_school_client.dart';


/// tests for DefaultApi
void main() {
  final instance = NeisSchoolClient().getDefaultApi();

  group(DefaultApi, () {
    // Retrieve school basic information
    //
    // Returns school information. Supports pagination and filters.
    //
    //Future<HubSchoolInfoGet200Response> hubSchoolInfoGet(String key, String type, int pIndex, int pSize, { String ATPT_OFCDC_SC_CODE, String SD_SCHUL_CODE, String SCHUL_NM, String SCHUL_KND_SC_NM, String LCTN_SC_NM, String FOND_SC_NM }) async
    test('test hubSchoolInfoGet', () async {
      // TODO
    });

  });
}
