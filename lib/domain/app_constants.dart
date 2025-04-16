
import '../data/model/cat_model.dart';

class AppConstants {
  static final String app_name= "Expense_Tracker";
  static final String app_tag_line = "Save Your Money";
  static List<Cat_Models> mCategories=[

    Cat_Models(id: 1, name: "Cinema", imgURL: "assets/images/Cinema.png"),
    Cat_Models(id: 2, name: "Fruits", imgURL: "assets/images/Fruits.png" ),
    Cat_Models(id: 3, name: "Hospital_Bill", imgURL: "assets/images/hospital_bill.png"),
    Cat_Models(id: 4, name: "Shopping", imgURL: "assets/images/shop.png"),
    Cat_Models(id: 5, name: "Travelling", imgURL: "assets/images/travel.png"),
    Cat_Models(id: 6, name: "Travelling Bags", imgURL: "assets/images/travelling.jfif"),

  ];

}