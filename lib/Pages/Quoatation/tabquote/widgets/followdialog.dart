// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Models/QuoteModel/quotesgetallModel.dart';
import 'package:sellerkit/Pages/Quoatation/tabquote/widgets/pdfviewdetail.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../Controller/QuotationController/tabquotescontroller.dart';
//import 'package:timelines/timelines.dart';

class FollowDialog extends StatefulWidget {
  FollowDialog({Key? key, required this.index, this.leadOpenAllData})
      : super(key: key);
  final int index;
  final GetAllQuotesData? leadOpenAllData;
  @override
  State<FollowDialog> createState() => _FollowDialogState();
}

class _FollowDialogState extends State<FollowDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (QuotestabController.comeFromEnq == -1 &&
      //     QuotestabController.isanyExcep == 0) {
      //   context.read<QuotestabController>().resetValuesIS1();
      //   context.read<QuotestabController>().opendialogbool = false;
      // }
      // else if((QuotestabController.comeFromEnq==-2)){
      // }
      // else{
      //   context.read<QuotestabController>().resetValuesISnot1();
      // }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // Provider.of<QuotestabController>(context).dispose();
    //  context.read<QuotestabController>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: //UpdateFollowup(context, theme),
          (context.watch<QuotestabController>().getupdateFollowUpDialog == false &&
                  context.watch<QuotestabController>().getleadForwarddialog ==
                      false &&
                  context.watch<QuotestabController>().getleadLoadingdialog ==
                      false &&
                  context.watch<QuotestabController>().getviewDetailsdialog ==
                      false &&
                  context
                      .watch<QuotestabController>()
                      .getforwardSuccessMsg
                      .isEmpty &&
                  context.watch<QuotestabController>().getisSameBranch == true)
              ? CallDialog(context, theme)
              : (context.watch<QuotestabController>().getupdateFollowUpDialog == false &&
                      context.watch<QuotestabController>().getleadForwarddialog ==
                          false &&
                      context.watch<QuotestabController>().getleadLoadingdialog ==
                          false &&
                      context.watch<QuotestabController>().getviewDetailsdialog ==
                          true &&
                      context
                          .watch<QuotestabController>()
                          .getforwardSuccessMsg
                          .isEmpty &&
                      context.watch<QuotestabController>().getisSameBranch ==
                          true)
                  ? detailsDialog(context, theme)
                  :
                  //
                  (context.watch<QuotestabController>().getupdateFollowUpDialog == false &&
                          context.watch<QuotestabController>().getleadForwarddialog ==
                              false &&
                          context.watch<QuotestabController>().getleadLoadingdialog ==
                              false &&
                          context.watch<QuotestabController>().getviewDetailsdialog ==
                              true &&
                          context
                              .watch<QuotestabController>()
                              .getforwardSuccessMsg
                              .isEmpty &&
                          context.watch<QuotestabController>().getisSameBranch ==
                              false)
                      ? detailsDialogLead(context, theme)

                      //
                      : (context.watch<QuotestabController>().getupdateFollowUpDialog == false &&
                              context.watch<QuotestabController>().getleadForwarddialog ==
                                  true &&
                              context.watch<QuotestabController>().getleadLoadingdialog ==
                                  false &&
                              context.watch<QuotestabController>().getviewDetailsdialog ==
                                  false &&
                              context
                                  .watch<QuotestabController>()
                                  .getforwardSuccessMsg
                                  .isEmpty &&
                              context.watch<QuotestabController>().getisSameBranch ==
                                  true)
                          ? forwardDialog(context, theme)
                          : (context.watch<QuotestabController>().getupdateFollowUpDialog == false &&
                                  context.watch<QuotestabController>().getleadForwarddialog ==
                                      true &&
                                  context
                                          .watch<QuotestabController>()
                                          .getleadLoadingdialog ==
                                      true &&
                                  context
                                          .watch<QuotestabController>()
                                          .getviewDetailsdialog ==
                                      false &&
                                  context
                                      .watch<QuotestabController>()
                                      .getforwardSuccessMsg
                                      .isEmpty &&
                                  context.watch<QuotestabController>().getisSameBranch ==
                                      true)
                              ? loadingDialog(context)
                              : (context.watch<QuotestabController>().getupdateFollowUpDialog == false &&
                                      context.watch<QuotestabController>().getleadForwarddialog == true &&
                                      context.watch<QuotestabController>().getleadLoadingdialog == false &&
                                      context.watch<QuotestabController>().getviewDetailsdialog == false &&
                                      context.watch<QuotestabController>().getforwardSuccessMsg.isNotEmpty &&
                                      context.watch<QuotestabController>().getisSameBranch == true)
                                  ? displayDialog(context, theme)
                                  : UpdateFollowup(context, theme),
    );
  }

  Container loadingDialog(BuildContext context) {
    return Container(
        width: Screens.width(context),
        height: Screens.bodyheight(context) * 0.4,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ));
  }

  Container displayDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      // height: Screens.bodyheight(context) * 0.6,
      // padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(""),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Alert",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  context
                          .read<QuotestabController>()
                          .getforwardSuccessMsg
                          .contains("Success")
                      ? "Success..!!"
                      : ' "Error..!!"',
                  style: context
                          .watch<QuotestabController>()
                          .getforwardSuccessMsg
                          .contains("Success")
                      ? theme.textTheme.headline6?.copyWith(color: Colors.green)
                      : theme.textTheme.headline6?.copyWith(color: Colors.red),
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Text(
                  context.watch<QuotestabController>().getforwardSuccessMsg,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1,
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Container(
                  width: Screens.width(context) * 0.26,
                  height: Screens.bodyheight(context) * 0.06,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
        ],
      ),
    );
  }

  Stack displayDialog2(BuildContext context, ThemeData theme) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          width: Screens.width(context),
          height: Screens.bodyheight(context) * 0.4,
          color: Colors.red,
        ),
        Positioned(
          top: Screens.bodyheight(context) * 0.1,
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.2,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Container UpdateFollowup(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      child: 
      SingleChildScrollView(
        child: Column(
           mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
               width: Screens.width(context),
                      //  height: Screens.bodyheight(context)*0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.only(
                        left: Screens.width(context) * 0.05,
                        right: Screens.width(context) * 0.05,
                        top: Screens.bodyheight(context) * 0.03,
                        //  bottom: Screens.bodyheight(context)*0.03,
                      ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                                           
                                            children: [
                                            SizedBox(
                                                height: Screens.bodyheight(context) * 0.001,
                                              ),
                                              
                                               Container(
                                                  width: Screens.width(context),
                                            // height: Screens.,
                                            padding:
                                                EdgeInsets.only(top: 1, left: 10, right: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey),
                                                borderRadius: BorderRadius.circular(8)),
                                                 child: DropdownButton(
                                                                               hint: Text(
                                                  context
                                                      .watch<QuotestabController>()
                                                      .gethinttextforcancel!,
                                                  style: theme.textTheme.bodyText2?.copyWith(
                                                      color: context
                                                              .watch<QuotestabController>()
                                                              .gethinttextforcancel!
                                                              .contains(" *")
                                                          ? Colors.red
                                                          : Colors.grey),
                                                                               ),
                                                                               value: context
                                                    .read<QuotestabController>()
                                                    .valuecancelStatus,
                                                                               //dropdownColor:Colors.green,
                                                                               icon: Icon(Icons.arrow_drop_down),
                                                                               iconSize: 30,
                                                                               style: TextStyle(
                                                    color: Colors.black, fontSize: 16),
                                                                               isExpanded: true,
                                                                               onChanged: (val) {
                                                  setState(() {
                                                    context
                                                        .read<QuotestabController>()
                                                        .choosedcancelStatus(val.toString());
                                                  });
                                                                               },
                                                                               items: context
                                                    .read<QuotestabController>()
                                                    .orderdialogdata
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                      // ignore: unnecessary_brace_in_string_interps
                                                      value: "${e.code}",
                                                      child: Container(
                                                          // height: Screens.bodyheight(context)*0.1,
                                                          child: Text("${e.name}")));
                                                                               }).toList(),
                                                                             ),
                                               ),
              SizedBox(
                                                height: Screens.bodyheight(context) * 0.01,
                                              ),
                                                Container(
                                      child: Text(
                                        context
                                            .watch<QuotestabController>()
                                            .getfeedbackcancel!, // "Feedback",
                                        style: theme.textTheme.bodyText2?.copyWith(
                                          color: context
                                                  .watch<QuotestabController>()
                                                  .getfeedbackcancel!
                                                  .contains(" *")
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                                height: Screens.bodyheight(context) * 0.01,
                                              ),
                                               TextFormField(
                                      controller:
                                          context.read<QuotestabController>().mycontroller[5],
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey[400]!),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]!, width: 2.0),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                 
                                          ],),
                  ],
                ),
              ),
            ),
               SizedBox(
                                                height: Screens.bodyheight(context) * 0.01,
                                              ),
         Container(
                            width: Screens.width(context),
                            height: Screens.bodyheight(context) * 0.06,
                            child: ElevatedButton(
                                onPressed: () {
                                  // if (OrderTabController.comeFromEnq == -1) {
                                    context.read<QuotestabController>().clickLeadSaveBtn(
                                        widget.leadOpenAllData!.FollowupEntry.toString(),
                                        widget.leadOpenAllData!.OrderDocEntry.toString());
                                  
                                },
                                style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(
                                      // fontSize: 12,
                                      ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )), //Radius.circular(6)
                                ),
                                child:Text("Confirm Cancel")),
                          ),
          ],
        ),
      ),
                            
//       SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//                 width: Screens.width(context),
//                 //  height: Screens.bodyheight(context)*0.5,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: EdgeInsets.only(
//                   left: Screens.width(context) * 0.05,
//                   right: Screens.width(context) * 0.05,
//                   top: Screens.bodyheight(context) * 0.03,
//                   //  bottom: Screens.bodyheight(context)*0.03,
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),
//                       context
//                                   .read<QuotestabController>()
//                                   .getcaseStatusSelected ==
//                               'Won'
//                           ? Column(
//                               children: [
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                                 TextFormField(
//                                   controller: context
//                                       .read<QuotestabController>()
//                                       .mycontroller[0],
//                                   decoration: InputDecoration(
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.grey[400]!),
//                                         borderRadius: BorderRadius.circular(6),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: Colors.grey[400]!,
//                                         ),
//                                         borderRadius: BorderRadius.circular(6),
//                                       ),
//                                       hintText: context
//                                           .read<QuotestabController>()
//                                           .getorderBillRefer!,
//                                       hintStyle:
//                                           theme.textTheme.bodyText2?.copyWith(
//                                         color: context
//                                                 .read<QuotestabController>()
//                                                 .getorderBillRefer!
//                                                 .contains(" *")
//                                             ? Colors.red
//                                             : Colors.grey,
//                                         // fontSize: 14
//                                       ),
//                                       // TextStyle(
//                                       //     color: context
//                                       //             .read<QuotestabController>()
//                                       //             .getorderBillRefer!
//                                       //             .contains("*")
//                                       //         ? Colors.red
//                                       //         : Colors.black),
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical: 10, horizontal: 10)),
//                                 ),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                                 //AttachMents

