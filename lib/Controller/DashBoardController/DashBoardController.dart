// ignore_for_file: unnecessary_new, prefer_const_constructors, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable, unused_import, use_build_context_synchronously, sort_child_properties_last
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:charts_flutter_new/flutter.dart' as charts;
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:local_auth/local_auth.dart';
import 'package:screen_capture_event/screen_capture_event.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/LocationTrack.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';
import 'package:sellerkit/DBModel/ScreenShotModel.dart';
import 'package:sellerkit/Pages/Dashboard/widgets/SetupAlertBox.dart';
import 'package:sellerkit/Services/AddressGetApi/AddressGetApi.dart';
import 'package:sellerkit/Services/LocalNotification/LocalNotification.dart';
import 'package:sellerkit/Services/LoginVerificationApi/LoginVerificationApi.dart';
import 'package:sellerkit/Services/LogoutApi/LogoutApi.dart';
import 'package:sellerkit/Widgets/Dialogbox.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Constant/Helper.dart';
import '../../Constant/Screen.dart';
import '../../Models/DashBoardModels/SegementWiseModel.dart';
import '../../Models/DashBoardModels/TargetAchievementsModel.dart';
import '../../Models/GridContainerModels/GridContainerModel.dart';
import '../../Models/KpiModel/KpiModel.dart';
import '../../Models/PostQueryModel/FeedsModel/FeedsModel.dart';
import '../../Services/DashBoardApi/FeedsApi/FeedsApi.dart';
import '../../Services/DashBoardApi/FeedsApi/ReactionApi.dart';
import '../../Services/DashBoardApi/KpiApi/KpiApi.dart';
import '../../Services/URL/LocalUrl.dart';
// import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:http/http.dart' as http;

class DashBoardController extends ChangeNotifier {
  LocalNotificationService localNotificationService =
      LocalNotificationService();
  final ScreenCaptureEvent screenListener = ScreenCaptureEvent();
  Config config = Config();
  DashBoardController(BuildContext context) {
    //  getUnSeenNotify();
    //setURL();
    if (isLogout == false) {
      getDefaultValues();
    } else if (isLogout == true) {
      logoutSession();
    }
    checkPermission(context);

    //onReciveFCM();
    trackScreenShot();
  }


  String adrress = '';

  LocationPermission? permission;
  bool? locationbool = false;
  bool? camerabool = false;
  bool? notificationbool = false;
 static Future logOutMethod()async{
   String? fcm2 = await HelperFunctions.getFCMTokenSharedPreference();
    String? deviceID = await HelperFunctions.getDeviceIDSharedPreference();
    String? password =await HelperFunctions.getPasswordSharedPreference();
if (deviceID == null){
   
    deviceID = await Config.getdeviceId();
      print("deviceID"+deviceID.toString());
       await   HelperFunctions.saveDeviceIDSharedPreference(deviceID!);
       
 }
    LoginVerificationApi.getData(
            fcm2, deviceID, ConstantValues.tenetID, 1, ConstantValues.Usercode,password)
        .then((value) async {
print('Sucess'+value.message);

 await HelperFunctions.clearHost();
 Get.offAllNamed(ConstantRoutes.splash);
        });
}
  checkPermission(BuildContext context) async {
    LocationTrack.determinePosition();

    final permission = Permission.notification;
    PermissionStatus status = await permission.status;

    var locationStatus = await Permission.location.status;
    // var cameraStatus = await Permission.camera.status;
    // var notifiStatus = await Permission.notification.status;

    print('location' + locationStatus.toString());
    // print('cameraStatus' + cameraStatus.toString());
    // print('notifiStatus2' + notifiStatus.toString());

    if (locationStatus.isGranted) {
      locationbool = true;
      notifyListeners();
    }
    // if (cameraStatus.isGranted) {
    //   camerabool = true;
    //   notifyListeners();
    // }
    // if (notifiStatus.isGranted) {
    //   notificationbool = true;
    //   notifyListeners();
    // }
    // if (Platform.isIOS) {
    if (locationbool == false
        // ||
        //     camerabool == false ||
        //     notificationbool == false
        ) {
      await showDialog<dynamic>(
          barrierDismissible: true,
          context: context,
          builder: (_) {
            return PermissionShowDialog(
              locationbool: locationbool,
              camerabool: camerabool,
              notificationbool: notificationbool,
            );
          }).then((value) {}).then((value) {
        notifyListeners();
      }).then((value) {});
    }
    // }
    notifyListeners();
  }
// Future<void> getWifiInfo() async {
//   var connectivityResult = await Connectivity().checkConnectivity();

//   if (connectivityResult == ConnectivityResult.wifi) {
//     final wifiInfo = await Connectivity().getWifiInfo();

//     if (wifiInfo != null) {
//       final networkName = wifiInfo.ssid;
//       final ipAddress = wifiInfo.ip;

//       print("Network Name: $networkName");
//       print("IP Address: $ipAddress");
//     } else {
//       print("Not connected to a WiFi network.");
//     }
//   } else {
//     print("Not connected to a WiFi network.");
//   }
// }

