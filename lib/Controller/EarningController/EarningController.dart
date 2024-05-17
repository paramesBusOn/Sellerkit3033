import 'dart:developer';

import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/EarningModel/Earning2Model.dart';
import 'package:sellerkit/Models/EarningModel/EraningModel1.dart';
import 'package:flutter/material.dart';
import 'package:sellerkit/Services/EarningAPI/Earning2API.dart';
import '../../Services/EarningAPI/EarningAPI.dart';

class EarningController extends ChangeNotifier {
  EarningController() {
    callEarningApi();
    cleardata();
  }
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => new GlobalKey<FormState>());
  List<TextEditingController> dateController =
      List.generate(5, (i) => TextEditingController());
 EarningData1? earningData1 ;
  EarningData1? get getearningData1 => earningData1;
  List<EarningData2> earningtableData1 = [];
  List<EarningData2> get getearningtableData1 => earningtableData1;
  List<EarningData2> earningloadData = [];
  List<EarningData2> get getearningloadData => earningloadData;

  bool fromerrortextfield = false;
  bool get getfrmerrortextfield => fromerrortextfield;
  bool toerrortextfield = false;
  bool get gettoerrortextfield => toerrortextfield;

  String apiFromDate = '';
  String apiToDate = '';

  String earningexp = '';
  String get getearningexp => earningexp;

  bool isloading = true;
  bool get getisloading => isloading;

  bool loaddata = false;
  bool get getloaddata => loaddata;

  bool btnLoadingProgress = false;
  bool get getbtnLoadingProgress => btnLoadingProgress;
