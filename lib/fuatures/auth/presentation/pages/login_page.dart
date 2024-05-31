import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/common/components/custombutton.dart';
import 'package:bizda_bor/common/constants.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/auth/presentation/manager/auth_bloc.dart';
import 'package:bizda_bor/fuatures/auth/presentation/pages/otp_page.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../common/components/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  // final bool isRegister;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  MaskTextInputFormatter inputFormatter =
      MaskTextInputFormatter(mask: '(##) ### ## ##');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<AuthBloc>(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state.status == AuthStateStatus.loading) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                          size: 40.w, color: AppColors.orange),
                    );
                  });
            } else if (state.status == AuthStateStatus.loginSuccess) {
              pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpPage(
                        phone:
                            '+998${phoneController.text.replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '')}',
                        code: state.code),
                  ));
            } else if (state.status == AuthStateStatus.loginFailure) {
              pop(context);
              await Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                title: LocaleKeys.error.tr(),
                message: state.error?.message,
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: Image.asset(Assets.images.onlineBuy),
                    ),
                    SizedBox(
                      height: 60.h,
                      child: AutoSizeText(
                        LocaleKeys.welcome.tr(),
                        maxLines: 2,
                        style: AppTextStyles.body28w7
                            .copyWith(letterSpacing: 0.36),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 60.h,
                      child: AutoSizeText(
                        LocaleKeys.welcome_subtitle.tr(),
                        maxLines: 3,
                        style: AppTextStyles.body17w4.copyWith(
                          color: AppColors.grey1,
                          letterSpacing: -0.41,
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    CustomTextField(
                      controller: phoneController,
                      leading: Padding(
                        padding: EdgeInsets.only(left: 12.w),
                        child: Text(
                          '+998 ',
                          style: AppTextStyles.body14w4,
                        ),
                      ),
                      hintText: '(90) 123 45 67',
                      borderColor: AppColors.transparent,
                      radius: 12.r,
                      backgroundColor: AppColors.colorF2,
                      style: AppTextStyles.body14w4,
                      hintStyle: AppTextStyles.body14w4
                          .copyWith(color: AppColors.black.withOpacity(0.5)),
                      textInputType: TextInputType.phone,
                      inputFormatters: [inputFormatter],
                      trailing: IconButton(
                        onPressed: () {
                          phoneController.clear();
                          setState(() {});
                        },
                        icon: SvgPicture.asset(Assets.icons.clear),
                      ),
                    ),
                    CustomButton(
                      margin: EdgeInsets.only(top: 24.h, bottom: 42.h),
                      text: LocaleKeys.junatish.tr(),
                      onPressed: () async {
                        if (phoneController.text.isNotEmpty &&
                            phoneController.text.length == 14) {
                          context.read<AuthBloc>().add(GetLoginEvent(
                              phone:
                                  '+998${phoneController.text.replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '')}'));
                        } else {
                          await Flushbar(
                            flushbarPosition: FlushbarPosition.TOP,
                            title: LocaleKeys.error.tr(),
                            message: LocaleKeys.phone_error.tr(),
                            duration: const Duration(seconds: 3),
                          ).show(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
