// import 'package:movei_app/models/company_model.dart';

// class MOvieDetailsModel {
//   bool? isadult;
//   String? tagline;
//   List<Company>? company;

// MOvieDetailsModel({this.company,this.isadult,this.tagline})

// factory MOvieDetailsModel.fromJson(Map<String,dynamic> json){
//  List<Company> companies=(json['production_companies'] as List).map((company) => Company.fromJson(company)).toList();

//   return MOvieDetailsModel(
//     isadult: json['adult'],
//     company:companies,
//     tagline: json['tagline'],
//   );
// }

// }
import 'package:movei_app/models/company_model.dart';

class MovieDetailsModel {
  bool? isAdult;
  String? tagline;
  List<Company>? companies;

  MovieDetailsModel({this.companies, this.isAdult, this.tagline});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    List<Company> companies = (json['production_companies'] as List)
        .map((company) => Company.fromJson(company))
        .toList();

    return MovieDetailsModel(
      isAdult: json['adult'],
      companies: companies,
      tagline: json['tagline'],
    );
  }
}