//                                 Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8),
//                                       border:
//                                           Border.all(color: Colors.grey[400]!)),
//                                   padding: EdgeInsets.only(
//                                       top: Screens.padingHeight(context) * 0.01,
//                                       left:
//                                           Screens.padingHeight(context) * 0.01,
//                                       bottom:
//                                           Screens.padingHeight(context) * 0.015,
//                                       right:
//                                           Screens.padingHeight(context) * 0.01),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text('Attachment',
//                                               style: theme.textTheme.bodyText2
//                                                   ?.copyWith(
//                                                       color: context
//                                                                   .read<
//                                                                       QuotestabController>()
//                                                                   .fileValidation ==
//                                                               true
//                                                           ? Colors.red
//                                                           : Colors.grey)),
//                                           Row(
//                                             children: [
//                                               Container(
//                                                   // alignment: Alignment.center,
//                                                   height: Screens.padingHeight(
//                                                           context) *
//                                                       0.06,
//                                                   width:
//                                                       Screens.width(context) *
//                                                           0.13,
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               6),
//                                                       color: context
//                                                                   .read<
//                                                                       QuotestabController>()
//                                                                   .fileValidation ==
//                                                               true
//                                                           ? Colors.red
//                                                           : theme.primaryColor
//                                                       // shape: BoxShape
//                                                       //     .circle
//                                                       ),
//                                                   child: Center(
//                                                     child: IconButton(
//                                                         onPressed: context
//                                                                     .read<
//                                                                         QuotestabController>()
//                                                                     .files
//                                                                     .length >
//                                                                 2
//                                                             ? null
//                                                             : () {
//                                                                 setState(() {
//                                                                   log("files length" +
//                                                                       context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .files
//                                                                           .length
//                                                                           .toString());
//                                                                   // showtoast();
//                                                                   if (context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .files
//                                                                           .length <=
//                                                                       1) {
//                                                                     setState(
//                                                                         () {
//                                                                       context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .imagetoBinary(
//                                                                               ImageSource.camera);
//                                                                       context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .fileValidation = false;
//                                                                     });
//                                                                   } else {
//                                                                     print(
//                                                                         "obAAAAAject");
//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .showtoast();
//                                                                   }
//                                                                 });
//                                                               },
//                                                         icon: Icon(
//                                                           Icons.photo_camera,
//                                                           color: Colors.white,
//                                                         )),
//                                                   )),
//                                               SizedBox(
//                                                 width: Screens.width(context) *
//                                                     0.02,
//                                               ),

//                                               //old
//                                               Container(
//                                                   // alignment: Alignment.center,
//                                                   height: Screens.padingHeight(
//                                                           context) *
//                                                       0.06,
//                                                   width:
//                                                       Screens.width(context) *
//                                                           0.13,
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               6),
//                                                       color: context
//                                                                   .read<
//                                                                       QuotestabController>()
//                                                                   .fileValidation ==
//                                                               true
//                                                           ? Colors.red
//                                                           : theme.primaryColor
//                                                       // shape: BoxShape
//                                                       //     .circle
//                                                       ),
//                                                   child: Center(
//                                                     child: IconButton(
//                                                         onPressed: context
//                                                                     .read<
//                                                                         QuotestabController>()
//                                                                     .files
//                                                                     .length >
//                                                                 2
//                                                             ? null
//                                                             : () {
//                                                                 setState(() {
//                                                                   log("files222 length" + context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .files.length.toString());
//                                                                   // showtoast();
//                                                                   if (context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .files
//                                                                           .length <=
//                                                                       1) {
//                                                                     setState(
//                                                                         () {
//                                                                       context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .selectattachment();

//                                                                       context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .fileValidation = false;
//                                                                     });
//                                                                   } else {
//                                                                     print(
//                                                                         "obAAAAAject");

//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .showtoast();
//                                                                   }
//                                                                 });
//                                                               },
//                                                         icon: Icon(
//                                                           Icons.attach_file,
//                                                           color: Colors.white,
//                                                         )),
//                                                   )),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),

