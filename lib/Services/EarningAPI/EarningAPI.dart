import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/EarningModel/EraningModel1.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

class Earning1Api {
  static Future<EarningModel1> getEarningData(
      ) async {
    int resCode = 500;
    try {
      log("message111"+'${Url.queryApi}SkClientPortal/GetEarning1?SlpCode=${ConstantValues.slpcode}');
            Config config = Config();    
      await config.getSetup();
       final response = await http.get(Uri.parse('${Url.queryApi}SkClientPortal/GetEarning1?SlpCode=${ConstantValues.slpcode}'),
          // ('http://164.52.214.147:47182/api/SellerKit'),

          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query":
          //       "Exec SK_GET_EARNINGS_1 '${ConstantValues.slpcode}'",
          // })
          );

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("Earnings1Api"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return EarningModel1.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return EarningModel1.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: $e");
      return EarningModel1.error(e.toString(), resCode);
    }
  }
}
