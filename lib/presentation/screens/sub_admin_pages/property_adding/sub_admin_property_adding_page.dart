import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/property_adding/map_page.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class PropertyAddingPage extends StatelessWidget {
  PropertyAddingPage({super.key});

  var formKey = GlobalKey<FormState>();
  var nameKey = GlobalKey<FormFieldState>();
  var placeKey = GlobalKey<FormFieldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController placController = TextEditingController();
  TextEditingController mapLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
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
                          "Let's Add details",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'fill the deatailes about the property',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                            icon: const Icon(Icons.roofing_rounded),
                            labelText: 'Property Name'),
                        style: Styles().formTextStyle(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: TextFormField(
                        key: placeKey,
                        validator: (value) {
                          if ((!RegExp(r'^\S+(?!\d+$)').hasMatch(value!))) {
                            return 'enter valid place';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          placeKey.currentState!.validate();
                        },
                        controller: placController,
                        decoration: Styles().formDecorationStyle(
                            icon: const Icon(Icons.location_on_rounded),
                            labelText: 'place'),
                        style: Styles().formTextStyle(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 300,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        buttonStyleData: ButtonStyleData(
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.92,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: const Color.fromARGB(255, 242, 242, 242),
                          ),
                        ),
                        onChanged: (value) {},
                        value: 'Hotel',
                        hint: const Row(
                          children: [
                            Icon(Icons.male_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Catogory'),
                          ],
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Hotel',
                            child: Text('Hotel'),
                          ),
                          DropdownMenuItem(
                            value: 'Dormitory',
                            child: Text('Dormitory'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Row(
                  //   children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextFormField(
                              validator: (value) {
                                if ((!RegExp(r'^\S+(?!\d+$)')
                                    .hasMatch(value!))) {
                                  return 'enter valid place';
                                } else {
                                  return null;
                                }
                              },
                              controller: mapLocationController,
                              decoration: Styles().formDecorationStyle(
                                  icon: const Icon(Icons.map_outlined),
                                  labelText: 'place'),
                              style: Styles().formTextStyle(context),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return TakeFromMap();
                          }));
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 60,
                            width: 60,
                            decoration: Styles().customNextButtonDecoration(),
                            child: Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // // Text('sdf')
                  //   ],
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //   child: ClipRRect(
                  //     borderRadius: const BorderRadius.all(Radius.circular(20)),
                  //     child: TextFormField(
                  //       key: phoneKey,
                  //       onChanged: (value) {
                  //         phoneKey.currentState!.validate();
                  //       },
                  //       validator: (value) {
                  //         if ((!RegExp(r'^[0-9]+\.?[0-9]*$').hasMatch(value!))) {
                  //           return 'enter valid Phone number';
                  //         } else {
                  //           return null;
                  //         }
                  //       },
                  //       controller: phoneController,
                  //       decoration: Styles().formDecorationStyle(
                  //           icon: const Icon(Icons.phone_in_talk_outlined),
                  //           labelText: 'Phone'),
                  //       style: Styles().formTextStyle(context),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //   child: ClipRRect(
                  //     borderRadius: const BorderRadius.all(Radius.circular(20)),
                  //     child: TextFormField(
                  //       key: passwordKey,
                  //       onChanged: (value) {
                  //         passwordKey.currentState!.validate();
                  //       },
                  //       validator: (value) {
                  //         if ((!RegExp(r'^\S+(?!\d+$)').hasMatch(value!))) {
                  //           return 'enter valid password';
                  //         } else {
                  //           return null;
                  //         }
                  //       },
                  //       controller: passwordController,
                  //       obscureText: true,
                  //       decoration: Styles().formDecorationStyle(
                  //           icon: const Icon(Icons.lock_outline_rounded),
                  //           labelText: 'Password'),
                  //       style: Styles().formTextStyle(context),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.02,
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     XFile tempImage = await SubAdminFunction().subAdminPickImage();
                  //     // ignore: use_build_context_synchronously
                  //     // BlocProvider.of<SubAdminSignUpBloc>(context)
                  //     //     .add(OnAddSubAdminSignUpImage(image: tempImage));
                  //   },
                  //   child: const Text('Add Image'),
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  // BlocConsumer<SubAdminSignUpBloc, SubAdminSignUpState>(
                  //   builder: (context, state) {
                  //     return Column(
                  //       children: [
                  //         Container(
                  //           width: MediaQuery.of(context).size.width * 0.6,
                  //           height: MediaQuery.of(context).size.width * 0.6,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(
                  //                 MediaQuery.of(context).size.width * 0.6),
                  //             image: context.read<SubAdminSignUpBloc>().image != null
                  //                 ? DecorationImage(
                  //                     image: FileImage(File(context
                  //                         .watch<SubAdminSignUpBloc>()
                  //                         .image!
                  //                         .path)),
                  //                     fit: BoxFit.cover)
                  //                 : const DecorationImage(
                  //                     image: AssetImage(
                  //                         'assets/images/profile.png')),
                  //           ),
                  //         ),
                  //         Container(
                  //           margin: const EdgeInsets.all(20),
                  //           height: MediaQuery.of(context).size.width * 0.1,
                  //           width: MediaQuery.of(context).size.width * 0.6,
                  //           decoration: Styles().elevatedButtonDecoration(),
                  //           child: ElevatedButton(
                  //               style: Styles().elevatedButtonStyle(),
                  //               onPressed: () async {
                  //                 if (BlocProvider.of<SubAdminSignUpBloc>(context)
                  //                         .image ==
                  //                     null) {
                  //                   CommonWidget()
                  //                       .toastWidget('pls add profile photo');
                  //                   return;
                  //                 } else if (formKey.currentState!.validate()) {
                  //                   log('validate successfull');
                  //                   BlocProvider.of<SubAdminSignUpBloc>(context)
                  //                       .add(OnlyForLoadingevent());
                  //                   final imageUrl = await SubAdminFunction()
                  //                       .uploadImageToFirebase(context
                  //                           .read<SubAdminSignUpBloc>()
                  //                           .image!);
                  //                   // ignore: use_build_context_synchronously
                  //                   BlocProvider.of<SubAdminSignUpBloc>(context).add(
                  //                       OnVarifySubAdminDetailsEvent(
                  //                           userModel:SubAdminModel(
                  //                               // ignore: use_build_context_synchronously
                  //                               email: context
                  //                                   .read<SubAdminSignUpBloc>()
                  //                                   .email!,
                  //                               name: nameController.text,
                  //                               password: passwordController.text,
                  //                               phone: int.parse(
                  //                                   phoneController.text),
                  //                               imagePath: imageUrl,
                  //                               userId: ''),
                  //                           compire: FirebaseFirestoreConst
                  //                               .firebaseFireStoreEmail));
                  //                   // ignore: use_build_context_synchronously
                  //                 }
                  //               },
                  //               child: state is SubAdminSignupLoading
                  //                   ? const CircularProgressIndicator(
                  //                     color: Colors.white,
                  //                   )
                  //                   : Text(
                  //                       'Submit',
                  //                       style: Styles().elevatedButtonTextStyle(),
                  //                     )),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  //   listener: (context, state) {
                  //     if (state is SubAdminVerifiedWithMoredataState) {
                  //       context.read<SubAdminLoginBloc>().add(SubAdminAlredyLoginEvent(
                  //           userCredential: state.userCredential,
                  //           userId: state.userId));
                  //       Navigator.of(context).pushAndRemoveUntil(
                  //           MaterialPageRoute(builder: (ctx) {
                  //         return const SubAdminSignUpsuccess();
                  //       }), (route) => false);
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
