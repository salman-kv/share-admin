import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_event.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_state.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_signup/sub_admin_signup_more.dart';
import 'package:share_sub_admin/presentation/widgets/commen_widget.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class SubAdminSignUpOtp extends StatelessWidget {
  SubAdminSignUpOtp({super.key});

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Verify OTP',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  BlocConsumer<SubAdminSignUpBloc, SubAdminSignUpState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: TextFormField(
                                controller: otpController,
                                decoration: Styles().formDecorationStyle(
                                    icon: const Icon(Icons.mail_outlined),
                                    labelText: 'otp'),
                                style: Styles().formTextStyle(context),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20),
                                height: MediaQuery.of(context).size.width * 0.1,
                                width: MediaQuery.of(context).size.width * 0.6,
                                decoration: Styles().elevatedButtonDecoration(),
                                child: ElevatedButton(
                                    style: Styles().elevatedButtonStyle(),
                                    onPressed: () {
                                      BlocProvider.of<SubAdminSignUpBloc>(context).add(ManualOtpCheckingEvent(otp: otpController.text));
                                    },
                                    child: state is ManualEmailCheckingLoadingState ? const CircularProgressIndicator() : Text(
                                      'Verify',
                                      style: Styles().elevatedButtonTextStyle(context),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    listener: (context, state) {
                      if(state is ManualOtpCheckingSuccessState ){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          return SubAdminSignUpMoreInfo();
                        }));
                      }
                      else if(state is SubAdminOtpVerifyErrorState){
                        CommonWidget().errorSnackBar('Invalid OTP', context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
