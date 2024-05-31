import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/common/components/custombutton.dart';
import 'package:bizda_bor/common/constants.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/auth/presentation/manager/auth_bloc.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key, this.phone, this.code}) : super(key: key);
  final String? phone, code;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  MaskTextInputFormatter inputFormatter =
      MaskTextInputFormatter(mask: '(##) ### ## ##');
  final TextEditingController _pinPutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(
        '================================your code this================================');
    print(widget.code);
  }

  final defaultPinTheme = PinTheme(
    width: 44.w,
    height: 44.w,
    textStyle: AppTextStyles.body20w4.copyWith(color: AppColors.fullBlack),
    decoration: BoxDecoration(
      color: AppColors.lightBlack.withOpacity(0.3),
      borderRadius: BorderRadius.circular(4.r),
    ),
  );
  final focusedtPinTheme = PinTheme(
    width: 44.w,
    height: 44.w,
    textStyle: AppTextStyles.body20w4.copyWith(color: AppColors.fullBlack),
    decoration: BoxDecoration(
      color: AppColors.lightBlack.withOpacity(0.3),
      borderRadius: BorderRadius.circular(4.r),
    ),
  );
  final errorPinTheme = PinTheme(
    width: 44.w,
    height: 44.w,
    textStyle: AppTextStyles.body20w4.copyWith(color: AppColors.orange),
    decoration: BoxDecoration(
      color: Colors.red.withOpacity(0.3),
      borderRadius: BorderRadius.circular(4.r),
      boxShadow: [BoxShadow(color: Colors.red, spreadRadius: 1.r)],
    ),
  );

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
            } else if (state.status == AuthStateStatus.confirmSmsSuccess) {
              pop(context);
              context.go(Routes.mainPage);
            } else if (state.status == AuthStateStatus.isFirstOpenSuccess) {
              pop(context);
              context.goNamed(Routes.registerPage,
                  pathParameters: {'userId': state.userId.toString()});
            } else if (state.status == AuthStateStatus.confirmSmsFailure) {
              _pinPutController.clear();
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
                      height: 261.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(Assets.images.onlineBuy3)),
                    ),
                    SizedBox(
                      // width: MediaQuery.of(context).size.width * .8,
                      height: 35.h,
                      child: AutoSizeText(
                        LocaleKeys.digit_code.tr(),
                        maxLines: 1,
                        style: AppTextStyles.body28w7
                            .copyWith(letterSpacing: 0.36),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AutoSizeText(
                      LocaleKeys.code_subtitle
                          .tr()
                          .replaceFirst('phone', '${widget.phone}'),
                      maxLines: 2,
                      style: AppTextStyles.body17w4.copyWith(
                        color: AppColors.grey1,
                        letterSpacing: -0.41,
                      ),
                    ),
                    SizedBox(height: 48.h),
                    Align(
                      alignment: Alignment.center,
                      child: Pinput(
                        length: 4,
                        autofocus: true,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        controller: _pinPutController,
                        separator: SizedBox(height: 48.h, width: 32.w),
                        defaultPinTheme: defaultPinTheme,
                        errorPinTheme: errorPinTheme,
                        focusedPinTheme: focusedtPinTheme,
                        useNativeKeyboard: true,
                        validator: (s) {
                          // if (state.status ==
                          //     AuthStateStatus.confirmSmsFailure) {
                          //   return '${state.error?.message}';
                          // }
                          return null;
                        },
                        toolbarEnabled: true,
                        showCursor: true,
                        textInputAction: TextInputAction.next,
                        onCompleted: (s) {
                          context.read<AuthBloc>().add(ConfirmSmsEvent(
                              code: _pinPutController.text,
                              phone: '${widget.phone}'));
                        },
                      ),
                    ),
                    SizedBox(height: 18.h),
                    CustomButton(
                      margin: EdgeInsets.only(top: 24.h, bottom: 42.h),
                      text: LocaleKeys.contin.tr(),
                      onPressed: () async {
                        if (_pinPutController.text.isNotEmpty) {
                          context.read<AuthBloc>().add(ConfirmSmsEvent(
                              code: _pinPutController.text,
                              phone: '${widget.phone}'));
                        } else {
                          await Flushbar(
                            flushbarPosition: FlushbarPosition.TOP,
                            title: LocaleKeys.error.tr(),
                            message: LocaleKeys.sms_kodni_kiriting.tr(),
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
