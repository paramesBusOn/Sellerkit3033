// ignore_for_file: avoid_print, unnecessary_string_interpolations, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/SettlementModel/SettleGetAccountModel.dart';
import 'package:sellerkit/Models/SettlementModel/SettlementGetModel.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/CardSavePop.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/CashSavePop.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/ChequeSavePop.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/NEFTSavePop.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/SettCardSuccessBox%20.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/SettChequeSuccessBox.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/SettNEFTSuccessBox.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/SettUPISuccessBox.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/SettlementSuccessBox.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/UPISavePop.dart';
import 'package:sellerkit/Services/SettlementApi/SettlementGetAccountApi.dart';
import 'package:sellerkit/Services/SettlementApi/SettlementGetApi.dart';
import 'package:sellerkit/Services/SettlementApi/SettlementPostApi.dart';
import 'package:sellerkit/Widgets/SucessDialagBox.dart';

import '../../Pages/Settlement/Widgets/SettlementPdfHelper.dart';
import '../../Services/customerdetApi/customerdetApi.dart';


class SettlementController extends ChangeNotifier {
  init(BuildContext context) {
    clearAll();
    getApi();
   
    callcustCompnyapi(context);
    // SplitMethod();
  }

  List<GetBAnkAccountData> accountData = [];
  getAccountdetails(BuildContext context) async {
    log("hiiiii");
    await GetAccountDetailsApi.getData().then((value) {
      if (value.stcode! <= 210 && value.stcode! >= 200) {
        if (value.accountkdata != null) {
          accountData = value.accountkdata!;
        } else {
          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: 'Settlement account Details Not Found..',
                );
              });
        }
      } else if (value.stcode! <= 410 && value.stcode! >= 400) {
        showDialog<dynamic>(
            context: context,
            builder: (_) {
              return SuccessDialogPG(
                heading: 'Response',
                msg: '${value.message} ${value.exception}',
              );
            });
      } else {
        showDialog<dynamic>(
            context: context,
            builder: (_) {
              return SuccessDialogPG(
                heading: 'Response',
                msg: '${value.stcode}..Network Issue..\nTry again Later..!',
              );
            });
      }
    });
  }
customerdetData? frmAddmodeldata;

  callcustCompnyapi(BuildContext context) async {
    await customerDetailApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        frmAddmodeldata = value.leadcheckdata;
        notifyListeners();
      }
    });
    await   getAccountdetails(context);
    notifyListeners();
  }
  List<TextEditingController> mycontroller =
      List.generate(35, (i) => TextEditingController());
  clearAll() {
    settelGetList = [];
    settelGetListCash = [];
    settelGetListCard = [];
    settelGetListCheque = [];
    settelGetListUPI = [];
    settelGetListNEFT = [];
    errormsg = '';
    progress = false;
    mycontroller[1].text = '';
    mycontroller[2].text = '';
    mycontroller[3].text = '';
    mycontroller[4].text = '';
    mycontroller[5].text = '';

    notifyListeners();
  }

  bool progress = false;

  Config config = new Config();
  List<SettlementGetData> settelGetList = [];
  List<SettlementGetData> settelGetListCash = [];
  List<SettlementGetData> settelGetListCard = [];
  List<SettlementGetData> settelGetListCheque = [];
  List<SettlementGetData> settelGetListUPI = [];
  List<SettlementGetData> settelGetListNEFT = [];
  String? errormsg = '';
  