//                                 context.read<QuotestabController>().files == null
//                                     ? Container(
//                                         height:
//                                             Screens.padingHeight(context) * 0.3,
//                                         padding: EdgeInsets.only(
//                                           top: Screens.padingHeight(context) *
//                                               0.001,
//                                           right: Screens.padingHeight(context) *
//                                               0.015,
//                                           left: Screens.padingHeight(context) *
//                                               0.015,
//                                           bottom:
//                                               Screens.padingHeight(context) *
//                                                   0.015,
//                                         ),
//                                         child: Container(
//                                             alignment: Alignment.center,
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Center(
//                                                     child: Text(
//                                                   "No Files Selected",
//                                                   style: theme
//                                                       .textTheme.bodyText1!
//                                                       .copyWith(
//                                                           color: context
//                                                                       .read<
//                                                                           QuotestabController>()
//                                                                       .fileValidation ==
//                                                                   true
//                                                               ? Colors.red
//                                                               : Colors.green),
//                                                 )),
//                                                 Icon(
//                                                   Icons.file_present_outlined,
//                                                   color: theme.primaryColor,
//                                                 )
//                                               ],
//                                             )))
//                                     : Container(
//                                         height: context
//                                                     .read<QuotestabController>()
//                                                     .files
//                                                     .length ==
//                                                 0
//                                             ? Screens.padingHeight(context) *
//                                                 0.0
//                                             : Screens.padingHeight(context) *
//                                                 0.3,
//                                         padding: EdgeInsets.only(
//                                           top: Screens.padingHeight(context) *
//                                               0.001,
//                                           right: Screens.padingHeight(context) *
//                                               0.005,
//                                           left: Screens.padingHeight(context) *
//                                               0.005,
//                                           bottom:
//                                               Screens.padingHeight(context) *
//                                                   0.015,
//                                         ),
//                                         child: ListView.builder(
//                                             itemCount: context
//                                                 .read<QuotestabController>()
//                                                 .files
//                                                 .length,
//                                             itemBuilder:
//                                                 (BuildContext context, int i) {
//                                               if (context
//                                                   .read<QuotestabController>()
//                                                   .files[i]
//                                                   .path
//                                                   .split('/')
//                                                   .last
//                                                   .contains("png")) {
//                                                 return Container(
//                                                     child: Column(children: [
//                                                   SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                   Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Container(
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.09,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: Center(
//                                                                 child: Image.asset(
//                                                                     "Assets/img.jpg"))),
//                                                         Container(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     10),
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.6,
//                                                             // height: Screens.padingHeight(context) * 0.06,
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Text(
//                                                               context
//                                                                   .watch<
//                                                                       QuotestabController>()
//                                                                   .files[i]
//                                                                   .path
//                                                                   .split('/')
//                                                                   .last,
//                                                               // overflow: TextOverflow.ellipsis,
//                                                             )),
//                                                         Container(
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.1,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: IconButton(
//                                                                 onPressed: () {
//                                                                   setState(() {
//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .files
//                                                                         .removeAt(
//                                                                             i);
//                                                                             context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .filedata
//                                                                         .removeAt(
//                                                                             i);
//                                                                   });
//                                                                 },
//                                                                 icon: Icon(
//                                                                   Icons
//                                                                       .cancel_rounded,
//                                                                   color: Colors
//                                                                       .grey,
//                                                                 )))
//                                                       ])
//                                                 ])
//                                                     // )
//                                                     );
//                                               } else if (context
//                                                   .read<QuotestabController>()
//                                                   .files[i]
//                                                   .path
//                                                   .split('/')
//                                                   .last
//                                                   .contains("jp")) {
//                                                 return Container(
//                                                     child: Column(children: [
//                                                   SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                   Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Container(
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.09,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: Center(
//                                                                 child: Image.asset(
//                                                                     "Assets/img.jpg"))),
//                                                         Container(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     10),
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.6,
//                                                             // height: Screens.padingHeight(context) * 0.06,
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Text(
//                                                               context
//                                                                   .watch<
//                                                                       QuotestabController>()
//                                                                   .files[i]
//                                                                   .path
//                                                                   .split('/')
//                                                                   .last,
//                                                             )),
//                                                         Container(
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.1,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: IconButton(
//                                                                 onPressed: () {
//                                                                   setState(() {
//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .files
//                                                                         .removeAt(
//                                                                             i);
//                                                                             context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .filedata
//                                                                         .removeAt(
//                                                                             i);
//                                                                   });
//                                                                 },
//                                                                 icon: Icon(
//                                                                   Icons
//                                                                       .cancel_rounded,
//                                                                   color: Colors
//                                                                       .grey,
//                                                                 )))
//                                                       ])
//                                                 ])
//                                                     // )
//                                                     );
//                                               } else if (context
//                                                   .read<QuotestabController>()
//                                                   .files[i]
//                                                   .path
//                                                   .split('/')
//                                                   .last
//                                                   .contains("pdf")) {
//                                                 return Container(
//                                                     child: Column(children: [
//                                                   SizedBox(
//                                                     height:
//                                                         Screens.padingHeight(
//                                                                 context) *
//                                                             0.01,
//                                                   ),
//                                                   Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Container(
//                                                           decoration:
//                                                               BoxDecoration(),
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.09,
//                                                           height: Screens
//                                                                   .padingHeight(
//                                                                       context) *
//                                                               0.06,
//                                                           child: Center(
//                                                               child: Image.asset(
//                                                                   "Assets/PDFimg.png")),
//                                                         ),
//                                                         Container(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     10),
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.6,
//                                                             // height: Screens.padingHeight(context) * 0.06,
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Text(
//                                                               context
//                                                                   .watch<
//                                                                       QuotestabController>()
//                                                                   .files[i]
//                                                                   .path
//                                                                   .split('/')
//                                                                   .last,
//                                                             )),
//                                                         Container(
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.1,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: IconButton(
//                                                                 onPressed: () {
//                                                                   setState(() {
//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .files
//                                                                         .removeAt(
//                                                                             i);
//                                                                             context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .filedata
//                                                                         .removeAt(
//                                                                             i);
//                                                                   });
//                                                                 },
//                                                                 icon: Icon(
//                                                                   Icons
//                                                                       .cancel_rounded,
//                                                                   color: Colors
//                                                                       .grey,
//                                                                 )))
//                                                       ])
//                                                 ]));
//                                               } else if (context
//                                                   .read<QuotestabController>()
//                                                   .files[i]
//                                                   .path
//                                                   .split('/')
//                                                   .last
//                                                   .contains("xlsx")) {
//                                                 return Container(
//                                                     child: Column(children: [
//                                                   SizedBox(
//                                                     height:
//                                                         Screens.padingHeight(
//                                                                 context) *
//                                                             0.01,
//                                                   ),
//                                                   Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Container(
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.09,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: Center(
//                                                                 child: Image.asset(
//                                                                     "Assets/xls.png"))),
//                                                         Container(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     10),
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.6,
//                                                             // height: Screens.padingHeight(context) * 0.06,
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Text(
//                                                               context
//                                                                   .read<
//                                                                       QuotestabController>()
//                                                                   .files[i]
//                                                                   .path
//                                                                   .split('/')
//                                                                   .last,
//                                                             )),
//                                                         Container(
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.1,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: IconButton(
//                                                                 onPressed: () {
//                                                                   setState(() {
//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .files
//                                                                         .removeAt(
//                                                                             i);
//                                                                             context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .filedata
//                                                                         .removeAt(
//                                                                             i);
//                                                                   });
//                                                                 },
//                                                                 icon: Icon(
//                                                                   Icons
//                                                                       .cancel_rounded,
//                                                                   color: Colors
//                                                                       .grey,
//                                                                 )))
//                                                       ])
//                                                 ])
//                                                     // )
//                                                     );
//                                               }
//                                               return Container(
//                                                   child: Column(children: [
//                                                 SizedBox(
//                                                   height: Screens.padingHeight(
//                                                           context) *
//                                                       0.01,
//                                                 ),
//                                                 Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Container(
//                                                           decoration:
//                                                               BoxDecoration(),
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.09,
//                                                           height: Screens
//                                                                   .padingHeight(
//                                                                       context) *
//                                                               0.06,
//                                                           child: Center(
//                                                               child: Image.asset(
//                                                                   "Assets/txt.png"))),
//                                                       Container(
//                                                           padding:
//                                                               EdgeInsets.all(
//                                                                   10),
//                                                           decoration:
//                                                               BoxDecoration(),
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.6,
//                                                           // height: Screens.padingHeight(context) * 0.06,
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Text(
//                                                             context
//                                                                 .watch<
//                                                                     QuotestabController>()
//                                                                 .files[i]
//                                                                 .path
//                                                                 .split('/')
//                                                                 .last,
//                                                           )),
//                                                       Container(
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.1,
//                                                           height: Screens
//                                                                   .padingHeight(
//                                                                       context) *
//                                                               0.06,
//                                                           child: IconButton(
//                                                               onPressed: () {
//                                                                 setState(() {
//                                                                   context
//                                                                       .read<
//                                                                           QuotestabController>()
//                                                                       .files
//                                                                       .removeAt(
//                                                                           i);
//                                                                           context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .filedata
//                                                                         .removeAt(
//                                                                             i);
//                                                                 });
//                                                               },
//                                                               icon: Icon(
//                                                                 Icons
//                                                                     .cancel_rounded,
//                                                                 color:
//                                                                     Colors.grey,
//                                                               )))
//                                                     ])
//                                               ]));
//                                             })),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                         child: Text(
//                                       context
//                                           .watch<QuotestabController>()
//                                           .getorderBillDate!, // "Next Follow up",
//                                       style:
//                                           theme.textTheme.bodyText2?.copyWith(
//                                         color: context
//                                                 .watch<QuotestabController>()
//                                                 .getorderBillDate!
//                                                 .contains(" *")
//                                             ? Colors.red
//                                             : Colors.grey,
//                                       ), // fontSize: 12
//                                     )),
//                                     InkWell(
//                                       onTap: context
//                                                   .read<QuotestabController>()
//                                                   .getcaseStatusSelected ==
//                                               'Won'
//                                           ? () {
//                                               context
//                                                   .read<QuotestabController>()
//                                                   .showFollowupWonDate(context);
//                                             }
//                                           : null,
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal:
//                                                 Screens.width(context) * 0.015),
//                                         width: Screens.width(context) * 0.4,
//                                         height:
//                                             Screens.bodyheight(context) * 0.05,
//                                         decoration: BoxDecoration(
//                                             border:
//                                                 Border.all(color: Colors.grey),
//                                             borderRadius:
//                                                 BorderRadius.circular(4)),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Container(
//                                               width:
//                                                   Screens.width(context) * 0.24,
//                                               // color: Colors.red,
//                                               child: Text(
//                                                 context
//                                                     .watch<QuotestabController>()
//                                                     .getnextWonFD,
//                                                 // context.read<QuotestabController>().getnextFD,
//                                                 style: theme.textTheme.bodyText2
//                                                     ?.copyWith(), //fontSize: 12
//                                               ),
//                                             ),
//                                             Container(
//                                               alignment: Alignment.centerRight,
//                                               width:
//                                                   Screens.width(context) * 0.12,
//                                               // color: Colors.red,
//                                               child: Icon(
//                                                 Icons.calendar_month,
//                                                 // size: Screens.,
//                                                 color: theme.primaryColor,
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                               ],
//                             )
//                           : context
//                                   .read<QuotestabController>()
//                                   .getcaseStatusSelected ==
//                               'Invoice'?
//                                Column(
//                               children: [
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                                 TextFormField(
//                                   controller: context
//                                       .read<QuotestabController>()
//                                       .mycontroller[1],
//                                   decoration: InputDecoration(
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.grey[400]!),
//                                         borderRadius: BorderRadius.circular(6),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: Colors.grey[400]!,
//                                         ),
//                                         borderRadius: BorderRadius.circular(6),
//                                       ),
//                                       hintText: context
//                                           .read<QuotestabController>()
//                                           .getorderInvBillRefer!,
//                                       hintStyle:
//                                           theme.textTheme.bodyText2?.copyWith(
//                                         color: context
//                                                 .read<QuotestabController>()
//                                                 .getorderInvBillRefer!
//                                                 .contains(" *")
//                                             ? Colors.red
//                                             : Colors.grey,
//                                         // fontSize: 14
//                                       ),
//                                       // TextStyle(
//                                       //     color: context
//                                       //             .read<QuotestabController>()
//                                       //             .getorderBillRefer!
//                                       //             .contains("*")
//                                       //         ? Colors.red
//                                       //         : Colors.black),
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical: 10, horizontal: 10)),
//                                 ),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),

//                                 TextFormField(
//                                   controller: context
//                                       .read<QuotestabController>()
//                                       .mycontroller[2],
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.grey[400]!),
//                                         borderRadius: BorderRadius.circular(6),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: Colors.grey[400]!,
//                                         ),
//                                         borderRadius: BorderRadius.circular(6),
//                                       ),
//                                       hintText: context
//                                           .read<QuotestabController>()
//                                           .getorderInvvalue!,
//                                       hintStyle:
//                                           theme.textTheme.bodyText2?.copyWith(
//                                         color: context
//                                                 .read<QuotestabController>()
//                                                 .getorderInvvalue!
//                                                 .contains(" *")
//                                             ? Colors.red
//                                             : Colors.grey,
//                                         // fontSize: 14
//                                       ),
//                                       // TextStyle(
//                                       //     color: context
//                                       //             .read<QuotestabController>()
//                                       //             .getorderBillRefer!
//                                       //             .contains("*")
//                                       //         ? Colors.red
//                                       //         : Colors.black),
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical: 10, horizontal: 10)),
//                                 ),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                                 //AttachMents

//                                 Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8),
//                                       border: Border.all(color: Colors.grey)),
//                                   padding: EdgeInsets.only(
//                                       top: Screens.padingHeight(context) * 0.01,
//                                       left:
//                                           Screens.padingHeight(context) * 0.01,
//                                       bottom:
//                                           Screens.padingHeight(context) * 0.015,
//                                       right:
//                                           Screens.padingHeight(context) * 0.01),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text('Attachment',
//                                               style: theme.textTheme.bodyText2
//                                                   ?.copyWith(
//                                                       color: context
//                                                                   .read<
//                                                                       QuotestabController>()
//                                                                   .fileValidation ==
//                                                               true
//                                                           ? Colors.red
//                                                           : Colors.grey)),
//                                           Row(
//                                             children: [
//                                               Container(
//                                                   // alignment: Alignment.center,
//                                                   height: Screens.padingHeight(
//                                                           context) *
//                                                       0.06,
//                                                   width:
//                                                       Screens.width(context) *
//                                                           0.13,
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               6),
//                                                       color: context
//                                                                   .read<
//                                                                       QuotestabController>()
//                                                                   .fileValidation ==
//                                                               true
//                                                           ? Colors.red
//                                                           : theme.primaryColor
//                                                       // shape: BoxShape
//                                                       //     .circle
//                                                       ),
//                                                   child: Center(
//                                                     child: IconButton(
//                                                         onPressed: context
//                                                                     .read<
//                                                                         QuotestabController>()
//                                                                     .files
//                                                                     .length >
//                                                                 2
//                                                             ? null
//                                                             : () {
//                                                                 setState(() {
//                                                                   // log("files length" +
//                                                                   //     context
//                                                                   //         .read<
//                                                                   //             QuotestabController>()
//                                                                   //         .files
//                                                                   //         .length
//                                                                   //         .toString());
//                                                                   // showtoast();
//                                                                   if (context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .files
//                                                                           .length <=
//                                                                       1) {
//                                                                     setState(
//                                                                         () {
//                                                                       context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .imagetoBinary(
//                                                                               ImageSource.camera);
//                                                                       context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .fileValidation = false;
//                                                                     });
//                                                                   } else {
//                                                                     print(
//                                                                         "obAAAAAject");
//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .showtoast();
//                                                                   }
//                                                                 });
//                                                               },
//                                                         icon: Icon(
//                                                           Icons.photo_camera,
//                                                           color: Colors.white,
//                                                         )),
//                                                   )),
//                                               SizedBox(
//                                                 width: Screens.width(context) *
//                                                     0.02,
//                                               ),

//                                               //old
//                                               Container(
//                                                   // alignment: Alignment.center,
//                                                   height: Screens.padingHeight(
//                                                           context) *
//                                                       0.06,
//                                                   width:
//                                                       Screens.width(context) *
//                                                           0.13,
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               6),
//                                                       color: context
//                                                                   .read<
//                                                                       QuotestabController>()
//                                                                   .fileValidation ==
//                                                               true
//                                                           ? Colors.red
//                                                           : theme.primaryColor
//                                                       // shape: BoxShape
//                                                       //     .circle
//                                                       ),
//                                                   child: Center(
//                                                     child: IconButton(
//                                                         onPressed: context
//                                                                     .read<
//                                                                         QuotestabController>()
//                                                                     .files
//                                                                     .length >
//                                                                 2
//                                                             ? null
//                                                             : () {
//                                                                 setState(() {
//                                                                   // log("files length" + files.length.toString());
//                                                                   // showtoast();
//                                                                   if (context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .files
//                                                                           .length <=
//                                                                       1) {
//                                                                     setState(
//                                                                         () {
//                                                                       context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .selectattachment();

//                                                                       context
//                                                                           .read<
//                                                                               QuotestabController>()
//                                                                           .fileValidation = false;
//                                                                     });
//                                                                   } else {
//                                                                     print(
//                                                                         "obAAAAAject");

//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .showtoast();
//                                                                   }
//                                                                 });
//                                                               },
//                                                         icon: Icon(
//                                                           Icons.attach_file,
//                                                           color: Colors.white,
//                                                         )),
//                                                   )),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),

//                                 context.read<QuotestabController>().files == null
//                                     ? Container(
//                                         height:
//                                             Screens.padingHeight(context) * 0.3,
//                                         padding: EdgeInsets.only(
//                                           top: Screens.padingHeight(context) *
//                                               0.001,
//                                           right: Screens.padingHeight(context) *
//                                               0.015,
//                                           left: Screens.padingHeight(context) *
//                                               0.015,
//                                           bottom:
//                                               Screens.padingHeight(context) *
//                                                   0.015,
//                                         ),
//                                         child: Container(
//                                             alignment: Alignment.center,
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Center(
//                                                     child: Text(
//                                                   "No Files Selected",
//                                                   style: theme
//                                                       .textTheme.bodyText1!
//                                                       .copyWith(
//                                                           color: context
//                                                                       .read<
//                                                                           QuotestabController>()
//                                                                       .fileValidation ==
//                                                                   true
//                                                               ? Colors.red
//                                                               : Colors.green),
//                                                 )),
//                                                 Icon(
//                                                   Icons.file_present_outlined,
//                                                   color: theme.primaryColor,
//                                                 )
//                                               ],
//                                             )))
//                                     : Container(
//                                         height: context
//                                                     .read<QuotestabController>()
//                                                     .files
//                                                     .length ==
//                                                 0
//                                             ? Screens.padingHeight(context) *
//                                                 0.0
//                                             : Screens.padingHeight(context) *
//                                                 0.3,
//                                         padding: EdgeInsets.only(
//                                           top: Screens.padingHeight(context) *
//                                               0.001,
//                                           right: Screens.padingHeight(context) *
//                                               0.015,
//                                           left: Screens.padingHeight(context) *
//                                               0.015,
//                                           bottom:
//                                               Screens.padingHeight(context) *
//                                                   0.015,
//                                         ),
//                                         child: ListView.builder(
//                                             itemCount: context
//                                                 .read<QuotestabController>()
//                                                 .files
//                                                 .length,
//                                             itemBuilder:
//                                                 (BuildContext context, int i) {
//                                               if (context
//                                                   .read<QuotestabController>()
//                                                   .files[i]
//                                                   .path
//                                                   .split('/')
//                                                   .last
//                                                   .contains("png")) {
//                                                 return Container(
//                                                     child: Column(children: [
//                                                   SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                   Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Container(
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.09,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: Center(
//                                                                 child: Image.asset(
//                                                                     "Assets/img.jpg"))),
//                                                         Container(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     10),
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.6,
//                                                             // height: Screens.padingHeight(context) * 0.06,
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Text(
//                                                               context
//                                                                   .watch<
//                                                                       QuotestabController>()
//                                                                   .files[i]
//                                                                   .path
//                                                                   .split('/')
//                                                                   .last,
//                                                               // overflow: TextOverflow.ellipsis,
//                                                             )),
//                                                         Container(
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.1,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: IconButton(
//                                                                 onPressed: () {
//                                                                   setState(() {
//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .files
//                                                                         .removeAt(
//                                                                             i);
//                                                                             context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .filedata
//                                                                         .removeAt(
//                                                                             i);
//                                                                   });
//                                                                 },
//                                                                 icon: Icon(
//                                                                   Icons
//                                                                       .cancel_rounded,
//                                                                   color: Colors
//                                                                       .grey,
//                                                                 )))
//                                                       ])
//                                                 ])
//                                                     // )
//                                                     );
//                                               } else if (context
//                                                   .read<QuotestabController>()
//                                                   .files[i]
//                                                   .path
//                                                   .split('/')
//                                                   .last
//                                                   .contains("jp")) {
//                                                 return Container(
//                                                     child: Column(children: [
//                                                   SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                   Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Container(
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.09,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: Center(
//                                                                 child: Image.asset(
//                                                                     "Assets/img.jpg"))),
//                                                         Container(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     10),
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.6,
//                                                             // height: Screens.padingHeight(context) * 0.06,
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Text(
//                                                               context
//                                                                   .watch<
//                                                                       QuotestabController>()
//                                                                   .files[i]
//                                                                   .path
//                                                                   .split('/')
//                                                                   .last,
//                                                             )),
//                                                         Container(
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.1,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: IconButton(
//                                                                 onPressed: () {
//                                                                   setState(() {
//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .files
//                                                                         .removeAt(
//                                                                             i);
//                                                                             context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .filedata
//                                                                         .removeAt(
//                                                                             i);
//                                                                   });
//                                                                 },
//                                                                 icon: Icon(
//                                                                   Icons
//                                                                       .cancel_rounded,
//                                                                   color: Colors
//                                                                       .grey,
//                                                                 )))
//                                                       ])
//                                                 ])
//                                                     // )
//                                                     );
//                                               } else if (context
//                                                   .read<QuotestabController>()
//                                                   .files[i]
//                                                   .path
//                                                   .split('/')
//                                                   .last
//                                                   .contains("pdf")) {
//                                                 return Container(
//                                                     child: Column(children: [
//                                                   SizedBox(
//                                                     height:
//                                                         Screens.padingHeight(
//                                                                 context) *
//                                                             0.01,
//                                                   ),
//                                                   Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Container(
//                                                           decoration:
//                                                               BoxDecoration(),
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.09,
//                                                           height: Screens
//                                                                   .padingHeight(
//                                                                       context) *
//                                                               0.06,
//                                                           child: Center(
//                                                               child: Image.asset(
//                                                                   "Assets/PDFimg.png")),
//                                                         ),
//                                                         Container(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     10),
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.6,
//                                                             // height: Screens.padingHeight(context) * 0.06,
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Text(
//                                                               context
//                                                                   .watch<
//                                                                       QuotestabController>()
//                                                                   .files[i]
//                                                                   .path
//                                                                   .split('/')
//                                                                   .last,
//                                                             )),
//                                                         Container(
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.1,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: IconButton(
//                                                                 onPressed: () {
//                                                                   setState(() {
//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .files
//                                                                         .removeAt(
//                                                                             i);
//                                                                             context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .filedata
//                                                                         .removeAt(
//                                                                             i);
//                                                                   });
//                                                                 },
//                                                                 icon: Icon(
//                                                                   Icons
//                                                                       .cancel_rounded,
//                                                                   color: Colors
//                                                                       .grey,
//                                                                 )))
//                                                       ])
//                                                 ]));
//                                               } else if (context
//                                                   .read<QuotestabController>()
//                                                   .files[i]
//                                                   .path
//                                                   .split('/')
//                                                   .last
//                                                   .contains("xlsx")) {
//                                                 return Container(
//                                                     child: Column(children: [
//                                                   SizedBox(
//                                                     height:
//                                                         Screens.padingHeight(
//                                                                 context) *
//                                                             0.01,
//                                                   ),
//                                                   Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Container(
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.09,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: Center(
//                                                                 child: Image.asset(
//                                                                     "Assets/xls.png"))),
//                                                         Container(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     10),
//                                                             decoration:
//                                                                 BoxDecoration(),
//                                                             width: Screens.width(
//                                                                     context) *
//                                                                 0.6,
//                                                             // height: Screens.padingHeight(context) * 0.06,
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Text(
//                                                               context
//                                                                   .read<
//                                                                       QuotestabController>()
//                                                                   .files[i]
//                                                                   .path
//                                                                   .split('/')
//                                                                   .last,
//                                                             )),
//                                                         Container(
//                                                             width:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.1,
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.06,
//                                                             child: IconButton(
//                                                                 onPressed: () {
//                                                                   setState(() {
//                                                                     context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .files
//                                                                         .removeAt(
//                                                                             i);
//                                                                             context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .filedata
//                                                                         .removeAt(
//                                                                             i);
//                                                                   });
//                                                                 },
//                                                                 icon: Icon(
//                                                                   Icons
//                                                                       .cancel_rounded,
//                                                                   color: Colors
//                                                                       .grey,
//                                                                 )))
//                                                       ])
//                                                 ])
//                                                     // )
//                                                     );
//                                               }
//                                               return Container(
//                                                   child: Column(children: [
//                                                 SizedBox(
//                                                   height: Screens.padingHeight(
//                                                           context) *
//                                                       0.01,
//                                                 ),
//                                                 Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Container(
//                                                           decoration:
//                                                               BoxDecoration(),
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.09,
//                                                           height: Screens
//                                                                   .padingHeight(
//                                                                       context) *
//                                                               0.06,
//                                                           child: Center(
//                                                               child: Image.asset(
//                                                                   "Assets/txt.png"))),
//                                                       Container(
//                                                           padding:
//                                                               EdgeInsets.all(
//                                                                   10),
//                                                           decoration:
//                                                               BoxDecoration(),
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.6,
//                                                           // height: Screens.padingHeight(context) * 0.06,
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Text(
//                                                             context
//                                                                 .watch<
//                                                                     QuotestabController>()
//                                                                 .files[i]
//                                                                 .path
//                                                                 .split('/')
//                                                                 .last,
//                                                           )),
//                                                       Container(
//                                                           width: Screens.width(
//                                                                   context) *
//                                                               0.1,
//                                                           height: Screens
//                                                                   .padingHeight(
//                                                                       context) *
//                                                               0.06,
//                                                           child: IconButton(
//                                                               onPressed: () {
//                                                                 setState(() {
//                                                                   context
//                                                                       .read<
//                                                                           QuotestabController>()
//                                                                       .files
//                                                                       .removeAt(
//                                                                           i);
//                                                                           context
//                                                                         .read<
//                                                                             QuotestabController>()
//                                                                         .filedata
//                                                                         .removeAt(
//                                                                             i);
//                                                                 });
//                                                               },
//                                                               icon: Icon(
//                                                                 Icons
//                                                                     .cancel_rounded,
//                                                                 color:
//                                                                     Colors.grey,
//                                                               )))
//                                                     ])
//                                               ]));
//                                             })),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                         child: Text(
//                                       context
//                                           .watch<QuotestabController>()
//                                           .getorderInvBillDate!, // "Next Follow up",
//                                       style:
//                                           theme.textTheme.bodyText2?.copyWith(
//                                         color: context
//                                                 .watch<QuotestabController>()
//                                                 .getorderInvBillDate!
//                                                 .contains(" *")
//                                             ? Colors.red
//                                             : Colors.grey,
//                                       ), // fontSize: 12
//                                     )),
//                                     InkWell(
//                                       onTap: () {
//                                         context
//                                             .read<QuotestabController>()
//                                             .showFollowupInvDate(context);
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal:
//                                                 Screens.width(context) * 0.015),
//                                         width: Screens.width(context) * 0.4,
//                                         height:
//                                             Screens.bodyheight(context) * 0.05,
//                                         decoration: BoxDecoration(
//                                             border:
//                                                 Border.all(color: Colors.grey),
//                                             borderRadius:
//                                                 BorderRadius.circular(4)),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Container(
//                                               width:
//                                                   Screens.width(context) * 0.24,
//                                               // color: Colors.red,
//                                               child: Text(
//                                                 context
//                                                     .watch<QuotestabController>()
//                                                     .getnextInvFD,
//                                                 // context.read<QuotestabController>().getnextFD,
//                                                 style: theme.textTheme.bodyText2
//                                                     ?.copyWith(), //fontSize: 12
//                                               ),
//                                             ),
//                                             Container(
//                                               alignment: Alignment.centerRight,
//                                               width:
//                                                   Screens.width(context) * 0.12,
//                                               // color: Colors.red,
//                                               child: Icon(
//                                                 Icons.calendar_month,
//                                                 // size: Screens.,
//                                                 color: theme.primaryColor,
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                               ],
//                             ):Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                               SizedBox(
//                                   height: Screens.bodyheight(context) * 0.001,
//                                 ),
                                
//                                  Container(
//                                     width: Screens.width(context),
//                               // height: Screens.,
//                               padding:
//                                   EdgeInsets.only(top: 1, left: 10, right: 10),
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(8)),
//                                    child: DropdownButton(
//                                                                  hint: Text(
//                                     context
//                                         .watch<QuotestabController>()
//                                         .gethinttextforcancel!,
//                                     style: theme.textTheme.bodyText2?.copyWith(
//                                         color: context
//                                                 .watch<QuotestabController>()
//                                                 .gethinttextforcancel!
//                                                 .contains(" *")
//                                             ? Colors.red
//                                             : Colors.grey),
//                                                                  ),
//                                                                  value: context
//                                       .read<QuotestabController>()
//                                       .valuecancelStatus,
//                                                                  //dropdownColor:Colors.green,
//                                                                  icon: Icon(Icons.arrow_drop_down),
//                                                                  iconSize: 30,
//                                                                  style: TextStyle(
//                                       color: Colors.black, fontSize: 16),
//                                                                  isExpanded: true,
//                                                                  onChanged: (val) {
//                                     setState(() {
//                                       context
//                                           .read<QuotestabController>()
//                                           .choosedcancelStatus(val.toString());
//                                     });
//                                                                  },
//                                                                  items: context
//                                       .read<QuotestabController>()
//                                       .orderdialogdata
//                                       .map((e) {
//                                     return DropdownMenuItem(
//                                         // ignore: unnecessary_brace_in_string_interps
//                                         value: "${e.code}",
//                                         child: Container(
//                                             // height: Screens.bodyheight(context)*0.1,
//                                             child: Text("${e.name}")));
//                                                                  }).toList(),
//                                                                ),
//                                  ),
// SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                                   Container(
//                         child: Text(
//                           context
//                               .watch<QuotestabController>()
//                               .getfeedbackcancel!, // "Feedback",
//                           style: theme.textTheme.bodyText2?.copyWith(
//                             color: context
//                                     .watch<QuotestabController>()
//                                     .getfeedbackcancel!
//                                     .contains(" *")
//                                 ? Colors.red
//                                 : Colors.grey,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                                  TextFormField(
//                         controller:
//                             context.read<QuotestabController>().mycontroller[5],
//                         decoration: InputDecoration(
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey[400]!),
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.grey[400]!, width: 2.0),
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                         ),
//                       ),
//                             ],),
//                       SizedBox(
//                         height: Screens.bodyheight(context) * 0.02,
//                       ),
//                     ],
//                   ),
//                 )),
//             Container(
//               width: Screens.width(context),
//               height: Screens.bodyheight(context) * 0.06,
//               child: ElevatedButton(
//                   onPressed: () {
//                     if (QuotestabController.comeFromEnq == -1) {
//                       context.read<QuotestabController>().clickLeadSaveBtn(
//                           widget.leadOpenAllData!.FollowupEntry.toString(),
//                           widget.leadOpenAllData!.OrderDocEntry.toString());
//                     } else {
//                       print("objectw");
//                       context.read<QuotestabController>().clickLeadSaveBtn(
//                           context
//                               .read<QuotestabController>()
//                               .leadDeatilsLData[0]
//                               .FollowupEntry
//                               .toString(),
//                           QuotestabController.comeFromEnq.toString());
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     textStyle: TextStyle(
//                         // fontSize: 12,
//                         ),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10),
//                     )), //Radius.circular(6)
//                   ),
//                   child: context
//                                   .read<QuotestabController>()
//                                   .getcaseStatusSelected ==
//                               'Cancel'?Text("Confirm Cancel"): Text("Save")),
//             ),
//           ],
//         ),
//       ),
    );
  }

  Container CallDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      //  height: Screens.bodyheight(context)*0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      // padding: EdgeInsets.only(
      //   left: Screens.width(context) * 0.05,
      //   right: Screens.width(context) * 0.05,
      //   top: Screens.bodyheight(context) * 0.03,
      //   bottom: Screens.bodyheight(context) * 0.03,
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  context.read<QuotestabController>().makePhoneCall(context
                      .read<QuotestabController>()
                      .QuotesOpenAllData[widget.index]
                      .Mobile!);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(),
                    Container(
                      width: Screens.width(context) * 0.1,
                      height: Screens.bodyheight(context) * 0.05,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: Icon(
                        Icons.call,
                        size: Screens.bodyheight(context) * 0.02,
                      ),
                    ),
                    Container(child: Text("Click to Call")),
                    Container(),
                  ],
                )),
          ),
          Container(
            width: Screens.width(context),
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.03,
              right: Screens.width(context) * 0.03,
              top: Screens.bodyheight(context) * 0.01,
              bottom: Screens.bodyheight(context) * 0.01,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         Container(
              width: Screens.width(context)*0.35,
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    context.read<QuotestabController>().mapvaluesmodify(widget.leadOpenAllData);
                   
                    // if (QuotestabController.comeFromEnq == -1) {
                    //   context.read<QuotestabController>().clickLeadSaveBtn(
                    //       context
                    //           .read<QuotestabController>()
                    //           .getAllLeadData[widget.index]
                    //           .FollowupEntry
                    //           .toString(),
                    //       context
                    //           .read<QuotestabController>()
                    //           .getAllLeadData[widget.index]
                    //           .LeadDocEntry
                    //           .toString());
                    // } else {
                    //   context.read<QuotestabController>().clickLeadSaveBtn(
                    //       context
                    //           .read<QuotestabController>()
                    //           .leadDeatilsLData[0]
                    //           .FollowupEntry
                    //           .toString(),
                    //       QuotestabController.comeFromEnq.toString());
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                        // fontSize: 12,
                        ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))), //Radius.circular(6)
                  ),
                  child: Text("Modify")),
            ),
             Container(
              width: Screens.width(context)*0.35,
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                      setState(() {
                                  context
                                        .read<QuotestabController>()
                                        .caseStatusSelectBtn("Cancel");
                                context
                                        .read<QuotestabController>()
                                        .changetoFolloweUp();
                              });
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                        // fontSize: 12,
                        ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))), //Radius.circular(6)
                  ),
                  child: Text("Cancel")),
            ),
            
                        // Container(
                        //   width: Screens.width(context) * 0.35,
                        //   //  height: Screens.padingHeight(context)*0.2,
                        //   child: ElevatedButton(
                        //     onPressed: 
                        //     widget.leadOpenAllData!.isDelivered ==
                        //                 1 ||
                        //             widget.leadOpenAllData!.isDelivered == 1 &&
                        //                 widget.leadOpenAllData!.isInvoiced == 1
                        //         ? () {}
                        //         : () {
                        //             setState(() {
                        //               // context
                        //               //     .read<QuotestabController>()
                        //               //     .opendialogbool = true;
                        //             });
                        //             context
                        //                 .read<QuotestabController>()
                        //                 .caseStatusSelectBtn("Won");
                        //             context
                        //                 .read<QuotestabController>()
                        //                 .changetoFolloweUp();
                        //           },
                        //     style: widget.leadOpenAllData!.isDelivered == 1 ||
                        //             widget.leadOpenAllData!.isDelivered == 1 &&
                        //                 widget.leadOpenAllData!.isInvoiced == 1
                        //         ? ElevatedButton.styleFrom(
                        //             backgroundColor:
                        //                 //  theme.primaryColor
                        //                 Colors.grey[200])
                        //         : ElevatedButton.styleFrom(
                        //             backgroundColor: theme.primaryColor
                        //             // Colors.grey[200]
                        //             ),
                        //     child: Column(
                        //       children: [
                        //         Stack(
                        //           children: [
                        //             Container(
                        //               padding: EdgeInsets.all(8),
                        //               decoration: BoxDecoration(
                        //                   color: Colors.grey[200],
                        //                   borderRadius:
                        //                       BorderRadius.circular(5)),
                        //               child: Icon(
                        //                 Icons.local_shipping,
                        //                 size: 30,
                        //                 color: theme.primaryColor,
                        //               ),
                        //             ),
                        //             widget.leadOpenAllData!.isDelivered == 1 ||
                        //                     widget.leadOpenAllData!
                        //                                 .isDelivered ==
                        //                             1 &&
                        //                         widget.leadOpenAllData!
                        //                                 .isInvoiced ==
                        //                             1
                        //                 ? Container(
                        //                     child: Icon(
                        //                     Icons.check,
                        //                     color: Colors.green,
                        //                     size: 50,
                        //                     weight: 10.0,
                        //                   ))
                        //                 : SizedBox()
                        //           ],
                        //         ),
                        //         SizedBox(
                        //           height: Screens.padingHeight(context) * 0.01,
                        //         ),
                        //         Container(
                        //           child: Text(
                        //             "Delivered",
                        //             style: theme.textTheme.bodyText1!.copyWith(
                        //                 color: widget.leadOpenAllData!
                        //                                 .isDelivered ==
                        //                             1 ||
                        //                         widget.leadOpenAllData!
                        //                                     .isDelivered ==
                        //                                 1 &&
                        //                             widget.leadOpenAllData!
                        //                                     .isInvoiced ==
                        //                                 1
                        //                     ? theme.primaryColor
                        //                     : Colors.white),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        //invoice
                        // Container(
                        //   width: Screens.width(context) * 0.35,
                        //   child: ElevatedButton(
                        //     onPressed: widget.leadOpenAllData!.isInvoiced ==
                        //                 1 ||
                        //             widget.leadOpenAllData!.isDelivered == 1 &&
                        //                 widget.leadOpenAllData!.isInvoiced == 1
                        //         ? () {}
                        //         : () {
                        //             setState(() {
                        //               // context
                        //               //     .read<QuotestabController>()
                        //               //     .opendialogbool = true;
                        //             });
                        //             context
                        //                 .read<QuotestabController>()
                        //                 .caseStatusSelectBtn("Invoice");
                        //             context
                        //                 .read<QuotestabController>()
                        //                 .changetoFolloweUp();
                        //           },
                        //     style: widget.leadOpenAllData!.isInvoiced == 1 ||
                        //             widget.leadOpenAllData!.isDelivered == 1 &&
                        //                 widget.leadOpenAllData!.isInvoiced == 1
                        //         ? ElevatedButton.styleFrom(
                        //             backgroundColor:

                        //                 // theme.primaryColor
                        //                 Colors.grey[200])
                        //         : ElevatedButton.styleFrom(
                        //             backgroundColor: theme.primaryColor
                        //             //  Colors.grey[200]
                        //             ),
                        //     child: Column(
                        //       children: [
                        //         Stack(
                        //           children: [
                        //             Container(
                        //               padding: EdgeInsets.all(8),
                        //               decoration: BoxDecoration(
                        //                   color: Colors.grey[200],
                        //                   borderRadius:
                        //                       BorderRadius.circular(5)),
                        //               child: Icon(
                        //                 Icons.receipt_long,
                        //                 size: 30,
                        //                 color: theme.primaryColor,
                        //               ),
                        //             ),
                        //             widget.leadOpenAllData!.isInvoiced == 1 ||
                        //                     widget.leadOpenAllData!
                        //                                 .isDelivered ==
                        //                             1 &&
                        //                         widget.leadOpenAllData!
                        //                                 .isInvoiced ==
                        //                             1
                        //                 ? Container(
                        //                     child: Icon(
                        //                     Icons.check,
                        //                     color: Colors.lightGreen,
                        //                     size: 50,
                        //                     weight: 10.0,
                        //                   ))
                        //                 : SizedBox()
                        //           ],
                        //         ),
                        //         SizedBox(
                        //           height: Screens.padingHeight(context) * 0.01,
                        //         ),
                        //         Container(
                        //           child: Text("Invoice",
                        //               style: theme.textTheme.bodyText1!.copyWith(
                        //                   color: widget.leadOpenAllData!
                        //                                   .isInvoiced ==
                        //                               1 ||
                        //                           widget.leadOpenAllData!
                        //                                       .isDelivered ==
                        //                                   1 &&
                        //                               widget.leadOpenAllData!
                        //                                       .isInvoiced ==
                        //                                   1
                        //                       ? theme.primaryColor
                        //                       : Colors.white)),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                     
                      ],
                    ),

                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),

                    //secode Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         Container(
              width: Screens.width(context) *0.80,
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                     context.read<QuotestabController>().mapvaluestoorder(widget.leadOpenAllData);
                   
                    
                    // context.read<QuotestabController>().convertToQuatatioMethod();
                    // if (QuotestabController.comeFromEnq == -1) {
                    //   context.read<QuotestabController>().clickLeadSaveBtn(
                    //       context
                    //           .read<QuotestabController>()
                    //           .getAllLeadData[widget.index]
                    //           .FollowupEntry
                    //           .toString(),
                    //       context
                    //           .read<QuotestabController>()
                    //           .getAllLeadData[widget.index]
                    //           .LeadDocEntry
                    //           .toString());
                    // } else {
                    //   context.read<QuotestabController>().clickLeadSaveBtn(
                    //       context
                    //           .read<QuotestabController>()
                    //           .leadDeatilsLData[0]
                    //           .FollowupEntry
                    //           .toString(),
                    //       QuotestabController.comeFromEnq.toString());
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      
                        // fontSize: 12,
                        ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))), //Radius.circular(6)
                  ),
                  child: Text("Convert To Order",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  )),
            ),
                        // Container(
                        //   width: Screens.width(context) * 0.35,
                        //   child: ElevatedButton(
                        //     onPressed:
                        //         // widget.leadOpenAllData!.isDelivered == 1 &&
                        //         //         widget.leadOpenAllData!.isInvoiced == 1
                        //         //    ? () {}
                        //         //     : 
                        //             () {
                        //                 context
                        //                     .read<QuotestabController>()
                        //                     .mapvaluesmodify(
                        //                         widget.leadOpenAllData);
                        //               },
                        //     style: 
                        //     // widget.leadOpenAllData!.isDelivered == 1 &&
                        //     //         widget.leadOpenAllData!.isInvoiced == 1
                        //     //     ? ElevatedButton.styleFrom(
                        //     //         backgroundColor:
                        //     //             // widget.leadOpenAllData!.isDelivered == 1
                        //     //             //     ? Colors.green
                        //     //             // :
                        //     //             Colors.grey[200])
                        //     //     :
                        //          ElevatedButton.styleFrom(
                        //             backgroundColor:
                        //                 // widget.leadOpenAllData!.isDelivered == 1
                        //                 //     ? Colors.green
                        //                 // :
                        //                 theme.primaryColor),
                        //     child: Column(
                        //       children: [
                        //         Stack(
                        //           children: [
                        //             Container(
                        //               padding: EdgeInsets.all(8),
                        //               decoration: BoxDecoration(
                        //                   color: Colors.grey[200],
                        //                   borderRadius:
                        //                       BorderRadius.circular(5)),
                        //               child: Icon(
                        //                 Icons.edit_square,
                        //                 size: 30,
                        //                 color: theme.primaryColor,
                        //               ),
                        //             ),
                        //             // widget.leadOpenAllData!.isDelivered == 1
                        //             //     ?
                        //             //     Container(
                        //             //         child: Icon(
                        //             //         Icons.check,
                        //             //         color: Colors.green,
                        //             //         size: 50,
                        //             //         weight: 10.0,
                        //             //       )):SizedBox()
                        //           ],
                        //         ),
                        //         SizedBox(
                        //           height: Screens.padingHeight(context) * 0.01,
                        //         ),
                        //         Container(
                        //           child: Text(
                        //             "Modify",
                        //             style: theme.textTheme.bodyText1!.copyWith(
                        //                 color: 
                        //                 // widget.leadOpenAllData!
                        //                 //                 .isDelivered ==
                        //                 //             1 &&
                        //                 //         widget.leadOpenAllData!
                        //                 //                 .isInvoiced ==
                        //                 //             1
                        //                 //     ? 
                        //                     // theme.primaryColor
                        //                     // :
                        //                     Colors.white
                        //                     ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // //invoice
                        // Container(
                        //   width: Screens.width(context) * 0.35,
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       setState(() {
                        //           context
                        //                 .read<QuotestabController>()
                        //                 .caseStatusSelectBtn("Cancel");
                        //         context
                        //                 .read<QuotestabController>()
                        //                 .changetoFolloweUp();
                        //       });
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //         backgroundColor:
                        //             // widget  .  leadOpenAllData!.isInvoiced  ==1
                        //             //     ? Colors.green
                        //             //     :
                        //             theme.primaryColor),
                        //     child: Column(
                        //       children: [
                        //         Stack(
                        //           children: [
                        //             Container(
                        //               padding: EdgeInsets.all(8),
                        //               decoration: BoxDecoration(
                        //                   color: Colors.grey[200],
                        //                   borderRadius:
                        //                       BorderRadius.circular(5)),
                        //               child: Icon(
                        //                 Icons.cancel_presentation,
                        //                 size: 30,
                        //                 color: theme.primaryColor,
                        //               ),
                        //             ),
                        //             //  widget  .  leadOpenAllData!.isInvoiced  ==1
                        //             //       ?
                        //             //       Container(
                        //             //           child: Icon(
                        //             //           Icons.check,
                        //             //           color: Colors.green,
                        //             //           size: 50,
                        //             //           weight: 10.0,
                        //             //         )):SizedBox()
                        //           ],
                        //         ),
                        //         SizedBox(
                        //           height: Screens.padingHeight(context) * 0.01,
                        //         ),
                        //         Container(
                        //           child: Text(
                        //             "Cancel",
                        //             style: theme.textTheme.bodyText1!
                        //                 .copyWith(color: Colors.white),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                     
                      ],
                    )

                    //  widget  .  leadOpenAllData!.isDelivered == 1?    Container():    Container(
                    //             width: Screens.width(context),
                    //             height: Screens.bodyheight(context) * 0.06,
                    //             child: ElevatedButton(
                    //                 style: ElevatedButton.styleFrom(
                    //                   shape: RoundedRectangleBorder(
                    //                       borderRadius:
                    //                           BorderRadius.all(Radius.circular(6))),
                    //                 ),
                    //                 onPressed: () {
                    //                   setState(() {
                    //                     // context
                    //                     //     .read<QuotestabController>()
                    //                     //     .opendialogbool = true;
                    //                   });
                    //                   context
                    //                       .read<QuotestabController>()
                    //                       .caseStatusSelectBtn("Won");
                    //                   context
                    //                       .read<QuotestabController>()
                    //                       .changetoFolloweUp();
                    //                 },
                    //                 child: Text("Delivered")),
                    //           ),
                    //           // :Container(),
                    //           SizedBox(
                    //             height: Screens.bodyheight(context) * 0.02,
                    //           ),

                    //           //isInvoiced
                    //        widget  .  leadOpenAllData!.isInvoiced  ==0?
                    //                       Container(
                    //             width: Screens.width(context),
                    //             height: Screens.bodyheight(context) * 0.06,
                    //             child: ElevatedButton(
                    //                 style: ElevatedButton.styleFrom(
                    //                   shape: RoundedRectangleBorder(
                    //                       borderRadius:
                    //                           BorderRadius.all(Radius.circular(6))),
                    //                 ),
                    //                 onPressed: () {
                    //                   setState(() {
                    //                     // context
                    //                     //     .read<QuotestabController>()
                    //                     //     .opendialogbool = true;
                    //                   });
                    //                   context
                    //                       .read<QuotestabController>()
                    //                       .caseStatusSelectBtn("Invoice");
                    //                   context
                    //                       .read<QuotestabController>()
                    //                       .changetoFolloweUp();
                    //                 },
                    //                 child: Text("Invoice")),
                    //           )
                    //           :Container(),
                    //           SizedBox(
                    //             height: Screens.bodyheight(context) * 0.01,
                    //           ),
                  ],
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
              ],
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  // if (QuotestabController.comeFromEnq == -1) {
                    context.read<QuotestabController>().callGetLeadDeatilsApi(
                        widget.leadOpenAllData!.OrderDocEntry!.toString());
                  // } else {
                  //   //   Navigator.pop(context);
                  //   //       context.read<QuotestabController>().comeFromEnqApi(
                  //   //  context,QuotestabController.comeFromEnq.toString());
                  //   context.read<QuotestabController>().viweDetailsClicked();
                  // }
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Text("View Details")),
          ),
        ],
      ),
    );
  }

  //view details

  Container detailsDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      // height: Screens.bodyheight(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(""),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Quotation Details",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.77,
            padding: EdgeInsets.only(
              top: Screens.bodyheight(context) * 0.01,
              bottom: Screens.bodyheight(context) * 0.01,
              left: Screens.width(context) * 0.03,
              right: Screens.width(context) * 0.01,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].CardName}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        width: Screens.width(context) * 0.4,
                        alignment: Alignment.centerRight,
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Color(0xffC6AC5F),
                        ),
                        child: Center(
                          child: Text(
                            "Open since " +
                                context
                                    .read<QuotestabController>()
                                    .config
                                    .subtractDateTime2(
                                        // "2020-05-18T00:00:00"
                                        "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].OrderCreatedDate}"),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText2?.copyWith(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].Address1}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.43,
                        child: Text(
                          "Worth of Rs." +
                              context
                                  .watch<QuotestabController>()
                                  .config
                                  .slpitCurrency22(
                                    "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].DocTotal!.toString()}",
                                  ) +
                              '/-',
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].Address2}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "# ${context.watch<QuotestabController>().getleadDeatilsQTHData![0].OrderNum}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].City}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "Created on " +
                              context.watch<QuotestabController>().config.alignDate3(
                                  "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].OrderCreatedDate}" //.LastFUPUpdate
                                  ),
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      context
                                      .watch<QuotestabController>()
                                      .getleadDeatilsQTHData![0]
                                      .CardCode ==
                                  null ||
                              context
                                      .watch<QuotestabController>()
                                      .getleadDeatilsQTHData![0]
                                      .CardCode ==
                                  "null" ||
                              context
                                  .watch<QuotestabController>()
                                  .getleadDeatilsQTHData![0]
                                  .CardCode!
                                  .isEmpty
                          ? Container():  InkWell(
                        onTap: (){
                           context.read<QuotestabController>().makePhoneCall(context
                      .read<QuotestabController>()
                      .getleadDeatilsQTHData![0].CardCode!);
                        },
                        child: Container(
                          width: Screens.width(context) * 0.4,
                          child: Text(
                            "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].CardCode}",
                            style: theme.textTheme.bodyText2?.copyWith(decoration:  TextDecoration.underline,color:Colors.blue),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: Screens.width(context) * 0.4,
                      //   child: Text(
                      //     "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].Pincode}",
                      //     style: theme.textTheme.bodyText2?.copyWith(),
                      //   ),
                      // ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   width: Screens.width(context) * 0.43,
                      //   child: Text(
                      //     "Last Update on " +
                      //         context.watch<QuotestabController>().config.alignDate3(
                      //             "${context.watch<QuotestabController>().getleadDeatilsQTHData!.LastFUPUpdate}" //.
                      //             ),
                      //     style: theme.textTheme.bodyText2?.copyWith(),
                      //   ),
                      // ),
                    ],
                  ),

                  // createTable(theme),

                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  // Container(
                  //     width: Screens.width(context),
                  //     padding: EdgeInsets.symmetric(
                  //         // horizontal: Screens.width(context) * 0.03,
                  //         vertical: Screens.bodyheight(context) * 0.02),
                  //     decoration: BoxDecoration(
                  //         color: theme.primaryColor.withOpacity(0.05),
                  //         borderRadius: BorderRadius.circular(8),
                  //         border: Border.all(color: Colors.black26)),
                  // child: Column(
                  //   children: [
                  //     Center(
                  //       child: Container(
                  //         alignment: Alignment.center,
                  // child: Text(
                  //   'Next Follow up # ' +
                  //       context
                  //           .watch<QuotestabController>()
                  //           .config
                  //           .alignDate(
                  //               '${context.watch<QuotestabController>().getleadDeatilsLeadData[context.watch<QuotestabController>().getleadDeatilsLeadData.length - 1].NextFollowup_Date}'),
                  //   textAlign: TextAlign.center,
                  //   style: theme.textTheme.bodyText2?.copyWith(
                  //     color: theme.primaryColor,
                  //   ),
                  // ),
                  //   ),
                  // ),
                  // Container(
                  //     width: Screens.width(context),
                  //     margin: EdgeInsets.only(
                  //       // left: Screens.width(context) * 0.03,
                  //       top: Screens.bodyheight(context) * 0.01,
                  //       bottom: Screens.bodyheight(context) * 0.01,
                  //     ),
                  //     decoration: BoxDecoration(
                  //         border: Border(
                  //             bottom:
                  //                 BorderSide(color: Colors.black26)))),
                  // Center(
                  //   child: Container(
                  //     alignment: Alignment.center,
                  // child: Text(
                  //   'Last status # ${context.watch<QuotestabController>().getleadDeatilsLeadData[context.watch<QuotestabController>().getleadDeatilsLeadData.length - 1].Status}',
                  //   textAlign: TextAlign.center,
                  //   style: theme.textTheme.bodyText2?.copyWith(
                  //     color: theme.primaryColor,
                  //   ),
                  // ),
                  //       ),
                  //     )
                  //   ],
                  // )),
                  // Container(
                  //     width: Screens.width(context),
                  //     // height: Screens.bodyheight(context) * 0.16,
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: Screens.width(context) * 0.03,
                  //         vertical: Screens.bodyheight(context) * 0.02),
                  //     decoration: BoxDecoration(
                  //         color: theme.primaryColor.withOpacity(0.05),
                  //         borderRadius: BorderRadius.circular(8),
                  //         border: Border.all(color: Colors.black26)),
                  //     child: Center(
                  //       child: Container(
                  //         alignment: Alignment.center,
                  //         child: Text(
                  //           'Last status # ${context.watch<QuotestabController>().getleadDeatilsQLData[context.watch<QuotestabController>().getleadDeatilsQLData.length - 1].Status}',
                  //           textAlign: TextAlign.center,
                  //           style: theme.textTheme.bodyText2?.copyWith(
                  //             color: theme.primaryColor,
                  //           ),
                  //         ),
                  //       ),
                  //     )),

                  SizedBox(
                    height: Screens.bodyheight(context) * 0.015,
                  ),
                  createTable(theme),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  //

                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // color: Colors.amber,
                              width: Screens.width(context) * 0.4,
                              // height: Screens.padingHeight(context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery Address :",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Text(
                                    "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].del_Address1}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Text(
                                    "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].del_Address2}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Text(
                                    "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].del_Area}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Text(
                                    "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].del_City}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Text(
                                    "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].del_State}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Text(
                                    "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].del_Pincode}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //  color: Colors.red,
                              width: Screens.width(context) * 0.5,

                              // height: Screens.padingHeight(context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Sub Total",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${context
                                    .read<QuotestabController>()
                                    .config.slpitCurrency22 (context.watch<QuotestabController>().getleadDeatilsQTHData![0].subtotal!.toString())}",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Base Amount",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${context
                                    .read<QuotestabController>()
                                    .config.slpitCurrency22(context.watch<QuotestabController>().getleadDeatilsQTHData![0].basetotal!.toString())}",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Tax Amount",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${context
                                    .read<QuotestabController>()
                                    .config.slpitCurrency22(context.watch<QuotestabController>().getleadDeatilsQTHData![0].taxAmount!.toString())}",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Round Off",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${context
                                    .read<QuotestabController>()
                                    .config.slpitCurrency22(context.watch<QuotestabController>().getleadDeatilsQTHData![0].RoundOff!.toString())}",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Total Amount",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${context
                                    .read<QuotestabController>()
                                    .config.slpitCurrency22(context.watch<QuotestabController>().getleadDeatilsQTHData![0].DocTotal!.toString())}",
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.02,
                  ),
                  context
                              .watch<QuotestabController>()
                              .getleadDeatilsQTHData![0]
                              .isDelivered ==
                          1
                      ? Container(
                          width: Screens.width(context),
                          padding: EdgeInsets.symmetric(
                              // horizontal: Screens.width(context) * 0.03,
                              vertical: Screens.bodyheight(context) * 0.02),
                          decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: Column(
                            children: [
                              Container(
                                 width: Screens.width(context)*0.8,
                                alignment: Alignment.centerLeft,
                                child: Text("Delivered on " +
                                    context
                                        .watch<QuotestabController>()
                                        .config
                                        .alignDate(
                                            '${context.watch<QuotestabController>().getleadDeatilsQTHData![0].DeliveryDate}') +
                                    " by referenced " +
                                    "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].DeliveryNo}" +
                                    "", style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.black),),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  ),

                  context
                                  .watch<QuotestabController>()
                                  .getleadDeatilsQTHData![0]
                                  .isDelivered ==
                              1 &&
                          context
                                  .watch<QuotestabController>()
                                  .getleadDeatilsQTHData![0]
                                  .DeliveryURL1 !=
                              null  &&
                          context
                                  .watch<QuotestabController>()
                                  .getleadDeatilsQTHData![0]
                                  .DeliveryURL2 !=
                              null 
                      ? Container(
                          width: Screens.width(context),
                          padding: EdgeInsets.symmetric(
                              // horizontal: Screens.width(context) * 0.03,
                              vertical: Screens.bodyheight(context) * 0.02),
                          decoration: BoxDecoration(
                              // color: theme.primaryColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: Column(
                            children: [
                              Text(
                                  "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].DeliveryURL1}"),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              Text(
                                  "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].DeliveryURL2}"),
                            ],
                          ),
                        )
                      : Container(),
                  // Wrap(
                  //     spacing: 0.0, // width
                  //     runSpacing: 0.0, // height
                  //     children: listTimeLine(theme)),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  context
                              .watch<QuotestabController>()
                              .getleadDeatilsQTHData![0]
                              .isInvoiced ==
                          1
                      ? Container(
                          width: Screens.width(context),
                          padding: EdgeInsets.symmetric(
                              // horizontal: Screens.width(context) * 0.03,
                              vertical: Screens.bodyheight(context) * 0.02),
                          decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: Screens.width(context)*0.8,
                                child: Text("Invoiced on " +
                                    context
                                        .watch<QuotestabController>()
                                        .config
                                        .alignDate(
                                            '${context.watch<QuotestabController>().getleadDeatilsQTHData![0].InvoiceDate}') +
                                    " by referenced " +
                                    "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].InvoiceNo}" +
                                    "", style: theme.textTheme.bodyText1!
                                              .copyWith(color: Colors.black),),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  ),

                  (context
                                  .watch<QuotestabController>()
                                  .getleadDeatilsQTHData![0]
                                  .isInvoiced ==
                              1) &&
                          (context
                                  .watch<QuotestabController>()
                                  .getleadDeatilsQTHData![0]
                                  .InvoiceURL1 !=
                              null ) &&
                          (context
                                  .watch<QuotestabController>()
                                  .getleadDeatilsQTHData![0]
                                  .InvoiceURL2 !=
                              null )
                      ? Container(
                          width: Screens.width(context),
                          padding: EdgeInsets.symmetric(
                              // horizontal: Screens.width(context) * 0.03,
                              vertical: Screens.bodyheight(context) * 0.02),
                          decoration: BoxDecoration(
                              // color: theme.primaryColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black26)),
                          child: Column(
                            children: [
                              Text(
                                  "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].InvoiceURL1}"),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              Text(
                                  "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].InvoiceURL2}"),
                            ],
                          ),
                        )
                      : Container(),

                  //                 Timeline.tileBuilder(
                  //   builder: TimelineTileBuilder.fromStyle(
                  //     contentsAlign: ContentsAlign.alternating,
                  //     contentsBuilder: (context, index) => Padding(
                  //       padding: const EdgeInsets.all(24.0),
                  //       child: Text('Timeline Event $index'),
                  //     ),
                  //     itemCount: 10,
                  //   ),
                  // ),
                    InkWell(
                                onTap: ()async{
                   await context.read<QuotestabController>(). callcustomerapi();
 for(int i=0;i<context.read<QuotestabController>().paymode.length;i++){
        if(context.read<QuotestabController>().paymode[i].CODE ==context.read<QuotestabController>().getleadDeatilsQTHData![0].PaymentTerms){
 pdfviewState.paymode =context.read<QuotestabController>(). paymode[i].description.toString();
        }

       } pdfviewState. customermodeldata =context.read<QuotestabController>().customermodeldata;
                                  pdfviewState.data=context.read<QuotestabController>().getleadDeatilsQTLData;
                                pdfviewState. orderMasterdata2=context.read<QuotestabController>().getleadDeatilsQTHData;
                                // PdfPreview(build: (format)=>pdfState().generatePdf(format, 'title'),);
                                // pdfviewState.paymode=paymode;
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>pdfview()));
                                },
                                 child: Container(
                                   child: Text(
                                    
                                    "Convert as Pdf",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue
                                    ),
                                                               ),
                                 ),
                               ),
                ],
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  context.read<QuotestabController>().viweDetailsClicked();
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Text("Close")),
          ),
        ],
      ),
    );
  }

  ///
  //view details enq

  Container detailsDialogLead(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(""),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Lead Details",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.87,
            padding: EdgeInsets.only(
              top: Screens.bodyheight(context) * 0.01,
              bottom: Screens.bodyheight(context) * 0.01,
              left: Screens.width(context) * 0.03,
              right: Screens.width(context) * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "Customer",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                            "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].CardName}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              // fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        width: Screens.width(context) * 0.4,
                        alignment: Alignment.centerRight,
                        child: Text("",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  context
                              .watch<QuotestabController>()
                              .getleadDeatilsQTHData![0]
                              .Address1!
                              .isNotEmpty ||
                          context
                              .watch<QuotestabController>()
                              .getleadDeatilsQTHData![0]
                              .Address1!
                              .isNotEmpty
                      ? Container(
                          width: Screens.width(context),
                          child: Text(
                            "${context.watch<QuotestabController>().getleadDeatilsQTHData![0].Address1}\n${context.watch<QuotestabController>().getleadDeatilsQTHData![0].Address2}",
                            //"31 west street \nkottucherry \nkaraikal 609-609 \npondicherry",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                            ), // color:  Colors.grey
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: context
                            .watch<QuotestabController>()
                            .getleadDeatilsQTHData![0]
                            .Address1!
                            .isEmpty
                        ? 0.0
                        : Screens.bodyheight(context) * 0.01,
                  ),
                  createTable(theme),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "Total Lead Value",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "20000.00",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "Next Follow up",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "12-08-2022",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Wrap(
                      spacing: 0.0, // width
                      runSpacing: 0.0, // height
                      children: listTimeLine(theme)),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  // context.read<QuotestabController>().mapValuesToLead(context);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Text("Create New Lead")),
          ),
        ],
      ),
    );
  }

  ///

  Widget createTable(ThemeData theme) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Product",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Price",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Qty",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
    ]));
    for (int i = 0;
        i < context.watch<QuotestabController>().getleadDeatilsQTLData.length;
        ++i) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<QuotestabController>().getleadDeatilsQTLData[i].ItemName!}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            context.watch<QuotestabController>().config.slpitCurrency(context
                .watch<QuotestabController>()
                .getleadDeatilsQTLData[i]
                .Price!
                .toStringAsFixed(0)),
            // '${context.watch<QuotestabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<QuotestabController>().getleadDeatilsQTLData[i].Quantity!.toStringAsFixed(0)}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ]));
    }
    return Table(columnWidths: {
      0: FlexColumnWidth(4),
      1: FlexColumnWidth(2.2),
      2: FlexColumnWidth(0.8),
    }, children: rows);
  }

