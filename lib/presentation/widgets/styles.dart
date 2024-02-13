import 'package:flutter/material.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';

class Styles {
  // *****************************************************************************************************************************

  // form filed style

  // *****************************************************************************************************************************
  formDecorationStyle({required String labelText, required Icon icon}) {
    return InputDecoration(
      border: InputBorder.none,
      fillColor: const Color.fromARGB(255, 242, 242, 242),
      filled: true,
      labelText: labelText,
      labelStyle: const TextStyle(
          color: Color.fromARGB(255, 111, 111, 111), fontSize: 16),
      prefixIcon: icon,
    );
  }

  formDecorationStyleWithSufix(
      {required String labelText, required Icon icon, required Widget sufix}) {
    return InputDecoration(
      border: InputBorder.none,
      fillColor: const Color.fromARGB(255, 242, 242, 242),
      filled: true,
      labelText: labelText,
      labelStyle: const TextStyle(
          color: Color.fromARGB(255, 111, 111, 111), fontSize: 16),
      prefixIcon: icon,
      suffix: SizedBox(
        height: 15,
        width: 15,
        child: sufix)
    );
  }

  formTextStyle(BuildContext context) {
    return TextStyle(
      color: MediaQuery.of(context).platformBrightness == Brightness.light
          ? Colors.black
          : Colors.black,
      fontSize: 16,
    );
  }

  // *****************************************************************************************************************************

  //  forgot password style

  // *****************************************************************************************************************************

  passwordTextStyle() {
    return const TextStyle(
        color: Colors.grey, decoration: TextDecoration.underline);
  }
  // *****************************************************************************************************************************

  //  link text with colored letters

  // *****************************************************************************************************************************

  linkTextColorStyle(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall!.copyWith(
        color: ConstColors().mainColorpurple,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold);
  }

  // *****************************************************************************************************************************

  // evevated button style

  // *****************************************************************************************************************************

  elevatedButtonDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      gradient: LinearGradient(
        colors: [
          ConstColors().mainColorpurple,
          ConstColors().main2Colorpur,
        ],
      ),
    );
  }
 


  elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, shadowColor: Colors.transparent);
  }

  elevatedButtonTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge;
  }
  elevatedButtonBorderOnlyTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall;
  }





  elevatedButtonBorderOnlyStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
        backgroundColor:MediaQuery.of(context).platformBrightness==Brightness.light ? Colors.black : Colors.white);
  }
  // *****************************************************************************************************************************

  // next button style

  // *****************************************************************************************************************************

  customNextButtonDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      gradient: LinearGradient(
        colors: [
          ConstColors().mainColorpurple,
          ConstColors().main2Colorpur,
        ],
      ),
    );
  }

  customNextButtonChild() {
    return const Icon(
      Icons.navigate_next_outlined,
      color: Colors.white,
      size: 30,
    );
  }

  // *****************************************************************************************************************************

  // google Auth button style

  // *****************************************************************************************************************************

  googleAuthButtonDecoration() {
    return BoxDecoration(
      border:
          Border.all(color: const Color.fromARGB(255, 214, 214, 214), width: 2),
      borderRadius: BorderRadius.circular(10),
    );
  }

  // *****************************************************************************************************************************

  // rounded add button

  // *****************************************************************************************************************************

  roundedAddButtonChild() {
    return const Icon(
      Icons.add,
      color: Colors.white,
      size: 30,
    );
  }

  // *****************************************************************************************************************************

  // image container

  // *****************************************************************************************************************************

  imageContainerDecrationWithImage(String image) {
    return BoxDecoration(
        image: DecorationImage(image: NetworkImage(image),fit: BoxFit.fill),
        color: ConstColors().mainColorpurple.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(20)));
  }
  imageContainerDecrationWithOutImage() {
    return BoxDecoration(
        color: ConstColors().mainColorpurple.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(20)));
  }

  // *****************************************************************************************************************************

  // edit and delete button

  // ****************************************************************************************************************************

  deleteElevatedButtonStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 224, 13, 13));
  }

  deleteButtonTextStyle(BuildContext context) {
    return const TextStyle(color: Colors.white);
  }

  editElevatedButtonStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255));
  }

  editButtonTextStyle(BuildContext context) {
    return const TextStyle(color: Colors.black);
  }
}
