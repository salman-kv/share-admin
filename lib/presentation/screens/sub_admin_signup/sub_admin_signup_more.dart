import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_event.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_event.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_state.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/domain/model/sub_admin_model.dart';
import 'package:share_sub_admin/presentation/alerts/snack_bars.dart';
import 'package:share_sub_admin/presentation/alerts/toasts.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_signup/sub_admin_signup_success.dart';
import 'package:share_sub_admin/presentation/widgets/commen_widget.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

// ignore: must_be_immutable
class SubAdminSignUpMoreInfo extends StatelessWidget {
  SubAdminSignUpMoreInfo({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormFieldState>();
  final phoneKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PopScope(
        canPop: true,
         onPopInvoked: (didPop) {
           GoogleSignIn().signOut();
         },
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          "Let's Complete Your profile",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'It will help us to know more about you!,',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: TextFormField(
                        key: nameKey,
                        validator: (value) {
                          if ((!RegExp(r'^\S+(?!\d+$)').hasMatch(value!))) {
                            return 'enter valid name';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          nameKey.currentState!.validate();
                        },
                        controller: nameController,
                        decoration: Styles().formDecorationStyle(
                            icon: const Icon(Icons.person_2_sharp),
                            labelText: 'Name'),
                        style: Styles().formTextStyle(context),
                      ),
                    ),
                  ),
                  // DropdownButtonHideUnderline(
                  //   child: DropdownButton2(
                  //     dropdownStyleData: DropdownStyleData(
                  //       maxHeight: 300,
                  //       width: MediaQuery.of(context).size.width * 0.9,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(14),
                  //       ),
                  //     ),
                  //     buttonStyleData: ButtonStyleData(
                  //       height: 55,
                  //       width: MediaQuery.of(context).size.width * 0.92,
                  //       padding: const EdgeInsets.only(left: 14, right: 14),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(14),
                  //         color: const Color.fromARGB(255, 242, 242, 242),
                  //       ),
                  //     ),
                  //     onChanged: (value) {},
                  //     hint: const Row(
                  //       children: [
                  //         Icon(Icons.male_outlined),
                  //         SizedBox(
                  //           width: 5,
                  //         ),
                  //         Text('Gender'),
                  //       ],
                  //     ),
                  //     items: const [
                  //       DropdownMenuItem(
                  //         value: 'Male',
                  //         child: Text('Male'),
                  //       ),
                  //       DropdownMenuItem(
                  //         value: 'Female',
                  //         child: Text('Female'),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: TextFormField(
                        key: phoneKey,
                        onChanged: (value) {
                          phoneKey.currentState!.validate();
                        },
                        validator: (value) {
                          if ((!RegExp(r'^[0-9]+\.?[0-9]*$').hasMatch(value!))) {
                            return 'enter valid Phone number';
                          } else {
                            return null;
                          }
                        },
                        controller: phoneController,
                        decoration: Styles().formDecorationStyle(
                            icon: const Icon(Icons.phone_in_talk_outlined),
                            labelText: 'Phone'),
                        style: Styles().formTextStyle(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: TextFormField(
                        key: passwordKey,
                        onChanged: (value) {
                          passwordKey.currentState!.validate();
                        },
                        validator: (value) {
                          if ((!RegExp(r'^\S+(?!\d+$)').hasMatch(value!))) {
                            return 'enter valid password';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: Styles().formDecorationStyle(
                            icon: const Icon(Icons.lock_outline_rounded),
                            labelText: 'Password'),
                        style: Styles().formTextStyle(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      XFile tempImage = await SubAdminFunction().subAdminPickImage();
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<SubAdminSignUpBloc>(context)
                          .add(OnAddSubAdminSignUpImage(image: tempImage));
                    },
                    child: const Text('Add Image'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  BlocConsumer<SubAdminSignUpBloc, SubAdminSignUpState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.6),
                              image: context.read<SubAdminSignUpBloc>().image != null
                                  ? DecorationImage(
                                      image: FileImage(File(context
                                          .watch<SubAdminSignUpBloc>()
                                          .image!
                                          .path)),
                                      fit: BoxFit.cover)
                                  : const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/profile.png')),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(20),
                            height: MediaQuery.of(context).size.width * 0.1,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: Styles().elevatedButtonDecoration(),
                            child: ElevatedButton(
                                style: Styles().elevatedButtonStyle(),
                                onPressed: () async {
                                  if (BlocProvider.of<SubAdminSignUpBloc>(context)
                                          .image ==
                                      null) {
                                    Toasts()
                                        .toastWidget('pls add profile photo');
                                    return;
                                  } else if (formKey.currentState!.validate()) {
                                    log('validate successfull');
                                    BlocProvider.of<SubAdminSignUpBloc>(context)
                                        .add(OnlyForLoadingevent());
                                    final imageUrl = await SubAdminFunction()
                                        .uploadImageToFirebase(context
                                            .read<SubAdminSignUpBloc>()
                                            .image!);
                                    // ignore: use_build_context_synchronously
                                    BlocProvider.of<SubAdminSignUpBloc>(context).add(
                                        OnVarifySubAdminDetailsEvent(
                                            userModel:SubAdminModel(
                                                // ignore: use_build_context_synchronously
                                                email: context
                                                    .read<SubAdminSignUpBloc>()
                                                    .email!,
                                                name: nameController.text,
                                                password: passwordController.text,
                                                phone: int.parse(
                                                    phoneController.text),
                                                imagePath: imageUrl,
                                                userId: ''),
                                            compire: FirebaseFirestoreConst
                                                .firebaseFireStoreEmail));
                                    // ignore: use_build_context_synchronously
                                  }
                                },
                                child: state is SubAdminSignupLoading
                                    ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : Text(
                                        'Submit',
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )),
                          ),
                        ],
                      );
                    },
                    listener: (context, state) {
                      if (state is SubAdminVerifiedWithMoredataState) {
                        context.read<SubAdminLoginBloc>().add(SubAdminAlredyLoginEvent(
                            userCredential: state.userCredential,
                            userId: state.userId));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (ctx) {
                          return const SubAdminSignUpsuccess();
                        }), (route) => false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