String lottie='';
  getApi() async {
    progress = true;
    lottie='';
    await SettlementGetApi.getdata().then((value) async {
      if (value.stcode! <= 210 && value.stcode! >= 200) {
        if (value.datadetail != null) {
          settelGetList = value.datadetail!;
          await splitData(settelGetList);
        } else {
          lottie='Assets/no-data.png';
          errormsg = 'No Data';
          progress = false;
        }
      } else if (value.stcode! <= 410 && value.stcode! >= 400) {
        lottie='';
        errormsg = '${value.respDesc}';
        progress = false;
      } else if (value.stcode == 500) {
          lottie='Assets/NetworkAnimation.json';
        errormsg = '${value.stcode}..Network Issue..\nTry again Later..!';
        progress = false;
      }
    });
    
    notifyListeners();
  }

  splitData(List<SettlementGetData> settlementList) {

    // SettlementPdfHelper.assignedTo = settlementList[0].AssignedTo;
    for (int i = 0; i < settlementList.length; i++) {
      if (settlementList[i].Mode == 'Cash') {
        settelGetListCash.add(SettlementGetData(
            isselect: false,
            DocNum: settlementList[i].DocNum,
            DocDate: settlementList[i].DocDate,
            CustomerCode: settlementList[i].CustomerCode,
            CustomerName: settlementList[i].CustomerName,
            CustomerMobile: settlementList[i].CustomerMobile,
            StoreCode: settlementList[i].StoreCode,
            AssignedTo: settlementList[i].AssignedTo,
            Amount: settlementList[i].Amount,
            DocType: settlementList[i].DocType,
            Mode: settlementList[i].Mode,
            CancelledDate: settlementList[i].CancelledDate,
            CancelledBy: settlementList[i].CancelledBy,
            CancelledRemarks: settlementList[i].CancelledRemarks,
            CreatedBy: settlementList[i].CreatedBy,
            CreatedOn: settlementList[i].CreatedOn,
            UpdatedBy: settlementList[i].UpdatedBy,
            UpdatedOn: settlementList[i].UpdatedOn,
            traceid: settlementList[i].traceid,
            docentry: settlementList[i].docentry,
            totalAmount: settlementList[i].totalAmount,
            ref: settlementList[i].ref));
      } else if (settlementList[i].Mode == 'Cheque') {
        settelGetListCheque.add(SettlementGetData(
            docentry: settlementList[i].docentry,
            isselect: false,
            DocNum: settlementList[i].DocNum,
            DocDate: settlementList[i].DocDate,
            CustomerCode: settlementList[i].CustomerCode,
            CustomerName: settlementList[i].CustomerName,
            CustomerMobile: settlementList[i].CustomerMobile,
            StoreCode: settlementList[i].StoreCode,
            AssignedTo: settlementList[i].AssignedTo,
            Amount: settlementList[i].Amount,
            DocType: settlementList[i].DocType,
            Mode: settlementList[i].Mode,
            CancelledDate: settlementList[i].CancelledDate,
            CancelledBy: settlementList[i].CancelledBy,
            CancelledRemarks: settlementList[i].CancelledRemarks,
            CreatedBy: settlementList[i].CreatedBy,
            CreatedOn: settlementList[i].CreatedOn,
            UpdatedBy: settlementList[i].UpdatedBy,
            UpdatedOn: settlementList[i].UpdatedOn,
            traceid: settlementList[i].traceid,
            totalAmount: settlementList[i].totalAmount,
            ref: settlementList[i].ref));
      } else if (settlementList[i].Mode == 'Card') {
        settelGetListCard.add(SettlementGetData(
            docentry: settlementList[i].docentry,
            isselect: false,
            DocNum: settlementList[i].DocNum,
            DocDate: settlementList[i].DocDate,
            CustomerCode: settlementList[i].CustomerCode,
            CustomerName: settlementList[i].CustomerName,
            CustomerMobile: settlementList[i].CustomerMobile,
            StoreCode: settlementList[i].StoreCode,
            AssignedTo: settlementList[i].AssignedTo,
            Amount: settlementList[i].Amount,
            DocType: settlementList[i].DocType,
            Mode: settlementList[i].Mode,
            CancelledDate: settlementList[i].CancelledDate,
            CancelledBy: settlementList[i].CancelledBy,
            CancelledRemarks: settlementList[i].CancelledRemarks,
            CreatedBy: settlementList[i].CreatedBy,
            CreatedOn: settlementList[i].CreatedOn,
            UpdatedBy: settlementList[i].UpdatedBy,
            UpdatedOn: settlementList[i].UpdatedOn,
            traceid: settlementList[i].traceid,
            totalAmount: settlementList[i].totalAmount,
            ref: settlementList[i].ref));
      } else if (settlementList[i].Mode == 'UPI') {
        settelGetListUPI.add(SettlementGetData(
            docentry: settlementList[i].docentry,
            isselect: false,
            DocNum: settlementList[i].DocNum,
            DocDate: settlementList[i].DocDate,
            CustomerCode: settlementList[i].CustomerCode,
            CustomerName: settlementList[i].CustomerName,
            CustomerMobile: settlementList[i].CustomerMobile,
            StoreCode: settlementList[i].StoreCode,
            AssignedTo: settlementList[i].AssignedTo,
            Amount: settlementList[i].Amount,
            DocType: settlementList[i].DocType,
            Mode: settlementList[i].Mode,
            CancelledDate: settlementList[i].CancelledDate,
            CancelledBy: settlementList[i].CancelledBy,
            CancelledRemarks: settlementList[i].CancelledRemarks,
            CreatedBy: settlementList[i].CreatedBy,
            CreatedOn: settlementList[i].CreatedOn,
            UpdatedBy: settlementList[i].UpdatedBy,
            UpdatedOn: settlementList[i].UpdatedOn,
            traceid: settlementList[i].traceid,
            totalAmount: settlementList[i].totalAmount,
            ref: settlementList[i].ref));
      } else if (settlementList[i].Mode == 'NEFT') {
        settelGetListNEFT.add(SettlementGetData(
            docentry: settlementList[i].docentry,
            isselect: false,
            DocNum: settlementList[i].DocNum,
            DocDate: settlementList[i].DocDate,
            CustomerCode: settlementList[i].CustomerCode,
            CustomerName: settlementList[i].CustomerName,
            CustomerMobile: settlementList[i].CustomerMobile,
            StoreCode: settlementList[i].StoreCode,
            AssignedTo: settlementList[i].AssignedTo,
            Amount: settlementList[i].Amount,
            DocType: settlementList[i].DocType,
            Mode: settlementList[i].Mode,
            CancelledDate: settlementList[i].CancelledDate,
            CancelledBy: settlementList[i].CancelledBy,
            CancelledRemarks: settlementList[i].CancelledRemarks,
            CreatedBy: settlementList[i].CreatedBy,
            CreatedOn: settlementList[i].CreatedOn,
            UpdatedBy: settlementList[i].UpdatedBy,
            UpdatedOn: settlementList[i].UpdatedOn,
            traceid: settlementList[i].traceid,
            totalAmount: settlementList[i].totalAmount,
            ref: settlementList[i].ref));
      }
      SettlementPdfHelper.assignedTo = settlementList[0].AssignedTo;
    }
     
    progress = false;
    notifyListeners();
  }

  List<GlobalKey<FormState>> formkey =
      List.generate(5, (i) => GlobalKey<FormState>());
  List<SettlementList> settlementList = [];
  // List<SettlementList> cashList = [];
  // List<SettlementList> settelGetListCard = [];
  // List<SettlementList> settelGetListCheque = [];
  // List<SettlementList> settelGetListCheque = [];
  // List<SettlementList> settelGetListUPI = [];

  String? settleTocash;
  String? settleTocard;
  String? settleTochque;
  String? settleToUpi;
  String? settleToDD;

  // bool? isselect = false;
