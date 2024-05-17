// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Constant/padings.dart';
import 'package:sellerkit/Controller/EarningController/EarningController.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import 'package:sellerkit/Widgets/Navi3.dart';

class EarningMoreData extends StatefulWidget {
  EarningMoreData({Key? key, required this.prdernctr}) : super(key: key);

  EarningController prdernctr;

  @override
  State<EarningMoreData> createState() => _EarningMoreDataState();
}

class _EarningMoreDataState extends State<EarningMoreData> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Paddings paddings = Paddings();
  final maxLines = 3;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            appBar: appbar("My Earnings", scaffoldKey, theme, context),
            drawer: drawer3(context),
            body: ChangeNotifierProvider<EarningController>(
                create: (context) => EarningController(),
                builder: (context, child) {
                  return Consumer<EarningController>(
                      builder: (BuildContext context, prdearn, Widget? child) {
                    return Container(
                      padding: paddings.padding2(context),
                      //  child:   RefreshIndicator(
                      //     onRefresh: () {
                      //       return prdearn.refreshData();
                      //     },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                              child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Screens.bodyheight(context) * 0.01,
                                horizontal: Screens.width(context) * 0.02),
                            decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            width: Screens.width(context),
                            child: Form(
                              key: prdearn.formkey[1],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.22,
                                        child: Text(
                                          "From Date",
                                          style: theme.textTheme.subtitle1
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.05,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width:
                                                  Screens.width(context) * 0.6,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              child:
                                                  prdearn.getfrmerrortextfield ==
                                                          true
                                                      ? Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                prdearn
                                                                    .showFromDate(
                                                                        context);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                width: Screens
                                                                        .width(
                                                                            context) *
                                                                    0.6,
                                                                height: Screens
                                                                        .bodyheight(
                                                                            context) *
                                                                    0.05,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      prdearn
                                                                          .dateController[
                                                                              2]
                                                                          .text,
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyText2
                                                                          ?.copyWith(
                                                                              color: Colors.white),
                                                                    ),
                                                                    Icon(
                                                                        Icons
                                                                            .date_range_outlined,
                                                                        color: Colors
                                                                            .grey),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : TextFormField(
                                                          onTap: () {
                                                            prdearn
                                                                .showFromDate(
                                                                    context);
                                                          },
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              // prdearn.geterrortextfield==true;
                                                              return "Choose From Date";
                                                            }
                                                            return null;
                                                          },
                                                          readOnly: true,
                                                          controller: prdearn
                                                              .dateController[2],
                                                          style: theme.textTheme
                                                              .bodyText2
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .white),
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle: theme
                                                                .textTheme
                                                                .bodyText2
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .white),
                                                            suffixIcon: Icon(
                                                                Icons
                                                                    .date_range_outlined,
                                                                color: Colors
                                                                    .grey),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                          ),
                                                        )),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Visibility(
                                                visible: prdearn
                                                    .getfrmerrortextfield,
                                                child: Text(
                                                  "Choose From Date",
                                                  style: theme
                                                      .textTheme.bodyText2
                                                      ?.copyWith(
                                                          color: Colors.white),
                                                )),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          Screens.bodyheight(context) * 0.01),
                                  Row(
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.22,
                                        child: Text(
                                          "To Date",
                                          style: theme.textTheme.subtitle1
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.05,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width:
                                                  Screens.width(context) * 0.6,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              child:
                                                  prdearn.gettoerrortextfield ==
                                                          true
                                                      ? Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                prdearn
                                                                    .showToDate(
                                                                        context);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                width: Screens
                                                                        .width(
                                                                            context) *
                                                                    0.6,
                                                                height: Screens
                                                                        .bodyheight(
                                                                            context) *
                                                                    0.05,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      prdearn
                                                                          .dateController[
                                                                              3]
                                                                          .text,
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyText2
                                                                          ?.copyWith(
                                                                              color: Colors.white),
                                                                    ),
                                                                    Icon(
                                                                        Icons
                                                                            .date_range_outlined,
                                                                        color: Colors
                                                                            .grey),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : TextFormField(
                                                          onTap: () {
                                                            prdearn.showToDate(
                                                                context);
                                                          },
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              prdearn.gettoerrortextfield ==
                                                                  true;
                                                              return "Choose To Date";
                                                            }
                                                            return null;
                                                          },
                                                          readOnly: true,
                                                          controller: prdearn
                                                              .dateController[3],
                                                          style: theme.textTheme
                                                              .bodyText2
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .white),
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle: theme
                                                                .textTheme
                                                                .bodyText2
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .white),
                                                            suffixIcon: Icon(
                                                                Icons
                                                                    .date_range_outlined,
                                                                color: Colors
                                                                    .grey),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                          ),
                                                        )),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Visibility(
                                                visible:
                                                    prdearn.gettoerrortextfield,
                                                child: Text(
                                                  "Choose To Date",
                                                  style: theme
                                                      .textTheme.bodyText2
                                                      ?.copyWith(
                                                          color: Colors.white),
                                                )),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          Screens.bodyheight(context) * 0.04),
                                  Container(
                                    width: Screens.width(context) * 0.9,
                                    height: Screens.bodyheight(context) * 0.06,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: MaterialButton(
                                        child: prdearn.getbtnLoadingProgress ==
                                                true
                                            ? CircularProgressIndicator(
                                                color: theme.primaryColor)
                                            : Text(
                                                'Load Data',
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                  color: theme.primaryColor,
                                                ),
                                              ),
                                        onPressed: () {
                                          prdearn.loadBtnClick();
                                        }),
                                  ),

                                  //  CustomSpinkitdButton(
                                  //  onTap: () {
                                  //    prdearn.loadBtnClick();
                                  //  },
                                  //  width: Screens.width(context) * 0.35,
                                  //  height: Screens.bodyheight(context) * 0.06,
                                  //  color: Colors.white,
                                  //    label:
                                  //    'Load Data',
                                  //    labelLoading: "Load Data",
                                  //    textcolor: theme.primaryColor,
                                  //    child: prdearn. getbtnLoadingProgress==false?  Text('Load Data'):CircularProgressIndicator(),
                                  //  )
                                ],
                              ),
                            ),
                          )),
                          SizedBox(height: Screens.bodyheight(context) * 0.02),
                          Expanded(
                            // child: RefreshIndicator(
                            //   onRefresh: () {
                            //     return prdearn.refreshData();
                            //   },
                            child: ListView.builder(
                              itemCount: prdearn.getearningloadData.length,
                              itemBuilder: (BuildContext context, int i) {
                                var keys = prdearn.getearningloadData.toList();
                                return

                                    // AnimationConfiguration
                                    //           .staggeredList(
                                    //               position: i,
                                    //               duration:
                                    //                   const Duration(
                                    //                       milliseconds:
                                    //                           400),
                                    //               child: SlideAnimation(
                                    //                   verticalOffset:
                                    //                       100.0,
                                    //                   child:
                                    //                       FlipAnimation(
                                    //                     child:
                                    Card(
                                  margin: EdgeInsets.all(0.3),
                                  elevation: 0.5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.7,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: Screens.width(context) *
                                                    0.01,
                                                right: Screens.width(context) *
                                                    0.01,
                                                top: Screens.bodyheight(
                                                        context) *
                                                    0.01,
                                                bottom: Screens.bodyheight(
                                                        context) *
                                                    0.01,
                                              ),
                                              child: Text(
                                                keys[i].transDetails.toString(),
                                                style: theme.textTheme.bodyText1
                                                    ?.copyWith(),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: Screens.width(context) *
                                                    0.01,
                                                right: Screens.width(context) *
                                                    0.01,
                                                top: Screens.bodyheight(
                                                        context) *
                                                    0.001,
                                                bottom: Screens.bodyheight(
                                                        context) *
                                                    0.01,
                                              ),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                prdearn.loadedDateOnly(
                                                    keys[i].date!.toString()),
                                                style: theme.textTheme.bodyText1
                                                    ?.copyWith(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: Screens.width(context) * 0.2,
                                        decoration: BoxDecoration(

                                            // color: Colors.red,

                                            ),
                                        child: Text(
                                          keys[i].amount!.toStringAsFixed(2),
                                          textAlign: TextAlign.end,
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                  //         )
                                  //         )
                                  //  )
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      // )
                    );
                  });
                })));
  }

  // // TargetTabController prdFUP
  // Widget createEarningTable(ThemeData theme, EarningController prdearntbl) {
  //   var earnLoadKeyss = prdearntbl.getearningloadData.toList();
  //   print("load data length:${earnLoadKeyss.length}");
  //   List<TableRow> earningRows = [];

  //   earningRows.add(TableRow(children: [
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
  //   for (int i = 0; i < (earnLoadKeyss.length); ++i) {
  //     print("in Row");
  //     earningRows.add(TableRow(children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //         child: Text(
  //           prdearntbl.loadedDateOnly(earnLoadKeyss[i].date!.toString()),
  //         // earnLoadKeyss[i].date!.toString(),
  //           textAlign: TextAlign.left,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //         child: Text(
  //           '${earnLoadKeyss[i].transDetails}',
  //           textAlign: TextAlign.left,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
  //         child: Text(
  //           earnLoadKeyss[i].amount!.toStringAsFixed(2),
  //           textAlign: TextAlign.left,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //     ]));
  //   }
  //   return Table(
  //       border: TableBorder(
  //           horizontalInside: BorderSide(
  //               width: 1, color: Colors.grey, style: BorderStyle.solid)),
  //       columnWidths: {
  //         0: FlexColumnWidth(1.6), //date
  //         1: FlexColumnWidth(3), //trans
  //         2: FlexColumnWidth(1.5), //amnnt
  //         //ach
  //         // 4: FlexColumnWidth(1.1), //ach%
  //       },
  //       children: earningRows);
  // }
}
