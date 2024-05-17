// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/EarningController/EarningController.dart';
import 'package:sellerkit/Pages/MyEarnings/Screens/Earningloaddata.dart';
import 'package:sellerkit/Pages/MyEarnings/Widgets/MoneyWidget.dart';
import 'package:sellerkit/Widgets/Appbar.dart';

import '../../../Constant/padings.dart';
import '../../../Widgets/Navi3.dart';


class MyEarnings extends StatefulWidget {
  // const MyEarnings({Key? key}) : super(key: key);
  @override
  State<MyEarnings> createState() => _MyEarningsState();
}

class _MyEarningsState extends State<MyEarnings> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  Config config = Config();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<EarningController>().callEarningApi();
    });
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(          
        drawerEnableOpenDragGesture: false,
        key: scaffoldKey,
        appBar: appbar("My Earnings", scaffoldKey, theme, context),
        drawer: drawer3(context),
        body: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
          child: ChangeNotifierProvider<EarningController>(
              create: (context) => EarningController(),
              builder: (context, child) {
                return Consumer<EarningController>(
                    builder: (BuildContext context, prdEarn, Widget? child) {
                  return SafeArea(
                      child:
                          prdEarn.getearningexp.isEmpty &&
                                  prdEarn.getisloading == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: theme.primaryColor,
                                ))
                              : prdEarn.getearningexp.isNotEmpty &&
                                      prdEarn.getisloading == false
                                  ? Center(child: Text(prdEarn.getearningexp))
                                  : RefreshIndicator(
                                      onRefresh: () {
                                        return prdEarn.refreshData();
                                      },
                                      child: Container(
                                          padding: paddings.padding2(context),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              MoneyWidget(
                                                theme: theme,
                                                prdern: prdEarn,
                                              ),
        
                                              Expanded(
                                                // child: RefreshIndicator(
                                                //   onRefresh: () {
                                                //     return prdEarn.refreshData();
                                                //   },
                                                child: ListView.builder(
                                                  itemCount: prdEarn
                                                      .getearningtableData1
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    var keys = prdEarn
                                                        .getearningtableData1
                                                        .toList();
                                                    return
        
                                                        // AnimationConfiguration
                                                        //     .staggeredList(
                                                        //         position: i,
                                                        //         duration:
                                                        //             const Duration(
                                                        //                 milliseconds:
                                                        //                     400),
                                                        //         child: SlideAnimation(
                                                        //             verticalOffset:
                                                        //                 100.0,
                                                        //             child:
                                                        //                 FlipAnimation(
                                                        //               child:
                                                        Card(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    0.3),
                                                            elevation: 0.5,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.7,
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets
                                                                                .only(
                                                                          left: Screens.width(context) *
                                                                              0.01,
                                                                          right: Screens.width(context) *
                                                                              0.01,
                                                                          top: Screens.bodyheight(context) *
                                                                              0.01,
                                                                          bottom: Screens.bodyheight(context) *
                                                                              0.01,
                                                                        ),
                                                                        // width: Screens.width(
                                                                        //     context),
                                                                        child:
                                                                            Text(
                                                                          keys[i]
                                                                              .transDetails
                                                                              .toString(),
                                                                          style: theme
                                                                              .textTheme
                                                                              .bodyText1
                                                                              ?.copyWith(),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: Screens.bodyheight(
                                                                                context) *
                                                                            0.01,
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets
                                                                                .only(
                                                                          left: Screens.width(context) *
                                                                              0.01,
                                                                          right: Screens.width(context) *
                                                                              0.01,
                                                                          top: Screens.bodyheight(context) *
                                                                              0.001,
                                                                          bottom: Screens.bodyheight(context) *
                                                                              0.01,
                                                                        ),
                                                                        alignment:
                                                                            Alignment
                                                                                .centerLeft,
                                                                        child:
                                                                            Text(
                                                                          prdEarn
                                                                              .currentDate(),
                                                                          // config.currentDateOnly(),
                                                                          style: theme
                                                                              .textTheme
                                                                              .bodyText1
                                                                              ?.copyWith(),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.01,
                                                                ),
                                                                Container(
                                                                  alignment: Alignment
                                                                      .centerRight,
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.2,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Text(
                                                                    keys[i]
                                                                        .amount!
                                                                        .toStringAsFixed(
                                                                            2),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        theme
                                                                            .textTheme
                                                                            .titleMedium
                                                                            ?.copyWith(
                                                                                fontWeight: FontWeight.w600),
                                                                  ),
                                                                )
                                                              ],
                                                              //   ),
                                                              // )
                                                              // )
                                                            ));
                                                  },
                                                ),
                                              ),
                                              // ),
                                              // //       //  child:   createTable(theme,prdEarn)
                                              //         ),
        
                                              //    ),
                                              //  ),
                                              SizedBox(
                                                height:
                                                    Screens.bodyheight(context) *
                                                        0.025,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    prdEarn.loadDataClear();
        
        //  Get.toNamed( ConstantRoutes.earningsMoreData);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EarningMoreData(
                                                                  prdernctr:
                                                                      prdEarn,
                                                                )));
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: Screens.width(context),
                                                    child: Text("Load more"),
                                                  )),
                                            ],
                                          )),
                                    ));
                });
              }),
        ));
  }

  // // TargetTabController prdFUP
  // Widget createTable(ThemeData theme,EarningController prdearn ) {
  //   var earnKeyss = prdearn.getearningtableData1.toList();

  //   List<TableRow> rows = [];
  //   rows.add(TableRow(children: [
  //     Container(
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //       child: Text(
  //         "Date",
  //         style: theme.textTheme.bodyLarge?.copyWith(
  //           fontWeight: FontWeight.normal,
  //           color: Colors.white,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //     Container(
  //       // alignment: Alignment.center,
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //       child: Text(
  //         "Trans Details",
  //         style: theme.textTheme.bodyLarge?.copyWith(
  //           fontWeight: FontWeight.normal,
  //           color: Colors.white,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //     Container(
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //       child: Text(
  //         "Amount",
  //         style: theme.textTheme.bodyLarge
  //             ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),

  //   ]));
  //   print("Above Row");
  //   for (int i = 0; i < (earnKeyss.length); ++i) {
  //     // print("in Row");
  //     rows.add(TableRow(

  //       children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //         child: Text(

  //             config.currentDateOnly(),
  //           textAlign: TextAlign.left,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //         child: Text(

  //                '${earnKeyss[i].transDetails}',
  //           textAlign: TextAlign.left,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
  //         child: Text(
  //        earnKeyss[i].amount!.toStringAsFixed(2),
  //           textAlign: TextAlign.left,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),

  //     ]));

  //   }
  //   return Table(
  //     border: TableBorder(horizontalInside:  BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid)),
  //     columnWidths: {
  //     0: FlexColumnWidth(1.6), //date
  //     1: FlexColumnWidth(3), //trans
  //     2: FlexColumnWidth(1.5), //amnnt
  //     //ach
  //     // 4: FlexColumnWidth(1.1), //ach%
  //   }, children: rows);
  // }
}
