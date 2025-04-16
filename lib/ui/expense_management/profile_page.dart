import 'package:expense_app_using_bloc/domain/app_colors.dart';
import 'package:expense_app_using_bloc/ui/user_on_board/login_page.dart';
import 'package:expense_app_using_bloc/ui/user_on_board/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/app_widgts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            color: AppColors.profileColor,
            child: Column(
              children: [
                SizedBox(height: 10,),
                ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/images/childNew.png"),),
                  title: Text("Usename",style:mTextStyle12(mColor: Colors.grey)),
                  subtitle: Text("Khushi Sharma",style: mTextStyle16(),),
                  trailing: Icon(Icons.edit_outlined),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding:  EdgeInsets.all(10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                       mProfileListTile(
                         mIconData: Icons.account_balance_wallet_sharp,
                         mTitle: "Account",
                       ),
                        SizedBox(height: 10,),
                        mProfileListTile(
                          mIconData: Icons.settings,
                          mTitle: "Settings",
                        ),
                        SizedBox(height: 10,),
                        mProfileListTile(
                          mIconData: Icons.import_export,
                          mTitle: "Export Data",
                        ),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: () async{

                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return RegisterPage();
                            }));
                            SharedPreferences pref= await SharedPreferences.getInstance();
                            pref.setInt(LoginPage.Login_Value, 0);
                          },
                          child: mProfileListTile(
                            mIconData: Icons.account_balance_wallet_sharp,
                            mTitle: "Logout",
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          )),
    );
  }
}
