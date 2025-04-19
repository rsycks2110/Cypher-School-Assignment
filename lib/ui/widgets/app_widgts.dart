import 'dart:ui';

import 'package:flutter/material.dart';
TextStyle mTextStyle8({
  mFontSize=8,mFontWeight=FontWeight.normal,mColor=Colors.black}){
  return TextStyle(
      fontSize: mFontSize,
      fontWeight: mFontWeight,
      color: mColor
  );
}

TextStyle mTextStyle12({
  mFontSize=12,mFontWeight=FontWeight.normal,mColor=Colors.black}){
  return TextStyle(
    fontSize: mFontSize,
    fontWeight: mFontWeight,
    color: mColor
  );
}
TextStyle mTextStyle14({
  mFontSize=14,mFontWeight=FontWeight.bold,mColor=Colors.black}){
  return TextStyle(
      fontSize: mFontSize,
      fontWeight: mFontWeight,
      color: mColor
  );
}

TextStyle mTextStyle16({
  mFontSize=16,mFontWeight=FontWeight.bold,mColor=Colors.black}){
  return TextStyle(
      fontSize: mFontSize,
      fontWeight: mFontWeight,
      color: mColor
  );
}
TextStyle mTextStyle25({
  mFontSize=16,mFontWeight=FontWeight.bold,mColor=Colors.black}){
  return TextStyle(
      fontSize: mFontSize,
      fontWeight: mFontWeight,
      color: mColor
  );
}
TextStyle mTextStyle30({
  mFontSize=30,mFontWeight=FontWeight.bold,mColor=Colors.black}){
  return TextStyle(
      fontSize: mFontSize,
      fontWeight: mFontWeight,
      color: mColor
  );
}
Container mTabContainer({mColor,mWidth=70,mHeight=50}){
  return Container(
    height: mHeight,width: mWidth,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: mColor
    ),
  );
}
Container mFetchContainer({mColor=Colors.green,mIconData=Icons.camera_alt_sharp,
  mType="",mValue="",mIconColor=Colors.green,
mHeight=50,mWidth=150
}){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: mColor
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),

              padding: EdgeInsets.all(10),
                child: Icon(mIconData,size: 20,)),
          ),
          SizedBox(width: 10,),
          Column(
            //: MainAxisAlignment.start,
            children: [
              Text(mType,style: mTextStyle12(mColor: Colors.white),),
              Text(mValue,style: mTextStyle14(mColor:Colors.white ),)
            ],
          )
        ],
      ),
    ),

  );
}
TextField mTextField({
  mController="",mRadius=10,mMinLines=1,mMaxLines=2,mColor=Colors.grey,
  mHintText="Hello",mLabel="",mIcon,mSuffix,bool mShow=true
}){
return TextField(
  controller: mController,
decoration: InputDecoration(
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(mRadius),
      borderSide: BorderSide(color:mColor.withOpacity(0.5))
  ),
  disabledBorder:OutlineInputBorder(
    borderRadius: BorderRadius.circular(mRadius),
    borderSide: BorderSide(color:mColor.withOpacity(0.5))
   ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(mRadius),
      borderSide: BorderSide(color:mColor.withOpacity(0.5))
  ),
  hintText: mHintText,
  prefixIcon: mIcon,
  hintStyle: TextStyle(fontSize: 12),
  label: mLabel,
  labelStyle: TextStyle(color: mColor,fontSize: 12,fontWeight: FontWeight.normal),
  // border: OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(mRadius),
  //   borderSide: BorderSide(color: mColor,width:5)
  )
);
}
OutlinedButton mButton({VoidCallback? onTap,String? mTitle,mRadius=10,mColor=Colors.deepPurpleAccent}){
  return OutlinedButton(
      onPressed: onTap, child: Text(mTitle!,style: TextStyle(fontSize:14,color: Colors.white,fontWeight: FontWeight.bold),),
      style:OutlinedButton.styleFrom(backgroundColor:mColor,shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(mRadius))));
}

ListTile mProfileListTile({
  mRadius = 10,mColor=Colors.grey,mTitle="",mIconData=Icons.add,
  mIconColor=Colors.deepPurple
}){
  return ListTile(
    leading: Container(
      child: Icon(mIconData,color: mIconColor,size: 20,),
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(mRadius),
        color: mColor
      ),
    ),
    title: Text(mTitle,style: mTextStyle12(mFontWeight: FontWeight.bold),),
  );
}