// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, unused_field, prefer_final_fields, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_local_variable
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Helper.dart';
import 'package:sellerkit/Constant/LocationTrack.dart';
import 'package:sellerkit/Constant/LocationTrackIos.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/NotificationController/NotificationController.dart';
import 'package:sellerkit/main.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/DashBoardController/DashBoardController.dart';
import '../../../Widgets/Navi3.dart';
import 'Analytics.dart';
import 'FeedsPage.dart';
import 'KPIScreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  Timer? timer;
  TabController? controller;

  @override
  void didChangeDependencies() {
    Future.delayed(Duration(milliseconds: 300)).then((_) async {
      await Provider.of<NotificationContoller>(context, listen: false);
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      DashBoardController.mycontroller[0].text ='';
      locationCheck();
    });
     controller = new TabController(vsync: this, length: 3, initialIndex: 0);
     controller!.addListener(_handleTabChange);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkLocation();
      // context.read<NotificationContoller>().getUnSeenNotify();
      // context.read<NotificationContoller>().onReciveFCM();
      // context.read<DashBoardController>().getDefaultValues();
      // context.read<DashBoardController>().callKpiApi();
      // context.read<DashBoardController>().callFeedsApi();
      //context.read<DashBoardController>().checkAuth();
      log(ConstantValues.sapUserType);
    });

    // timer = Timer.periodic(Duration(seconds: 5), (Timer t) => periodicTask());
   
    // timer = Timer.periodic(Duration(seconds: 1), (Timer t) => notify());
  }
