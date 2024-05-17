// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, avoid_print, prefer_interpolation_to_compose_strings, use_build_context_synchronously

// import 'dart:async';
// import 'dart:developer';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
// import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ConfigurationController/ConfigurationController.dart';
import 'package:sellerkit/Controller/DashBoardController/DashBoardController.dart';
import 'package:sellerkit/Models/LoginModel/LoginModel.dart';
import 'package:sellerkit/Pages/Configuration/updatedialogbox.dart';
import 'package:sellerkit/Services/LoginApi/LoginApi.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../Constant/Helper.dart';
// import '../../Constant/AppConstant.dart';

class ConfigurationPage extends StatefulWidget {
  ConfigurationPage({Key? key}) : super(key: key);

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  // StreamSubscription? _intentDataStreamSubscription;
  // List<SharedMediaFile>? _sharedFiles;
  // String? _sharedText;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    String? pagename;
    int? docEntry;
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.data.isNotEmpty) {
        print("dattaa: " + message.data["DocEntry"].toString());
        docEntry = int.parse(message.data["DocEntry"].toString());
        pagename = message.data["NaviScreen"].toString();
        await checkLogin(pagename, docEntry);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<ConfigurationContoller>().showVersion();
      String? storeversion = await context
          .read<ConfigurationContoller>()
          .getStoreVersion('com.busondigitalservice.sellerkit3033');
      bool alertbox = false;
      alertbox = await fetchRemoteConfigValues('forceupdate');

      print("store version:: $alertbox::" + storeversion.toString());
      alertbox = true;
      if (storeversion != null) {
        if (alertbox != false) {
          if (ConstantValues.appversion != storeversion) {
            await showDialog(
                context: context,
                builder: ((context) => Upgraderdialogbox(
                      storeversion: storeversion,
                    ))).then((value) {
              exit(0);
            });
          } else {
            context
                .read<ConfigurationContoller>()
                .checkStartingPage(pagename, docEntry);
          }
        } else {
          context
              .read<ConfigurationContoller>()
              .checkStartingPage(pagename, docEntry);
        }
      }
    });
    //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //  context.read<ConfigurationContoller>().  showVersion();
    //        context.read<ConfigurationContoller>().checkStartingPage(pagename,docEntry);
    //     });
    // }
  }

  Future<bool> fetchRemoteConfigValues(String keyName) async {
    await Firebase.initializeApp();
    var remoteConfig = FirebaseRemoteConfig.instance;
    // await remoteConfig.setDefaults({"forceupdate": "true"});
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 6),
          minimumFetchInterval: const Duration(seconds: 15),
        ),
      );
      await remoteConfig.fetchAndActivate();
      final value = remoteConfig.getBool(keyName);

      // remoteConfig.onConfigUpdated.listen((event) async {
      //   await remoteConfig.activate();
      //   log("Update::${remoteConfig.getBool(keyName)}");
      //           print("Update::${remoteConfig.getBool(keyName)}");

      // });
      return value;
    } catch (e) {
      print('Error fetching remote config: $e');
    }
    return false;
  }

  checkLogin(String? pageName, int? docEntry) async {
    PostLoginData postLoginData = PostLoginData();
    String? getUrl = await HelperFunctions.getHostDSP();
    // ConstantValues.userNamePM = await HelperFunctions.getUserName();
    log("getUrl $getUrl");
    // log("userNamePM ${ConstantValues.userNamePM}");

    Url.queryApi = 'http://${getUrl.toString()}/api/';
    String? deviceID = await HelperFunctions.getDeviceIDSharedPreference();
    String? licenseKey = await HelperFunctions.getLicenseKeySharedPreference();
    String? userCode =
        await HelperFunctions.getLogginUserCodeSharedPreference();
    String? passsword = await HelperFunctions.getPasswordSharedPreference();
    ConstantValues.tenetID =
        (await HelperFunctions.getTenetIDSharedPreference()).toString();
    String token = (await getToken())!;

    postLoginData.deviceCode = deviceID;
    postLoginData.licenseKey = licenseKey;
    postLoginData.username = userCode;
    postLoginData.fcmToken = token;
    postLoginData.password = passsword;
    String? model = await Config.getdeviceModel();
    String? brand = await Config.getdeviceBrand();
    postLoginData.devicename = '${brand} ${model}';

    callLoginApi(postLoginData, pageName, docEntry);
  }

  callLoginApi(PostLoginData postLoginData,
      [String? pageName, int? docEntry]) async {
    await LoginAPi.getData(postLoginData).then((value) async {
      if (value.resCode! >= 200 && value.resCode! <= 210) {
        if (value.loginstatus!.toLowerCase().contains('success') &&
            value.data != null) {
          DashBoardController.isLogout = false;
          await HelperFunctions.saveLicenseKeySharedPreference(
              value.data!.licenseKey);
          // await HelperFunctions.saveSapUrlSharedPreference(
          //     value.data!.endPointUrl);
          await HelperFunctions.saveTenetIDSharedPreference(
              value.data!.tenantId);
          await HelperFunctions.saveUserIDSharedPreference(value.data!.UserID);
          ConstantValues.UserId = value.data!.UserID;
          ConstantValues.Usercode = value.data!.userCode;
          ConstantValues.storeid = int.parse(value.data!.storeid.toString());
          await HelperFunctions.saveUserLoggedInSharedPreference(true);
          await HelperFunctions.getFSTNameSharedPreference().then((value) {
            if (value != null) {
              ConstantValues.firstName = value;
            }
          });

          // await HelperFunctions.saveuserDB(value.data!.userDB);
          await HelperFunctions.savedbUserName(value.data!.UserID);
          //   await HelperFunctions.savedbPassword(value.data!.dbPassword);

          await HelperFunctions.saveUserType(value.data!.userType);
          await HelperFunctions.saveSlpCode(value.data!.slpcode);

          await checkPage(pageName, docEntry);
        } else if (value.loginstatus!.toLowerCase().contains("failed") &&
            value.data == null) {}
      } else if (value.resCode! >= 400 && value.resCode! <= 410) {
      } else {
        if (value.excep == 'No route to host') {
        } else {}
      }
    });
  }

  checkPage(String? pageName, int? docEntry) {
    if (pageName != null && docEntry != null) {
      if (pageName.toLowerCase() == 'enquiry') {
        Get.offAllNamed(ConstantRoutes.enquiriesUser);
      }
    } else {
      Get.offAllNamed(ConstantRoutes.download);
    }
  }

  Future<String?> getToken() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    return await firebaseMessaging.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Screens.width(context),
      height: Screens.fullHeight(context),
    ));
  }
}