//
  List<Widget> listTimeLine(ThemeData theme) {
    return List.generate(1, (index) {
      if (index == 0) {
        log("1");
        return Column(
          children: [
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.2,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                width: 30,
                color: theme.primaryColor,
                indicatorXY: 0.2,
                padding: EdgeInsets.only(
                  top: 4,
                  left: 4,
                  right: 4,
                ),
                iconStyle: IconStyle(
                  color: Colors.white,
                  iconData: Icons.chat,
                ),
              ),
              beforeLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              afterLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              endChild: Container(
                alignment: Alignment.centerLeft,
                width: Screens.width(context) * 0.6,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${context.read<QuotestabController>().getleadDeatilsQTHData![0].reasonType} ",
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // context.read<QuotestabController>().config.alignDate(
                        "By ${context.read<QuotestabController>().getleadDeatilsQTHData![0].ordersalesperson} ", //),
                        style: theme.textTheme.bodyText2?.copyWith(
                            // color: theme.primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.02,
                    ),
                    // context
                    //         .watch<QuotestabController>()
                    //         .getleadDeatilsLeadData[index]
                    //         .Feedback!
                    //         .isEmpty
                    //     ? SizedBox()
                    //     : Container(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           // context.read<QuotestabController>().config.alignDate(
                    //           "# ${context.read<QuotestabController>().getleadDeatilsLeadData[index].Feedback}",
                    //           style: theme.textTheme.bodyText2?.copyWith(
                    //               // color: theme.primaryColor,
                    //               ),
                    //         ),
                    //       ),
                    Divider(
                      thickness: 1,
                    ),
                    //       SizedBox(
                    //   height: Screens.bodyheight(context) * 0.01,
                    // ),
                  ],
                ),
              ),
              startChild: Container(
                  padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02),
                  // alignment:Alignment.centerRight,
                  // color: Colors.blue,
                  width: Screens.width(context) * 0.25,
                  child: Column(
                    children: [
                      Text(
                        context.read<QuotestabController>().config.alignDate2(
                              "${context.read<QuotestabController>().getleadDeatilsQTHData![0].OrderCreatedDate}",
                            ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText2,
                      ),
                    ],
                  )),
            ),
          ],
        );
      } else if (index ==
          context.read<QuotestabController>().getleadDeatilsLeadData.length -
              1) {
        log("2");
        return Column(
          children: [
            TimelineTile(
              isLast: true,
              lineXY: 0.2,
              alignment: TimelineAlign.manual,
              indicatorStyle: IndicatorStyle(
                width: 30,
                color: theme.primaryColor,
                // indicatorXY: 0.7,
                padding: EdgeInsets.all(4),
                // iconStyle: IconStyle(
                //   color: Colors.white,
                //   iconData: context
                //               .read<QuotestabController>()
                //               .getleadDeatilsLeadData[index]
                //               .FollowMode ==
                //           'Phone Call'
                //       ? Icons.call
                //       : context
                //                   .read<QuotestabController>()
                //                   .getleadDeatilsLeadData[index]
                //                   .FollowMode ==
                //               'Sms/WhatsApp'
                //           ? Icons.abc
                //           : context
                //                       .read<QuotestabController>()
                //                       .getleadDeatilsLeadData[index]
                //                       .FollowMode ==
                //                   'Store Visit'
                //               ? Icons.store
                //               : Icons.chat,
                // ),
              ),
              beforeLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              afterLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              endChild: Container(
                alignment: Alignment.centerLeft,
                width: Screens.width(context) * 0.6,
                padding: EdgeInsets.only(
                    left: Screens.width(context) * 0.02,
                    right: Screens.width(context) * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     "${context.read<QuotestabController>().getleadDeatilsLeadData[index].Status} ",
                    //     style: theme.textTheme.bodyText2,
                    //   ),
                    // ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     // context.read<QuotestabController>().config.alignDate(
                    //     "By ${context.read<QuotestabController>().getleadDeatilsLeadData[index].UpdatedBy} through ${context.read<QuotestabController>().getleadDeatilsLeadData[index].FollowMode}", //),
                    //     style: theme.textTheme.bodyText2?.copyWith(
                    //         // color: theme.primaryColor,
                    //         ),
                    //   ),
                    // ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    // context
                    //         .watch<QuotestabController>()
                    //         .getleadDeatilsLeadData[index]
                    //         .Feedback!
                    //         .isEmpty
                    //     ? SizedBox()
                    //     : Container(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           // context.read<QuotestabController>().config.alignDate(
                    //           "# ${context.read<QuotestabController>().getleadDeatilsLeadData[index].Feedback}",
                    //           style: theme.textTheme.bodyText2?.copyWith(
                    //               // color: theme.primaryColor,
                    //               ),
                    //         ),
                    //       ),
                  ],
                ),
              ),
              startChild: Container(
                  padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02),
                  width: Screens.width(context) * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Text(
                        context.read<QuotestabController>().config.alignDate2(
                              "",
                            ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText2,
                      ),
                    ],
                  )),
            ),
          ],
        );
      } else {
        log("3");
        return Column(
          children: [
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.2,
              indicatorStyle: IndicatorStyle(
                width: 30,
                color: theme.primaryColor,
                //   indicatorXY:  0.7,
                padding: EdgeInsets.all(4),
                // iconStyle: IconStyle(
                //   color: Colors.white,
                //   iconData: context
                //               .read<QuotestabController>()
                //               .getleadDeatilsLeadData[index]
                //               .FollowMode ==
                //           'Phone Call'
                //       ? Icons.call
                //       : context
                //                   .read<QuotestabController>()
                //                   .getleadDeatilsLeadData[index]
                //                   .FollowMode ==
                //               'Sms/WhatsApp'
                //           ? Icons.abc
                //           : context
                //                       .read<QuotestabController>()
                //                       .getleadDeatilsLeadData[index]
                //                       .FollowMode ==
                //                   'Store Visit'
                //               ? Icons.store
                //               : Icons.chat,
                // ),
              ),
              beforeLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              afterLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              endChild: Container(
                // color: Colors.red,
                width: Screens.width(context) * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     "${context.read<QuotestabController>().getleadDeatilsLeadData[index].Status} ",
                    //     style: theme.textTheme.bodyText2,
                    //   ),
                    // ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     // context.read<QuotestabController>().config.alignDate(
                    //     "By ${context.read<QuotestabController>().getleadDeatilsLeadData[index].UpdatedBy} through ${context.read<QuotestabController>().getleadDeatilsLeadData[index].FollowMode}", //),
                    //     style: theme.textTheme.bodyText2?.copyWith(
                    //         // color: theme.primaryColor,
                    //         ),
                    //   ),
                    // ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    // context
                    //         .watch<QuotestabController>()
                    //         .getleadDeatilsLeadData[index]
                    //         .Feedback!
                    //         .isEmpty
                    //     ? SizedBox()
                    //     : Container(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           // context.read<QuotestabController>().config.alignDate(
                    //           "# ${context.read<QuotestabController>().getleadDeatilsLeadData[index].Feedback}",
                    //           style: theme.textTheme.bodyText2?.copyWith(
                    //               // color: theme.primaryColor,
                    //               ),
                    //         ),
                    //       ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              startChild: Container(
                  //  color: Colors.red,
                  padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02),
                  width: Screens.width(context) * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.read<QuotestabController>().config.alignDate2(
                              "",
                            ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText2,
                      ),
                    ],
                  )),
            ),
          ],
        );
      }
    });
  }

  //forwar dialog

  Container forwardDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      //  height: Screens.bodyheight(context)*0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(
        left: Screens.width(context) * 0.05,
        right: Screens.width(context) * 0.05,
        top: Screens.bodyheight(context) * 0.03,
        bottom: Screens.bodyheight(context) * 0.03,
      ),
      //  height: Screens.bodyheight(context) * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          //  Expanded(
          //        child: ListView.builder(
          //          itemCount: 1,
          //          itemBuilder: (BuildContext context, int index) {
          //            return
          //             Wrap(
          //           spacing: 10.0, // gap between adjacent chips
          //           runSpacing: 10.0, // gap between lines
          //           children:
          //               listContainersProduct(theme,
          //                ));
          //          },
          //        ),
          //  ),
          // Wrap(
          //     spacing: 5.0, // gap between adjacent chips
          //     runSpacing: 5.0, // gap between lines
          //     children: listContainersProduct(
          //       theme,
          //     )),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //         child: Text(
          //       context
          //           .watch<QuotestabController>()
          //           .getforwardNextFollowDate!, // "Next Follow up",
          //       style: theme.textTheme.bodyText2?.copyWith(
          //         color: context
          //                 .watch<QuotestabController>()
          //                 .getforwardNextFollowDate!
          //                 .contains(" *")
          //             ? Colors.red
          //             : Colors.grey,
          //       ), // fontSize: 12
          //     )),
          //     InkWell(
          //       onTap: () {
          //         context
          //             .read<QuotestabController>()
          //             .showForwardNextDate(context);
          //       },
          //       child: Container(
          //         padding: EdgeInsets.symmetric(
          //             horizontal: Screens.width(context) * 0.015),
          //         width: Screens.width(context) * 0.5,
          //         height: Screens.bodyheight(context) * 0.05,
          //         decoration: BoxDecoration(
          //             border: Border.all(color: Colors.grey),
          //             borderRadius: BorderRadius.circular(4)),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Container(
          //               width: Screens.width(context) * 0.3,
          //               // color: Colors.red,
          //               child: Text(
          //                 context
          //                     .watch<QuotestabController>()
          //                     .getforwardnextWonFD,
          //                 // context.read<QuotestabController>().getnextFD,
          //                 style: theme.textTheme.bodyText2
          //                     ?.copyWith(), //fontSize: 12
          //               ),
          //             ),
          //             Container(
          //               alignment: Alignment.centerRight,
          //               width: Screens.width(context) * 0.15,
          //               // color: Colors.red,
          //               child: Icon(
          //                 Icons.calendar_month,
          //                 // size: Screens.,
          //                 color: theme.primaryColor,
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: Screens.bodyheight(context) * 0.01,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       width: Screens.width(context) * 0.26,
          //       height: Screens.bodyheight(context) * 0.06,
          //       child: ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.all(Radius.circular(6))),
          //           ),
          //           onPressed: () {
          //             setState(() {
          //               context.read<QuotestabController>().forwardClicked();
          //             });
          //           },
          //           child: Text("Back")),
          //     ),
          //     Container(
          //       width: Screens.width(context) * 0.26,
          //       height: Screens.bodyheight(context) * 0.06,
          //       child: ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.all(Radius.circular(6))),
          //           ),
          //           onPressed: () {
          //             if (context
          //                 .read<QuotestabController>()
          //                 .selectedUserList
          //                 .isNotEmpty) {
          //               context.read<QuotestabController>().forwardApi(
          //                   context
          //                       .read<QuotestabController>()
          //                       .getAllLeadData[widget.index]
          //                       .FollowupEntry
          //                       .toString(),
          //                   int.parse(context
          //                       .read<QuotestabController>()
          //                       .selectedUserList));
          //             }
          //           },
          //           child: Text("Forward")),
          //     ),
          //   ],
          // )
       
        ],
      ),
    );
  }

  // List<Widget> listContainersProduct(ThemeData theme) {
  //   return List.generate(
  //     context.watch<QuotestabController>().getuserLtData.length,
  //     (ind) => GestureDetector(
  //       onTap: () {
  //         context.read<QuotestabController>().getSelectedUserSalesEmpId(ind);
  //       },
  //       child: Container(
  //         width: Screens.width(context) * 0.4,
  //         padding: EdgeInsets.all(5),
  //         decoration: BoxDecoration(
  //             color: context
  //                         .watch<QuotestabController>()
  //                         .getuserLtData[ind]
  //                         .color ==
  //                     1
  //                 ? theme.primaryColor
  //                 : Colors.white,
  //             border: Border.all(color: theme.primaryColor, width: 1),
  //             borderRadius: BorderRadius.circular(5)),
  //         child: Text(
  //             context.watch<QuotestabController>().getuserLtData[ind].UserName!,
  //             textAlign: TextAlign.center,
  //             style: theme.textTheme.bodyText1?.copyWith(
  //               fontWeight: FontWeight.normal,
  //               fontSize: 12,
  //               color: context
  //                           .watch<QuotestabController>()
  //                           .getuserLtData[ind]
  //                           .color ==
  //                       1
  //                   ? Colors.white
  //                   : theme.primaryColor,
  //             )),
  //       ),
  //     ),
  //   );
  // }

}
