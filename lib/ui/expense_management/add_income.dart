import 'package:expense_app_using_bloc/data/model/income_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_app_using_bloc/ui/widgets/app_widgts.dart';
import '../../data/firebase/firebase_repository.dart';
import '../../data/model/cat_model.dart';
import '../../data/model/expense_model.dart';
import '../../domain/app_colors.dart';
import '../../domain/app_constants.dart';

class AddIncome extends StatefulWidget{

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  TextEditingController descController = TextEditingController();
  TextEditingController incomeAmountController = TextEditingController();
  String catValue="Shopping";
  List<String> catItems=["Cinema","Fruits","Hospital_Bill","Shopping","Travelling","Travelling Bags"];
  String walletValue="SBI";
  List<String> walletItem=["SBI","PNB","HDFC","BOB"];
  Cat_Models? selectedCategory;


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: AppColors.incomeColor,
            child: ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:  EdgeInsets.only(left: 15,right: 15,top: 15),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              InkWell(
                                  onTap:(){
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back,color: Colors.white,)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width/2.8,
                              ),
                              Center(child: Text("Income",style: mTextStyle14(mColor: Colors.white),)),
                            ],
                          ),
                          SizedBox(height:MediaQuery.of(context).size.height*0.16,),
                          Text("How Much?",style: mTextStyle12(mColor: Colors.white),),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 100,
                            child: TextField(
                                controller: incomeAmountController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "\u{20B9}\t0",
                                  hintStyle: mTextStyle30(mColor: Colors.white,),

                                )

                            ),
                          ),

                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.6,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.vertical(top:Radius.circular(20),)
                    ),
                    child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(height:20),
                          Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 0.5,color: Colors.grey),
                                  ),
                                  child:  DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: DropdownButton<Cat_Models>(
                                        hint: Text("Category",style: TextStyle(fontSize: 12,color: Colors.grey),),
                                        value: selectedCategory,
                                        isExpanded: true,
                                        onChanged: (Cat_Models? newValue) {
                                          setState(() {
                                            selectedCategory = newValue!;
                                          });
                                        },
                                        items: AppConstants.mCategories.map((Cat_Models category) {
                                          return DropdownMenuItem<Cat_Models>(
                                            value: category,
                                            child: Row(
                                              children: [
                                                Image.asset(category.imgURL, width: 24, height: 24),
                                                SizedBox(width: 10),
                                                Text(category.name,style: TextStyle(fontSize: 12,color: Colors.grey)),
                                              ],
                                            ),
                                          );
                                        }).toList(),


                                      ),
                                    ),
                                  ),)),

                          SizedBox(height: 10,),

                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 0.5,color: Colors.grey),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: TextField(
                                    controller: descController,
                                    decoration: InputDecoration(
                                        hintText: "Description",
                                        hintStyle: mTextStyle12(mColor: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),

                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 0.5,color: Colors.grey),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: walletItem.map((each){
                                      return DropdownMenuItem(value: each,
                                          child: Text(each,style: mTextStyle12(mColor: Colors.grey),));
                                    }).toList(), onChanged: (value){
                                    walletValue=value!;
                                    setState(() {

                                    });
                                  },value: walletValue,isExpanded: true,
                                    hint: Text("Category",style: TextStyle(fontSize: 12,color: Colors.grey),),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 10,),

                          SizedBox(height:MediaQuery.of(context).size.height*0.1 ,),
                          Container(height: 0.5,width: double.infinity,
                            color: AppColors.incomeColor,
                          ),
                          SizedBox(height: 10,),
                          Padding(
                              padding:  EdgeInsets.only(left: 10,right: 10),
                              child: Container(
                                  height: 40,width: double.infinity,
                                  child: mButton(onTap: () {
                                    var newIncome= IncomeModel(
                                        cat_value: selectedCategory.toString(),
                                        income_desc: descController.text.toString(),
                                        income_createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                        income_type: walletValue,
                                        income_amount: int.parse(incomeAmountController.text));
                                    // SharedPreferences pref= await SharedPreferences.getInstance();
                                    // String? userID= pref.getString("u_id");
                                    FireBaseRepository.addIncome(newIncome);
                                    Navigator.pop(context);
                                  },mTitle: "Continue",mRadius: 10))),
                          SizedBox(height: 10,),
                          Container(height: 0.5,width: double.infinity,
                            color: AppColors.expenseColor.withOpacity(0.5),
                          ),
                        ]
                    ),
                  )
                ]),
          )),
    );
  }
}