chooseSettleToCash(String? val) {
    settleTocash = val;
    for (var i = 0; i < accountData.length; i++) {
      if (accountData[i].code == val) {
        SettlementPdfHelper.settledTo = accountData[i].name;
        log('SettlementPdfHelper.settledTo::${SettlementPdfHelper.settledTo}');
        notifyListeners();
      }
    }
    notifyListeners();
  }

  chooseSettleToCard(String? val) {
    settleTocard = val;

    for (var i = 0; i < accountData.length; i++) {
      if (accountData[i].code == val) {
        SettlementPdfHelper.settledTo = accountData[i].name;
        log('  SettlementPdfHelper.settledTo::${SettlementPdfHelper.settledTo}');
        notifyListeners();
      }
    }

    notifyListeners();
  }

  chooseSettleToCheuqe(String? val) {
    settleTochque = val;
    for (var i = 0; i < accountData.length; i++) {
      if (accountData[i].code == val) {
        SettlementPdfHelper.settledTo = accountData[i].name;
        log('  SettlementPdfHelper.settledTo::${SettlementPdfHelper.settledTo}');
        notifyListeners();
      }
    }
    notifyListeners();
  }

  chooseSettleToUPI(String? val) {
    settleToUpi = val;
    for (var i = 0; i < accountData.length; i++) {
      if (accountData[i].code == val) {
        SettlementPdfHelper.settledTo = accountData[i].name;
        log('  SettlementPdfHelper.settledTo::${SettlementPdfHelper.settledTo}');
        notifyListeners();
      }
    }
    notifyListeners();
  }

  chooseSettleToDD(String? val) {
    settleToDD = val;
    for (var i = 0; i < accountData.length; i++) {
      if (accountData[i].code == val) {
        SettlementPdfHelper.settledTo = accountData[i].name;
        log('  SettlementPdfHelper.settledTo::${SettlementPdfHelper.settledTo}');
        notifyListeners();
      }
    }
    notifyListeners();
  } validateFinalCash(BuildContext context) async {
    if (formkey[0].currentState!.validate()) {
      List<Settlelines> settlementLineList2 = [];
      for (int i = 0; i < settelGetListCash.length; i++) {
        if (settelGetListCash[i].isselect == true) {
          settlementLineList2.add(Settlelines(
              docentry: settelGetListCash[i].docentry,
              amount: settelGetListCash[i].Amount));
        }
      }

      settlePostBody? settlepost = settlePostBody(
          doctype: '01',
          depoaccount: '${settleTocash}',
          remarks: '${mycontroller[1].text.toString()}',
          settlementLineList: settlementLineList2);

      await SettlementPostApi.getCollectionData(settlepost).then((value) {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          // if (value.datadetail != null) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SettlementSuccessPage(
                        settlemaster: value.datadetail!.listofSettle![0],
                      )));
          // } else {
          //   Navigator.pop(context);

          //   showDialog<dynamic>(
          //       context: context,
          //       builder: (_) {
          //         return SuccessDialogPG(
          //           heading: 'Response',
          //           msg: '${value.stcode} ${value.respDesc}',
          //         );
          //       });
          // }
        } else if (value.stcode! <= 410 && value.stcode! >= 400) {
          Navigator.pop(context);

          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${value.respCode}..!!${value.respDesc}',
                );
              });
        } else {
          Navigator.pop(context);

          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${value.respCode}..!!${value.respDesc}',
                );
              });
        }
      });
      // Navigator.pop(context);

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => SettlementSuccessPage()));
    }
  }

  validateFinalCard(BuildContext context) async {
    if (formkey[1].currentState!.validate()) {
      List<Settlelines> settlementLineList2 = [];
      for (int i = 0; i < settelGetListCard.length; i++) {
        if (settelGetListCard[i].isselect == true) {
          settlementLineList2.add(Settlelines(
              docentry: settelGetListCard[i].docentry,
              amount: settelGetListCard[i].Amount));
        }
      }

      settlePostBody? settlepost = settlePostBody(
          doctype: '02',
          depoaccount: '${settleTocard}',
          remarks: '${mycontroller[2].text.toString()}',
          settlementLineList: settlementLineList2);

      await SettlementPostApi.getCollectionData(settlepost).then((value) {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          // if (value.datadetail != null) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SettlementSuccessCard(
                        settlemaster: value.datadetail!.listofSettle!,
                      )));
          // } else {
          //   Navigator.pop(context);

          //   showDialog<dynamic>(
          //       context: context,
          //       builder: (_) {
          //         return SuccessDialogPG(
          //           heading: 'Response',
          //           msg: '${value.stcode} ${value.respDesc}',
          //         );
          //       });
          // }
        } else if (value.stcode! <= 410 && value.stcode! >= 400) {
          Navigator.pop(context);

          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${value.respCode}..!!${value.respDesc}',
                );
              });
        } else {
          Navigator.pop(context);

          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${value.respCode}..!!${value.respDesc}',
                );
              });
        }
      }); //
      //
      // Navigator.pop(context);

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => SettlementSuccessCard()));
    }
  }

  validateFinalCheque(BuildContext context) async {
    if (formkey[2].currentState!.validate()) {
      List<Settlelines> settlementLineList2 = [];
      for (int i = 0; i < settelGetListCheque.length; i++) {
        if (settelGetListCheque[i].isselect == true) {
          settlementLineList2.add(Settlelines(
              docentry: settelGetListCheque[i].docentry,
              amount: settelGetListCheque[i].Amount));
        }
      }

      settlePostBody? settlepost = settlePostBody(
          doctype: '03',
          depoaccount: '${settleTochque}',
          remarks: '${mycontroller[3].text.toString()}',
          settlementLineList: settlementLineList2);

      await SettlementPostApi.getCollectionData(settlepost).then((value) {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          // if (value.datadetail != null) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SettlementSuccessCheque(
                        settlemaster: value.datadetail!.listofSettle![0],
                      )));
          // } else {
          //   Navigator.pop(context);

          //   showDialog<dynamic>(
          //       context: context,
          //       builder: (_) {
          //         return SuccessDialogPG(
          //           heading: 'Response',
          //           msg: '${value.stcode} ${value.respDesc}',
          //         );
          //       });
          // }
        } else if (value.stcode! <= 410 && value.stcode! >= 400) {
          Navigator.pop(context);

          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${value.respCode}..!!${value.respDesc}',
                );
              });
        } else {
          Navigator.pop(context);

          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${value.respCode}..!!${value.respDesc}',
                );
              });
        }
      }); //

      // Navigator.pop(context);

      // Navigator.push(context,
      //     MaterialPageRoute(builder: (_) => SettlementSuccessCheque()));
    }
  }

  validateFinalUpi(BuildContext context) async {
    if (formkey[3].currentState!.validate()) {
      List<Settlelines> settlementLineList2 = [];
      for (int i = 0; i < settelGetListUPI.length; i++) {
        if (settelGetListUPI[i].isselect == true) {
          settlementLineList2.add(Settlelines(
              docentry: settelGetListUPI[i].docentry,
              amount: settelGetListUPI[i].Amount));
        }
      }

      settlePostBody? settlepost = settlePostBody(
          doctype: '05',
          depoaccount: '${settleToUpi}',
          remarks: '${mycontroller[4].text.toString()}',
          settlementLineList: settlementLineList2);

      await SettlementPostApi.getCollectionData(settlepost).then((value) {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          // if (value.datadetail != null) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SettlementSuccessUPI(
                        settlemaster: value.datadetail!.listofSettle![0],
                      )));
          // } else {
          //   Navigator.pop(context);

          //   showDialog<dynamic>(
          //       context: context,
          //       builder: (_) {
          //         return SuccessDialogPG(
          //           heading: 'Response',
          //           msg: '${value.stcode} ${value.respDesc}',
          //         );
          //       });
          // }
        } else if (value.stcode! <= 410 && value.stcode! >= 400) {
          Navigator.pop(context);

          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${value.respCode}..!!${value.respDesc}',
                );
              });
        } else {
          Navigator.pop(context);

          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${value.respCode}..!!${value.respDesc}',
                );
              });
        }
      }); //
      // Navigator.pop(context);

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => SettlementSuccessUPI()));
    }
  }

  validateFinalDD(BuildContext context) async {
    if (formkey[4].currentState!.validate()) {
      List<Settlelines> settlementLineList2 = [];
      for (int i = 0; i < settelGetListNEFT.length; i++) {
        if (settelGetListNEFT[i].isselect == true) {
          settlementLineList2.add(Settlelines(
              docentry: settelGetListNEFT[i].docentry,
              amount: settelGetListNEFT[i].Amount));
        }
      }

      settlePostBody? settlepost = settlePostBody(
          doctype: '04',
          depoaccount: '${settleToDD}',
          remarks: '${mycontroller[4].text.toString()}',
          settlementLineList: settlementLineList2);

      await SettlementPostApi.getCollectionData(settlepost).then((value) {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          // if (value.datadetail != null) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SettlementSuccessDD(
                        settlemaster: value.datadetail!.listofSettle![0],
                      )));
          // } else {
          //   Navigator.pop(context);

          //   showDialog<dynamic>(
          //       context: context,
          //       builder: (_) {
          //         return SuccessDialogPG(
          //           heading: 'Response',
          //           msg: '${value.stcode} ${value.respDesc}',
          //         );
          //       });
          // }
        } else if (value.stcode! <= 410 && value.stcode! >= 400) {
          Navigator.pop(context);

          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${value.respCode}..!!${value.respDesc}',
                );
              });
        } else {
          Navigator.pop(context);

          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${value.respCode}..!!${value.respDesc}',
                );
              });
        }
      });
      //
    }
  }

  //  showDialog<dynamic>(
  //         context: context,
  //         builder: (_) {
  //           return SuccessDialogPG(
  //             heading: 'Response',
  //             msg: 'Customer Successfully Registered..!!',
  //           );
  //         });
  validateMethod(BuildContext context) {
  
     notifyListeners();
    double val = 0.00;
    for (int i = 0; i < settelGetListCash.length; i++) {
      if (settelGetListCash[i].isselect == true) {
        val = val + settelGetListCash[i].Amount;
      }
    }

    if (val == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Choose Customer..!!',
            );
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            // context.read<EnquiryUserContoller>(). showSpecificDialog();
            //   context.read<EnquiryUserContoller>().showSuccessDia();
            return CashAlertBox();
          }).then((value) {
        mycontroller[1].text = '';
      });
    }
  }

  validateMethodcard(BuildContext context) {
    double val = 0.00;
    for (int i = 0; i < settelGetListCard.length; i++) {
      if (settelGetListCard[i].isselect == true) {
        val = val + settelGetListCard[i].Amount;
      }
    }

    if (val == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Choose Customer..!!',
            );
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            // context.read<EnquiryUserContoller>(). showSpecificDialog();
            //   context.read<EnquiryUserContoller>().showSuccessDia();
            return CardAlertBox(
              indx: 1,
            );
          }).then((value) {
        mycontroller[2].text = '';
      });
    }
  }

  validateMethodcheque(BuildContext context) {
    double val = 0.00;
    for (int i = 0; i < settelGetListCheque.length; i++) {
      if (settelGetListCheque[i].isselect == true) {
        val = val + settelGetListCheque[i].Amount;
      }
    }

    if (val == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Choose Customer..!!',
            );
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            // context.read<EnquiryUserContoller>(). showSpecificDialog();
            //   context.read<EnquiryUserContoller>().showSuccessDia();
            return ChequeAlertBox(
              indx: 1,
            );
          }).then((value) {
        mycontroller[3].text = '';
      });
    }
  }

  validateMethodUpi(BuildContext context) {
    double val = 0.00;
    for (int i = 0; i < settelGetListUPI.length; i++) {
      if (settelGetListUPI[i].isselect == true) {
        val = val + settelGetListUPI[i].Amount;
      }
    }

    if (val == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Choose Customer..!!',
            );
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            // context.read<EnquiryUserContoller>(). showSpecificDialog();
            //   context.read<EnquiryUserContoller>().showSuccessDia();
            return UPIAlertBox(
              indx: 1,
            );
          }).then((value) {
        mycontroller[5].text = '';
      });
    }
  }

  validateMethodDD(BuildContext context) {
    double val = 0.00;
    for (int i = 0; i < settelGetListNEFT.length; i++) {
      if (settelGetListNEFT[i].isselect == true) {
        val = val + settelGetListNEFT[i].Amount;
      }
    }

    if (val == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Choose Customer..!!',
            );
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            // context.read<EnquiryUserContoller>(). showSpecificDialog();
            //   context.read<EnquiryUserContoller>().showSuccessDia();
            return DDAlertBox(
              indx: 1,
            );
          }).then((value) {
        mycontroller[4].text = '';
      });
    }
  }

  iselectMethodCash(int i) {
// if(cashList[i].isselect==true){

// }

    settelGetListCash[i].isselect = !settelGetListCash[i].isselect!;
    print(settelGetListCash[i].isselect);
    notifyListeners();
  }

  iselectMethodCard(int i) {
    settelGetListCard[i].isselect = !settelGetListCard[i].isselect!;
    notifyListeners();
  }

  iselectMethodCheque(int i) {
    settelGetListCheque[i].isselect = !settelGetListCheque[i].isselect!;
    notifyListeners();
  }

  iselectMethodUpi(int i) {
    settelGetListUPI[i].isselect = !settelGetListUPI[i].isselect!;
    notifyListeners();
  }

  iselectMethodDD(
    int i,
  ) {
    settelGetListNEFT[i].isselect = !settelGetListNEFT[i].isselect!;
    notifyListeners();
  }
