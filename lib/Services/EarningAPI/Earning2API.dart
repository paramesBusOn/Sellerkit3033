import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/EarningModel/Earning2Model.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
// import 'package:sellerkit/main.dart';

class EarningtableApi {
  static Future<EarningModel2> getEarningtableData(
   String frmdate ,todate  ) async {
    int resCode = 500;
    try {
      log("message"+"${Url.queryApi}SkClientPortal/getearnings2/$frmdate/$todate/${ConstantValues.slpcode}");
            Config config = Config();
      
      await config.getSetup();
       final response = await http.get(Uri.parse('${Url.queryApi}SkClientPortal/getearnings2/$frmdate/$todate/${ConstantValues.slpcode}'),
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
          //       "Exec SK_GET_EARNINGS_2 '$frmdate','$todate', '${ConstantValues.slpcode}'",
          // })
          );
      // log(jsonEncode({
      //       "constr":
      //           "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
      //       "query":
      //           "Exec SK_GET_EARNINGS_2 '$frmdate','$todate', '${ConstantValues.slpcode}'",
      //     }));
      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("Rarnings2Api"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return EarningModel2.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return EarningModel2.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: $e");
      return EarningModel2.error(e.toString(), resCode);
    }
  }
}