 Future<void> popupmenu(BuildContext context) async {
    final theme = Theme.of(context);
    await showDialog<dynamic>(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return setupAlerbox(
            address: adrress,
          );
        }).then((value) {}).then((value) {
      notifyListeners();
    }).then((value) {});
  }

  var text;
  List<File> file = [];
  trackScreenShot() async {
    final Database db = (await DBHelper.getInstance())!;
    //
    screenListener.isRecording().then((value) {
      if (value) {
        print("Screen Record listener1");
        text = "You're Still Recording";
      } else {
        print(" Screen Record listener2");
        text = "You're not recording";
      }
    });
    screenListener.addScreenRecordListener((recorded) async {
      print("Hi i'm 2nd Screen Record listener1");

      ///Recorded was your record status (bool)
      text = recorded ? "Start Recording" : "Stop Recording";
    });

    screenListener.addScreenShotListener((filePath) {
      ///filePath only available for Android
      text = "Screenshot stored on : $filePath";
      file.add(File(filePath));
    });

    ///You can add multiple listener ^-^
    screenListener.addScreenRecordListener((recorded) async {
      print("Hi i'm 2nd Screen Record listener");
    });
    //
    List<ScreenShotModel> values = [];
    screenListener.addScreenShotListener((filePath) async {
      print("Wohooo i'm 2nd Screenshot listener:" + filePath.toString());
      values.add(
          ScreenShotModel(dateTime: config.currentDate(), filePath: filePath));
      await Future.delayed(Duration(seconds: 2));
      await DBOperation.insertScreenShot(values, db);
    });

    screenListener.watch();
    notifyListeners();
  }

  setURL() async {
    String? getUrl = await HelperFunctions.getHostDSP();
    //  Url.queryApi = 'http://91.203.133.224:81/api/';
    Url.queryApi = 'http://${getUrl.toString()}/api/';
  }

  int checkContent(FeedsModalData2 feedDatas) {
    int res = 0;
    if (feedDatas.MediaURL1.isNotEmpty) {
      res = res + 1;
    }
    if (feedDatas.MediaURL2.isNotEmpty) {
      res = res + 1;
    }
    if (feedDatas.MediaURL3.isNotEmpty) {
      res = res + 1;
    }
    return res;
  }
  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  static bool isLogout = false;

  logoutSession() async {
    //  HelperFunctions.clearLicenseKeyDSharedPref();
    //  HelperFunctions.clearUserCodeDSharedPref();

    HelperFunctions.clearUserLoggedInSharedPref();
    HelperFunctions.clearUserName();
    LogoutAPi.getData().then((value) {
      isLogout = false;
      Get.offAllNamed(ConstantRoutes.login);
    });
  }

  String data = '';

  int feedint = 0;

  value() {
    data = 'final';
  }

  WebViewController? controllerGlobal;
  
  Future<int> getDefaultValues() async {
    int i = 0;
    await HelperFunctions.getSapURLSharedPreference().then((value) {
      if (value != null) {
        Url.SLUrl = value;
      }
      i = i + 1;
    });
    await HelperFunctions.getSlpCode().then((value) {
      if (value != null) {
        ConstantValues.slpcode = value;
      }
      i = i + 1;
    });
    await HelperFunctions.getTenetIDSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.tenetID = value;
      }
      i = i + 1;
    });

    await HelperFunctions.getFSTNameSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.firstName = value;
        notifyListeners();
      }
    });

    await HelperFunctions.getmProfilePicSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.profilepic = value;
      }
    });
    await HelperFunctions.getLSTNameSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.lastName = value;
      }
    });
    await HelperFunctions.getemailSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.mailId = value;
      }
    });
    await HelperFunctions.getmobileSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.phoneNum = value;
      }
    });
    await HelperFunctions.getBranchSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.branch = value;
      }
    });
    await HelperFunctions.getDeviceIDSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.deviceId = value;
      }
    });
    await HelperFunctions.getManagerPhoneSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.managerPhonenum = value;
      }
    });

    await HelperFunctions.getUserType().then((value) {
      if (value != null) {
        ConstantValues.sapUserType = value;
      }
    });
