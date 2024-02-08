import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_event.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_state.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_event.dart';
import 'package:share_sub_admin/application/sub_admin_signup_bloc/sub_admin_signup_state.dart';
import 'package:share_sub_admin/presentation/alerts/snack_bars.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/sub_admin_main_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_signup/sub_admin_signup.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_signup/sub_admin_signup_more.dart';
import 'package:share_sub_admin/presentation/widgets/commen_widget.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class SubAdminLogin extends StatelessWidget {
  SubAdminLogin({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocConsumer<SubAdminSignUpBloc, SubAdminSignUpState>(
            builder: (context, state) {
              return Column(
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
                          'Welcome Back',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: TextFormField(

                              controller: emailController,
                              decoration: Styles().formDecorationStyle(
                                  icon: const Icon(Icons.mail_outlined),
                                  labelText: 'Email'),
                              style: Styles().formTextStyle(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: Styles().formDecorationStyle(
                                  icon: const Icon(Icons.lock_outline_rounded),
                                  labelText: 'Password'),
                              style: Styles().formTextStyle(context),
                            ),
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     'Forgot password?',
                        //     style: Styles().passwordTextStyle(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height > 786
                        ? MediaQuery.of(context).size.height * 0.44
                        : MediaQuery.of(context).size.height * .3,
                  ),
                  BlocConsumer<SubAdminLoginBloc, SubAdminLoginState>(
                    builder: (context, state) {
                      if (state is SubAdminLoginLoadingState) {
                        return const CircularProgressIndicator();
                      }
                      return Container(
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: Styles().elevatedButtonDecoration(),
                        child: ElevatedButton(
                            style: Styles().elevatedButtonStyle(),
                            onPressed: () {
                              context.read<SubAdminLoginBloc>().add(
                                  SubAdminLoginLoadingEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text));
                            },
                            child: Text(
                              'Login',
                              style: Styles().elevatedButtonTextStyle(context),
                            )),
                      );
                    },
                    listener: (context, state) {
                      if (state is SubAdminLoginSuccessState) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (ctx) {
                          return SubAdminMainPage(userId: context.read<SubAdminLoginBloc>().userId!,);
                        }), (route) => false);
                      }
                      if(state is SubAdminLoginErrorState){
                        SnackBars().errorSnackBar('Invalid username or password', context);
                      }
                    },
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Divider(
                            thickness: 3,
                          ),
                        ),
                      ),
                      Text(
                        "Or",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Divider(
                            thickness: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: state is SubAdminSignupLoading
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                      .read<SubAdminSignUpBloc>()
                                      .add(OnclickSubAdminSignUpAuthentication());
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration:
                                      Styles().googleAuthButtonDecoration(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child:
                                        Image.asset('assets/images/google.png'),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return SubAdminSignUp();
                      }));
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Don't have an account yet?",
                          style: Theme.of(context).textTheme.displaySmall),
                      TextSpan(
                          text: ' Register',
                          style: Styles().linkTextColorStyle(context))
                    ])),
                  )
                ],
              );
            },
            listener: (context, state) {
              if (state is SubAdminAlredySignupState)   {
                context.read<SubAdminLoginBloc>().add(SubAdminAlredyLoginEvent(
                    userCredential: state.userCredential,
                    userId: state.userId));
                     
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx)  {
                  return SubAdminMainPage(userId: context.read<SubAdminLoginBloc>().userId!,);
                }), (route) => false);
              } else if (state is SubAdminSignupAuthenticationSuccess) {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                  return SubAdminSignUpMoreInfo();
                }));
              }
            },
          ),
        ),
      ),
    );
  }
}
