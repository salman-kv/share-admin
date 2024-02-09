import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_event.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_state.dart';
import 'package:share_sub_admin/presentation/alerts/snack_bars.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_signup/sub_admin_signup_otp.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class SubAdminSignUp extends StatelessWidget {
   SubAdminSignUp({super.key});

  TextEditingController emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    'Hey there,',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Enter Your Email',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Form(
                child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: TextFormField(
                      controller: emailController,
                      decoration: Styles().formDecorationStyle(
                          icon: const Icon(Icons.mail_outline_rounded),
                          labelText: 'Email'),
                      style: Styles().formTextStyle(context),
                    ),
                  ),
                ),
                 SizedBox(height: MediaQuery.of(context).size.height >786 ? MediaQuery.of(context).size.height*0.63 : MediaQuery.of(context).size.height*.45 ,),
                BlocConsumer<SubAdminSignUpBloc,SubAdminSignUpState>(
                  builder: (context, state) {
                    return  Container(
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: Styles().elevatedButtonDecoration(),
                    child: ElevatedButton(
                        style: Styles().elevatedButtonStyle(),
                        onPressed: () {
                          BlocProvider.of<SubAdminSignUpBloc>(context).add(ManualEmailCheckingEvent(email: emailController.text.toLowerCase().trim()));
                        },
                        child: state is ManualEmailCheckingLoadingState ? const CircularProgressIndicator(
                          color: Colors.white,
                        ) :  Text(
                          'verify',
                          style: Styles().elevatedButtonTextStyle(context),
                        )),
                  );
                  },listener: (context, state) {
                    if(state is ManualEmailCheckingSuccessState){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                        return  SubAdminSignUpOtp();
                      }));
                    }
                    else if(state is SubAdminSignupErrorState){
                      SnackBars().errorSnackBar('Invalid Email , pls enter a valid email', context);
                    }
                    else if(state is SubAdminAlreadySignupErrorState){
                      SnackBars().errorSnackBar('User alredy Logined', context);
                    }
                  },
                ),
              ],
            ))
          ],
        ),
      )),
    ));
  }
}