void _handleTabChange() {
    setState(() {
     DashBoardController.mycontroller[0].text ='';
    });
  }
  // periodicTask() {
  //   print("Bala do it");
  //   // controller!.animateTo((controller!.index + 1));
  //   //changepageauto();
  // }

  int color = 0;
  // notify() {
  //   if (color == 0) {
  //     setState(() {
  //       color = 1;
  //     });
  //   } else {
  //     setState(() {
  //       color = 0;
  //     });
  //   }
  // }

 @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
  Future locationCheck() async {
    await Timer.periodic(Duration(minutes: 1), (timer) async {
      setState(() {

 if (Platform.isAndroid) {
     LocationTrack.determinePosition();
  } else {
     LocationTrack2.determinePosition();
  }      });
      
      // LocationPermission permission;
      // permission = await Geolocator.checkPermission();
      // Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.best);
      // ConstantValues.latitude = position.latitude.toString();
      //       ConstantValues.langtitude = position.longitude.toString();
      //               print('lati' + ConstantValues.langtitude.toString());

      //   StreamSubscription<Position> positionStream =
      //       Geolocator.getPositionStream(locationSettings: locationSettings)
      //           .listen((Position? position) async {
      //     setState(() {
      //       ConstantValues.latitude = position!.latitude.toString();
      //       ConstantValues.langtitude = position.longitude.toString();
      //       print('lati1' + ConstantValues.langtitude.toString());
      //       print('long' + ConstantValues.latitude.toString());
      //     });
      //   });
      
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  var tabIndex = 0;
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Feeds'),
    Tab(text: 'KPI'),
    Tab(text: 'Analytics'),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    // timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
        //  DefaultTabController(
        //   length: 3,
        //   initialIndex: tabIndex,
        //   child:
        WillPopScope(
      onWillPop: onWillPop, // context.read<DashBoardController>().onbackpress ,
      child: ChangeNotifierProvider<DashBoardController>(
          create: (context) => DashBoardController(context),
          builder: (context, child) {
            return Consumer<DashBoardController>(
                builder: (BuildContext context, pvdDSBD, Widget? child) {
              return Scaffold(
                drawerEnableOpenDragGesture: false,

                key: scaffoldKey,
                backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  backgroundColor: theme.primaryColor,
                  actions: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            pvdDSBD.popupmenu(context);
                          });
                        },
                        icon: Icon(Icons.list))
                    // PopupMenuButton<String>(
                    //   onSelected: (value) {
                    //     // Handle the selected option here
                    //     print('Selected: $value');
                    //   },
                    //   itemBuilder: (BuildContext context) {
                    //     return <PopupMenuEntry<String>>[
                    //       PopupMenuItem<String>(
                    //         value: 'option1',
                    //         child: Text('${ConstantValues.latitude}'),
                    //       ),
                    //       PopupMenuItem<String>(
                    //         value: 'option2',
                    //         child: Text('${ConstantValues.langtitude}'),
                    //       ),
                    //       PopupMenuItem<String>(
                    //         value: 'option3',
                    //         child: Text('${ConstantValues.ipaddress}'),
                    //       ),
                    //       PopupMenuItem<String>(
                    //         value: 'option3',
                    //         child: Text('${ConstantValues.ipname}'),
                    //       ),
                    //     ];
                    //   },
                    // ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(80),
                    child: Container(
                     padding:controller!.index.toString()=="0"? EdgeInsets.symmetric(
                          horizontal: Screens.bodyheight(context) * 0.02):EdgeInsets.symmetric(
                          horizontal: Screens.bodyheight(context) * 0.00),
                      child: Column(
                        children: [
                        controller!.index.toString()=="0"?
                          Container(
                            height: Screens.bodyheight(context) * 0.06,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    Screens.width(context) * 0.01),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 3,
                                    blurRadius: 4,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                            child: TextField(
                              controller: DashBoardController.mycontroller[0],
                              onTap: () {
                                // Get.toNamed(ConstantRoutes.screenshot);
                              },
                              autocorrect: false,
                              onChanged: (v) {
                                pvdDSBD.SearchFilter(v);
                              },
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'Search',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: theme.primaryColor,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 5,
                                ),
                              ),
                            ),
                          ):Container( 
                            // child:  Text("ItemMaster length:${pvdDSBD.allProductDetails.length}"
                        // ,style:TextStyle(color: Colors.white,)
                        // )
                        ),
                        //   SizedBox(
                        //     height:Screens.padingHeight(context)*0.01
                        //   ),
                        //  Container(
                        //   alignment:Alignment.centerLeft,
                        // child:  Text("ItemMaster length:${pvdDSBD.allProductDetails.length}"
                        // ,style:TextStyle(color: Colors.white,)
                        // )
                        //  ),
                         
                          TabBar(
                            controller: controller,
                            tabs: myTabs,
                          ),
                        ],
                      ),
                    ),
                  ),
                  title: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          // color: Colors.amber,
                              width: Screens.width(context) * 0.5,
                              // height: Screens.bodyheight(context) * 0.1,
                          child: Text(
                            'Hi, ${ConstantValues.firstName}',
                            textAlign: TextAlign.center,
                            maxLines: 10,
                            style: theme.textTheme.subtitle1
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Get.toNamed(ConstantRoutes.testing);
                            },
                            child: Container(
                              // color: Colors.amber,
                              width: Screens.width(context) * 0.12,
                              height: Screens.bodyheight(context) * 0.055,
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.white54,
                                    size: Screens.bodyheight(context) * 0.05,
                                  ),
                                  Positioned(
                                    // top: Screens.bodyheight(context)*0.005,
                                    left: Screens.width(context) * 0.05,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      padding: EdgeInsets.all(2),
                                      child: Text(
                                        context
                                            .watch<NotificationContoller>()
                                            .getunSeenNotify
                                            .toString(),
                                        //"${pvdDSBD.getunSeenNotify}",
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                // orderAppBar(context,scaffoldKey,"Dashboard"),
                drawer: drawer3(context),
                body: GestureDetector(
                  onTap: () {
                    setState(() {
                      FocusScope.of(context).unfocus();
                    });
                  },
                  onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        onWillPop();
                      });
                    }
                  },
                  child: DashBoardController.isLogout == true
                      ? Center(child: CircularProgressIndicator())
                      : TabBarView(
                          controller: controller,
                          // physics: const NeverScrollableScrollPhysics(),
                          children: [
                              (pvdDSBD.feedData.isNotEmpty &&
                                      pvdDSBD.feedsApiExcp == '' &&
                                      pvdDSBD.isloading == false)
                                  ? FeedsPage(pvdDSBD: pvdDSBD)
                                  : (pvdDSBD.feedData.isEmpty &&
                                          pvdDSBD.feedsApiExcp != '' &&
                                          pvdDSBD.isloading == false)
                                      ? Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                               pvdDSBD.lottiurl.isEmpty?Container():
                                pvdDSBD.lottiurl.isNotEmpty && pvdDSBD.lottiurl.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${pvdDSBD.lottiurl}',
        //               opacity: AnimationController(
        //     vsync: this,
        //     value: 1
        // ),
        // color:Colors.transparent,
                        // animate: true,
                        // repeat: true,
                        
                        height: Screens.padingHeight(context) * 0.2,
                        width: Screens.width(context)*0.5
                        ),
                  ):              InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Lottie.asset('${pvdDSBD.lottiurl}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                                              Text(pvdDSBD.feedsApiExcp,textAlign: TextAlign.center,),
                                            ],
                                          ))
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        ),
                              //  Empojii(),
                              pvdDSBD.getKpiData != null
                                  ? KPIScreen(
                                      pvdDSBD: pvdDSBD,
                                      color: color,
                                      kpiData: pvdDSBD.getKpiData,
                                    )
                                  : (pvdDSBD.getKpiData == null &&
                                          pvdDSBD.KpiApiExcp != "")
                                      ? Center(child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                           
                                        children: [

                                           pvdDSBD.kpilottie.isNotEmpty?               InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Lottie.asset('${pvdDSBD.kpilottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ):Container(),
                                          Text(pvdDSBD.KpiApiExcp,textAlign: TextAlign.center,),
                                        ],
                                      ))
                                      : Center(
                                          child: Column(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                          
                                            children: [
                                                         InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('Assets/no-data.png',
        //               opacity: AnimationController(
        //     vsync: this,
        //     value: 1
        // ),
        // color:Colors.transparent,
                        // animate: true,
                        // repeat: true,
                        
                        height: Screens.padingHeight(context) * 0.2,
                        width: Screens.width(context)*0.5
                        ),
                  ),
                                              Text("No data..!!",),
                                            ],
                                          )
                                          // CircularProgressIndicator(),
                                        ),
                              AnalyticsPage(
                                data21:
                                    context.read<DashBoardController>().data21,
                                dataMap:
                                    context.read<DashBoardController>().dataMap,
                              )
                            ]),
                ),
                //   });
                // }),

                // floatingActionButton: FloatingActionButton(
                //   child: Icon(Icons.add,
                //   ),
                //   onPressed: (){
                //       Get.toNamed(ConstantRoutes.feedsCreation);
                // }),
              );
            });
          }),
    );
  }

  changepageauto() {
    if (controller!.index == 0) {
      controller!.animateTo((controller!.index + 1));
    } else if (controller!.index == 1) {
      controller!.animateTo((controller!.index + 1));
    } else if (controller!.index == 2) {
      controller!.animateTo((controller!.index - 2));
    }
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
           insetPadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(0),
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // title: Text("Are you sure?"),
            // content: Text("Do you want to exit?"),
            content: Container(
              width: Screens.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                     width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Text(
                  "Alert",style: TextStyle(fontSize: 15)
                )),
                  ),
                   
                  SizedBox(
                    height: Screens.padingHeight(context)*0.01,
                  ),
                 Container(
                      padding: EdgeInsets.only(left:40),
                  width: Screens.width(context)*0.85,
                  child: Divider(color: Colors.grey,)),
                  Container(
                     alignment: Alignment.center,
                    // width: Screens.width(context)*0.5,
                    // padding: EdgeInsets.only(left:20),
                    child: Text("Are you sure",style: TextStyle(fontSize: 15),)),
                   SizedBox(
                    height: Screens.padingHeight(context)*0.01,
                  ),
                Container(
                  alignment: Alignment.center,
                    // padding: EdgeInsets.only(left:20),
                  child: Text("Do you want to exit?",style: TextStyle(fontSize: 15))),
              Container(
                  padding: EdgeInsets.only(left:40),
                  width: Screens.width(context)*0.85,
                  child: Divider(color: Colors.grey)),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                     Container(
                        width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                  )),
                            ),
                           onPressed: () {
                       exit(0);
                      },
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Container(
                        width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                  )),
                            ),
                             onPressed: () {
                            setState(() {
                             
                         Navigator.of(context).pop(false);
                       
                            });
                        // context.read<EnquiryUserContoller>().checkDialogCon();
                        
                         
                      },
                          
                            child: Text(
                              "No",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                  
                  ],
                ),
              
                ],
              ),
            ),
            // actions: [
            //   TextButton(
            //     onPressed: () => Navigator.of(context).pop(false),
            //     child: Text("No"),
            //   ),
            //   TextButton(
            //       onPressed: () {
            //         exit(0);
            //       },
            //       child: Text("yes"))
            // ],
          ),
        )) ??
        false;
  }
}