String apiToDate2='';
  callEarningApi() async {
    await Earning1Api.getEarningData().then((value) => {
          isloading = false,
          if (value.stcode! >= 200 && value.stcode! <= 210)
            {
              if (value.earning1data != null)
                {
                  earningData1 = value.earning1data!,
                  print(
                      "earningData1[0].monthEarning:${earningData1!.monthEarning}"),
                  notifyListeners(),
                }
              else if (value.earning1data == null)
                {
                  earningexp = 'No  Data in Earning1 earningtable Api..!!',
                  isloading = false,
                  notifyListeners(),
                }
            }
          else if (value.stcode! >= 400 && value.stcode! <= 410)
            {
              isloading = false,
              earningexp = 'Some thing went wrong in earningTable Api..!!',
              notifyListeners(),
            }
          else if (value.stcode == 500)
            {
              if (value.exception == 'No route to host')
                {
                  earningexp = 'Check your Internet Connection...!!',
                  isloading = false,
                  notifyListeners(),
                }
              else
                {
                  earningexp = 'Something went wrong try again ...!!',
                  isloading = false,
                  notifyListeners(),
                }
            }
        });
    notifyListeners();
    Config config2 =  Config();
apiFromDate=config2.currentDate();
apiToDate=config2.firstDate();
// apiToDate2=
// log("message2222"+apiToDate2.toString());
    await EarningtableApi.getEarningtableData(apiFromDate, apiToDate)
        .then((value) => {
              if (value.stcode! >= 200 && value.stcode! <= 210)
                {
                  if (value.earningtabledata != null)
                    {
                      earningtableData1 = value.earningtabledata!,
                      print(
                          "earningtableData1[0].transDetails:${earningtableData1[0].transDetails}"),
                      notifyListeners(),
                    }
                  else if (value.earningtabledata == null)
                    {
                      earningexp = 'No  Data in Earning2 table Api..!!',
                      isloading = false,
                      notifyListeners(),
                    }
                }
              else if (value.stcode! >= 400 && value.stcode! <= 410)
                {
                  isloading = false,
                  earningexp = 'Some thing went wrong in Earning2 Api..!!',
                  notifyListeners(),
                }
              else if (value.stcode == 500)
                {
                  if (value.exception == 'No route to host')
                    {
                      earningexp = 'Check your Internet Connection...!!',
                      isloading = false,
                      notifyListeners(),
                    }
                  else
                    {
                      earningexp = 'Something went wrong try again ...!!',
                      isloading = false,
                      notifyListeners(),
                    }
                }
            });
    notifyListeners();
  }

  callLoaddata() async {
    await EarningtableApi.getEarningtableData(apiFromDate, apiToDate)
        .then((value) => {
              isloading = false,
              if (value.stcode! >= 200 && value.stcode! <= 210)
                {
                  if (value.earningtabledata != null)
                    {
                      earningloadData = value.earningtabledata!,

                      // loadedDateOnly=value.earningtabledata[]
                      notifyListeners(),

                      print(
                          "earningloadData qqqqqqs:${earningloadData[0].transDetails}"),
                    }
                  else if (value.earningtabledata == null)
                    {
                      earningexp = 'No  Data in Earning2 table Api..!!',
                      isloading = false,
                      notifyListeners(),
                    }
                }
              else if (value.stcode! >= 400 && value.stcode! <= 410)
                {
                  isloading = false,
                  earningexp = 'Some thing went wrong in Earning2 Api..!!',
                  notifyListeners(),
                }
              else if (value.stcode == 500)
                {
                  if (value.exception == 'No route to host')
                    {
                      earningexp = 'Check your Internet Connection...!!',
                      isloading = false,
                      notifyListeners(),
                    }
                  else
                    {
                      earningexp = 'Something went wrong try again ...!!',
                      isloading = false,
                      notifyListeners(),
                    }
                }
            });
  }

  loadBtnClick() {
//  if( formkey[1].currentState!.validate()){
    if (dateController[2].text.isNotEmpty &&
        dateController[3].text.isNotEmpty) {
      btnLoadingProgress = true;
      fromerrortextfield = false;
      toerrortextfield = false;
      Future.delayed(Duration(seconds: 1), () {
        btnLoadingProgress = false;
        callLoaddata();

        notifyListeners();
      });
 notifyListeners();
    } else if (dateController[2].text.isEmpty &&
        dateController[3].text.isEmpty) {
      fromerrortextfield = true;
      toerrortextfield = true;
      notifyListeners();
    } else if (dateController[2].text.isEmpty &&
        dateController[3].text.isNotEmpty) {
      fromerrortextfield = true;
      toerrortextfield = false;
      notifyListeners();
    } else if (dateController[3].text.isEmpty &&
        dateController[2].text.isNotEmpty) {
      toerrortextfield = true;
      fromerrortextfield = false;

      notifyListeners();
    }
    notifyListeners();
  }

  cleardata() {
    earningtableData1.clear();
    earningData1 =null;
    earningexp = '';
    isloading = true;
    fromerrortextfield=false;
    toerrortextfield=false;
    notifyListeners();
  }

  Future<void> refreshData() async {
    //  earningData1.clear();
    earningtableData1.clear();
    earningloadData.clear();
    callEarningApi();
    callLoaddata();
    notifyListeners();
  }

  loadDataClear() {
    apiFromDate = '';
    apiToDate = '';
    dateController[2].text = '';
    dateController[3].text = '';
    loaddata = false;
    earningloadData.clear();
    notifyListeners();
  }

  void showFromDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiFromDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiFromDate);

      dateController[2].text = chooseddate;
      notifyListeners();
    });
  }

  void showToDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiToDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiToDate);

      dateController[3].text = chooseddate;
      notifyListeners();
    });
  }

  String currentDate() {
    DateTime now = DateTime.now();

    String currentDateTime =
        "${now.day.toString()}-${now.month.toString().padLeft(2, '0')}-${now.year.toString().padLeft(2, '0')}";
    print("date: " + currentDateTime.toString());
    return currentDateTime;
  }

  String loadedDateOnly(String dateapi) {
    var now = DateTime.parse(dateapi);

    String loadDateTime =
        "${now.day.toString()}-${now.month.toString().padLeft(2, '0')}-${now.year.toString().padLeft(2, '0')}";
    print("datewwww: $loadDateTime");
    return loadDateTime;
  }
}
