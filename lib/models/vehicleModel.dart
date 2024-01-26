// ignore_for_file: camel_case_types, file_names

// import 'package:breakdown_buddy/models/userModel.dart';
class vehicleDetailsModel {
  String? vehicleName;
  String? vehicleModel;
  String? vehicleNumber;
  int? year;
  String? uid;

  vehicleDetailsModel(
      {required this.uid, required this.vehicleModel,required this.vehicleName,required this.vehicleNumber,required this.year});

  //data from server
  factory vehicleDetailsModel.fromMap(map) {
    return vehicleDetailsModel(
      uid: map['uid'],
      vehicleName: map['vehicleName'],
      vehicleModel: map['vehicleModel'],
      vehicleNumber: map['vehicleNumber'],
      year: map['year'],
    );
  }

  //sending data to the server
  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'name': vehicleName,
      'model': vehicleModel,
      'number': vehicleNumber,
      'year': year,
    };
  }
}