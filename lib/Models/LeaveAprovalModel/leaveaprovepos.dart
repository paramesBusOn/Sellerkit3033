

import 'dart:convert';
import 'dart:developer';

class leaveAproPostmodel {
leavepostdetails? leavereqpostdetails;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  leaveAproPostmodel(
      {required this.leavereqpostdetails,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory leaveAproPostmodel.fromJson(Map<String,dynamic> jsons,int stcode) {
    if ( jsons != null && jsons.isNotEmpty) {
      return leaveAproPostmodel(
        leavereqpostdetails: leavepostdetails.fromJson(jsons),
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
     
    }

     else {
      return leaveAproPostmodel(
        leavereqpostdetails: null,
        message: "Error",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory leaveAproPostmodel.error(String jsons,int stcode) {
    return leaveAproPostmodel(
        leavereqpostdetails: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class leavepostdetails {
  leavepostdetails({
    required this.enddate,
    required this.halfday,
    required this.id,
    required this.leavereqtype,
    required this.leavetype,
    required this.noofleavereq,
    required this.reason,
    required this.reportingto,
    required this.slpcode,
    required this.startdate,
    required this.status

   
  });

  
  int? id;
  String? slpcode;
  String? reportingto;
  String? leavereqtype;
  String? leavetype;
  String? startdate;
  String? enddate;
  String? halfday;
  int? noofleavereq;
  String? reason;
  int? status;


  
  
  factory leavepostdetails.fromJson(Map<String, dynamic> json) =>
  leavepostdetails(
    enddate: json['endDate'], 
    halfday: json['halfDay'], 
    id: json['id'], 
    leavereqtype: json['leaveRequestType'], 
    leavetype: json['leavetype'], 
    noofleavereq: json['noOfleaveReqDays'], 
    reason: json['reason'], 
    reportingto: json['reportingTo'], 
    slpcode: json['slpCode'], 
    startdate: json['startDate'], 
    status: json['status']
    );
   
}