//
// log("Profile pic : ${ConstantValues.profilepic}");
    log("firstName : ${ConstantValues.firstName}");
    notifyListeners();
    await callFeedsApi();
  //  await getdataFromDb();
    // await callKpiApi();
    notifyListeners();
    // notifyListeners();
    return i;
  }

  BuildContext? context;
  List<charts.Series<TargetAchievmentModel, String>> createSampleData() {
    final desktopSalesData = [
      new TargetAchievmentModel('2014', 5),
      new TargetAchievmentModel('2015', 25),
      new TargetAchievmentModel('2016', 100),
      new TargetAchievmentModel('2017', 75),
    ];

    final tableSalesData = [
      new TargetAchievmentModel('2014', 25),
      new TargetAchievmentModel('2015', 50),
      new TargetAchievmentModel('2016', 10),
      new TargetAchievmentModel('2017', 20),
    ];

    return [
      new charts.Series<TargetAchievmentModel, String>(
        id: 'Desktop',
        domainFn: (TargetAchievmentModel sales, _) => sales.year,
        measureFn: (TargetAchievmentModel sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<TargetAchievmentModel, String>(
        id: 'Tablet',
        domainFn: (TargetAchievmentModel sales, _) => sales.year,
        measureFn: (TargetAchievmentModel sales, _) => sales.sales,
        data: tableSalesData,
      ),
    ];
  }

  ////
  Map<String, double> dataMap = {
    "STAB": 40,
    "SBS": 40,
    "DC": 20,
    "FF": 20,
  };

  List<charts.Series<SegmentWiseModel, DateTime>> createSampleData2() {
    final us_data = [
      new SegmentWiseModel(new DateTime(2017, 9, 19), 5),
      new SegmentWiseModel(new DateTime(2017, 9, 26), 25),
      new SegmentWiseModel(new DateTime(2017, 10, 3), 78),
      new SegmentWiseModel(new DateTime(2017, 10, 10), 54),
    ];

    final uk_data = [
      new SegmentWiseModel(new DateTime(2017, 9, 19), 15),
      new SegmentWiseModel(new DateTime(2017, 9, 26), 33),
      new SegmentWiseModel(new DateTime(2017, 10, 3), 68),
      new SegmentWiseModel(new DateTime(2017, 10, 10), 48),
    ];

    return [
      new charts.Series<SegmentWiseModel, DateTime>(
        id: 'US Sales',
        domainFn: (SegmentWiseModel sales, _) => sales.time,
        measureFn: (SegmentWiseModel sales, _) => sales.sales,
        data: us_data,
      ),
      new charts.Series<SegmentWiseModel, DateTime>(
        id: 'UK Sales',
        domainFn: (SegmentWiseModel sales, _) => sales.time,
        measureFn: (SegmentWiseModel sales, _) => sales.sales,
        data: uk_data,
      )
    ];
  }

  List<GridConValue> data21 = [
    GridConValue("New customers", "45", 'fcedee'),
    GridConValue("Repeated", "13", 'ebf4fa'),
    GridConValue("Institution Customers", "4", 'ebfaef'),
  ];

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      //  print("are you sure");
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Are you want to exit press again!!..',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
      return Future.value(false);
    }
    ScaffoldMessenger.of(context!).removeCurrentSnackBar();
    return Future.value(true);
  }

  //// Feeds controller

  // List<FijkPlayer> player2 = [];
  String feedsApiExcp = '';
  String lottiurl='';
  String KpiApiExcp = '';
  String get getfeedsApiExcp => feedsApiExcp;
  bool isloading = false;
  bool get getisloading => isloading;
  List<FeedsModalData> feedData = [];
 List<ItemMasterDBModel> allProductDetails = [];
  List<FeedsModalData> get getfeedData => feedData;
  FeedsModalData2? feeddata2;
  FeedsModalData2? get getfeeddata2 => feeddata2;
  List<FeedsModalData> searchfeedfilter = [];
  List<FeedsModalData> get getsearchfeedfilter => searchfeedfilter;
  callFeedsApi() async {
    lottiurl='';
    isloading = true;

    notifyListeners();
    await FeedsApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadcheckdata != null) {
          for (int i = 0; i < value.leadcheckdata!.length; i++) {
            feedData = value.leadcheckdata!;
            feeddata2 = value.leadcheckdata![i].leadcheckdata2;
            searchfeedfilter = feedData;
            isloading = false;
            // log("cames111" +
            //     feedData[0].leadcheckdata2!.CreatedDate.toString());
            // evictImage(feedData[0].ProfilePic!);
            //iniS();
            // initializedData();
            notifyListeners();
          }
        } else {
          lottiurl='Assets/no-data.png';
          feedsApiExcp = ' No Data..!! ';
          isloading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
         lottiurl='';
        feedsApiExcp =
            'Something went wrong try again...!! ${value.stcode} \n${value.exception}';
        isloading = false;
        notifyListeners();
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          lottiurl='Assets/NetworkAnimation.json';
          feedsApiExcp =
              'Something went wrong try again...!! ${value.stcode} \n${value.exception}';
          isloading = false;
          notifyListeners();
        } else {
          lottiurl='Assets/NetworkAnimation.json';
          feedsApiExcp =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          isloading = false;
          notifyListeners();
        }
      }
    });
  }

  // feedsearchfilter(String v,){
  //   if(v.isNotEmpty){
  //   searchfeedfilter =feedData.where((e) =>
  //    (e).
  //    )
  //   }

  // }
 static  List<TextEditingController> mycontroller =
      List.generate(30, (i) => TextEditingController());

  SearchFilter(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      searchfeedfilter = feedData
          .where((e) => (e)
              .leadcheckdata2!
              .Title!
              .toLowerCase()
              .contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      searchfeedfilter = feedData;
      notifyListeners();
    }
  }

  void evictImage(String url) {
    final NetworkImage provider = NetworkImage(url);
    provider.evict().then<void>((bool success) {
      if (success) debugPrint('removed image!');
    });
  }

  Future<void> launchUrlInBrowser(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  List<Emojis> emoji = [
    Emojis(key: '1F600', value: '\u{1F600}'),
    Emojis(key: '1F606', value: '\u{1F606}'),
    Emojis(key: '1F923', value: '\u{1F923}'),
    Emojis(key: '1F914', value: '\u{1F914}'),
    Emojis(key: '1F910', value: '\u{1F910}'),
    Emojis(key: '1F922', value: '\u{1F922}'),
    Emojis(key: '1F61F', value: '\u{1F61F}'),
    Emojis(key: '1F633', value: '\u{1F633}'),
    Emojis(key: '1F621', value: '\u{1F621}'),
    Emojis(key: '1F49B', value: '\u{1F49B}'),
    Emojis(key: '1F44C', value: '\u{1F44C}'),
    Emojis(key: '1F44D', value: '\u{1F44D}'),
    Emojis(key: '1F44F', value: '\u{1F44F}'),
    Emojis(key: '1F600', value: '\u{1F600}'),
    Emojis(key: '1F64f', value: '\u{1F64f}'),
  ];

  List<String> listEmoji = [
    '0x1F600',
    '0x1F606',
    '0x1F923',
    '0x1F914',
    '0x1F910',
    '0x1F922',
    '0x1F61F',
    '0x1F633',
    '0x1F621',
    '0x1F49B',
    '0x1F44C',
    '0x1F44D',
    '0x1F44F',
    '0x1F64f'
  ];
  bool reactionvisible = false;
  bool get getreactionvisible => reactionvisible;

  getsselectedEmojies(BuildContext context, FeedsModalData feedData, int i) {
    Navigator.pop(context);
    // selectedEmoji = listEmoji[i];
    feedData.Reaction = listEmoji[i];
    reactionvisible = true;
    log("data: " + feedData.Reaction.toString());
    notifyListeners();
    callReactionApi(feedData.leadcheckdata2!.FeedsID!, feedData.Reaction!);
  }

  showBottomSheet(BuildContext context, FeedsModalData feedData) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    //nznznz
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
          child: SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                children: [
                  Container(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context) * 0.35,
                    child: GridView.builder(
                        itemCount: listEmoji.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 2, //heightofcontainer
                            crossAxisSpacing: 0, //width
                            mainAxisSpacing: 4), //spacebeetweenheight,
                        itemBuilder: (BuildContext ctx, i) {
                          return Card(
                            elevation: 2,
                            shadowColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  getsselectedEmojies(context, feedData, i);
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                            String.fromCharCode(
                                                int.parse("${listEmoji[i]}")),
                                            style: theme.textTheme.headline6
                                                ?.copyWith(
                                                    color: theme
                                                        .primaryColor))), //
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
        // )),
      ),
    );
  }

  callReactionApi(int feedid, String reaction) async {
    log("feedid" + feedid.toString());
    await ReactionApi.getData(feedid, reaction).then((value) {
      Future.delayed(Duration(seconds: 3), () {
        reactionvisible = false;
        notifyListeners();
      });
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.userLtData != null) {
        } else {}
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
      } else {}
    });
  }

  Future<void> refreshFeeds() async {
    feedData.clear();
    notifyListeners();
    callFeedsApi();
    // await getdataFromDb();
  }

  ////kpi controller

  KpiModelData? kpiData;

  KpiModelData? get getKpiData => kpiData;
  bool exception = false;

  Future<void> swipeRefreshIndiactor() async {
    kpiData = null;
    notifyListeners();
    callKpiApi();
  }
String kpilottie='';
  callKpiApi() async {
    kpilottie='';
    await KpiApi.sampleDetails().then((value) {
      if (value.resCode! >= 200 && value.resCode! <= 210) {
        if (value.data != null) {
          kpiData = value.data!;
          notifyListeners();
        } else if (value.data == null) {
           kpilottie='Assets/Nodata2Animation.json';
          KpiApiExcp = "No Data..!!";
        }
      } else if (value.resCode! >= 400 && value.resCode! <= 410) {
        kpilottie='';
        KpiApiExcp = "No Data..!!";
        notifyListeners();
      } else if (value.resCode == 500) {
        kpilottie='Assets/NetworkAnimation.json';
        KpiApiExcp = "500..!!Network Issue..\nTry again Later..!!'";
        notifyListeners();
      }
    });
  }
}

class Emojis {
  String? key;
  String? value;
  Emojis({required this.key, required this.value});
}