totalcashsettl() {
    double val = 0.00;
    for (int i = 0; i < settelGetListCash.length; i++) {
      if (settelGetListCash[i].isselect == true) {
        val = val + settelGetListCash[i].Amount;
      }
    }
    SettlementPdfHelper.totalSumOfAp = val;
    return config.slpitCurrency22(val.toString());
  }

  totalCardsettl() {
    double val = 0.00;
    for (int i = 0; i < settelGetListCard.length; i++) {
      if (settelGetListCard[i].isselect == true) {
        val = val + settelGetListCard[i].Amount;
        notifyListeners();
      }
    }
    SettlementPdfHelper.totalSumOfAp = val;
    return config.slpitCurrency22(val.toString());
  }

  totalChequesettl() {
    double val = 0.00;
    for (int i = 0; i < settelGetListCheque.length; i++) {
      if (settelGetListCheque[i].isselect == true) {
        val = val + settelGetListCheque[i].Amount;
        notifyListeners();
      }
    }
    SettlementPdfHelper.totalSumOfAp = val;
    return config.slpitCurrency22(val.toString());
  }

  totalUpisettl() {
    double val = 0.00;
    for (int i = 0; i < settelGetListUPI.length; i++) {
      if (settelGetListUPI[i].isselect == true) {
        val = val + settelGetListUPI[i].Amount;
        notifyListeners();
      }
    }
    SettlementPdfHelper.totalSumOfAp = val;
    return config.slpitCurrency22(val.toString());
  }

  totalDDsettl() {
    double val = 0.00;
    for (int i = 0; i < settelGetListNEFT.length; i++) {
      if (settelGetListNEFT[i].isselect == true) {
        val = val + settelGetListNEFT[i].Amount;
        notifyListeners();
      }
    }
    SettlementPdfHelper.totalSumOfAp = val;

    return config.slpitCurrency22(val.toString());
  }
  totalcash() {
    double val = 0.00;
    for (int i = 0; i < settelGetListCash.length; i++) {
      if (settelGetListCash[i].isselect == true) {
        val = val + settelGetListCash[i].Amount;
      }
    }
    return config.slpitCurrency22(val.toString()); 
  }

  totalCard() {
    double val = 0.00;
    for (int i = 0; i < settelGetListCard.length; i++) {
      if (settelGetListCard[i].isselect == true) {
        val = val + settelGetListCard[i].Amount;
      }
    }
    return config.slpitCurrency22(val.toString());
  }

  totalCheque() {
    double val = 0.00;
    for (int i = 0; i < settelGetListCheque.length; i++) {
      if (settelGetListCheque[i].isselect == true) {
        val = val + settelGetListCheque[i].Amount;
      }
    }
    return config.slpitCurrency22(val.toString());
  }

  totalUpi() {
    double val = 0.00;
    for (int i = 0; i < settelGetListUPI.length; i++) {
      if (settelGetListUPI[i].isselect == true) {
        val = val + settelGetListUPI[i].Amount;
      }
    }
    return config.slpitCurrency22(val.toString());
  }

  totalDD() {
    double val = 0.00;
    for (int i = 0; i < settelGetListNEFT.length; i++) {
      if (settelGetListNEFT[i].isselect == true) {
        val = val + settelGetListNEFT[i].Amount;
      }
    }
    return config.slpitCurrency22(val.toString());
  }
}

class SettlementList {
  SettlementList({
    required this.cusstomer,
    required this.collectionDate,
    required this.type,
    required this.totalAmount,
    required this.typeAmount,
    required this.isselect,
  });

  String? cusstomer;
  String? collectionDate;
  String? type;
  double? totalAmount;
  double? typeAmount;
  bool? isselect;
}
