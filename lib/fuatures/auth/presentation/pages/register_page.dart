import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/common/components/custom_textfield.dart';
import 'package:bizda_bor/common/components/custombutton.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/auth/presentation/manager/auth_bloc.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.userId}) : super(key: key);
  final int? userId;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController adressCon = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  List<String> langList = ['O`zbekcha', 'Русский'];
  String? langKey;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    langKey ??= context.locale.languageCode == 'uz' ? langList[0] : langList[1];
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
            } else if (state.status == AuthStateStatus.registerFailure) {
              await Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                title: LocaleKeys.error.tr(),
                message: state.error?.message,
                duration: const Duration(seconds: 3),
              ).show(context);
            } else if (state.status == AuthStateStatus.registerSuccess) {
              context.go(Routes.mainPage);
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
                          child: Image.asset(Assets.images.onlineBuy2)),
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
                    AutoSizeText(
                      LocaleKeys.welcome_register_subtitle.tr(),
                      maxLines: 2,
                      style: AppTextStyles.body17w4.copyWith(
                        color: AppColors.grey1,
                        letterSpacing: -0.41,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Padding(
                      padding: EdgeInsets.only(top: 18.h, bottom: 16.h),
                      child: CustomTextField(
                        controller: nameController,
                        hintText: LocaleKeys.first_name.tr(),
                        borderColor: AppColors.transparent,
                        radius: 12.r,
                        inputFormatters: [LengthLimitingTextInputFormatter(40)],
                        backgroundColor: AppColors.colorF2,
                        style: AppTextStyles.body14w4,
                        hintStyle: AppTextStyles.body14w4
                            .copyWith(color: AppColors.black.withOpacity(0.5)),
                        trailing: IconButton(
                          onPressed: () {
                            nameController.clear();
                            setState(() {});
                          },
                          icon: SvgPicture.asset(Assets.icons.clear),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller: lastNameCon,
                        hintText: LocaleKeys.last_name.tr(),
                        borderColor: AppColors.transparent,
                        inputFormatters: [LengthLimitingTextInputFormatter(40)],
                        radius: 12.r,
                        backgroundColor: AppColors.colorF2,
                        style: AppTextStyles.body14w4,
                        hintStyle: AppTextStyles.body14w4
                            .copyWith(color: AppColors.black.withOpacity(0.5)),
                        trailing: IconButton(
                          onPressed: () {
                            lastNameCon.clear();
                            setState(() {});
                          },
                          icon: SvgPicture.asset(Assets.icons.clear),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller: adressCon,
                        borderColor: AppColors.transparent,
                        radius: 12.r,
                        backgroundColor: AppColors.colorF2,
                        inputFormatters: [LengthLimitingTextInputFormatter(40)],
                        style: AppTextStyles.body14w4,
                        hintStyle: AppTextStyles.body14w4
                            .copyWith(color: AppColors.black.withOpacity(0.5)),
                        hintText: LocaleKeys.address.tr(),
                        trailing: IconButton(
                          onPressed: () {
                            adressCon.clear();
                            setState(() {});
                          },
                          icon: SvgPicture.asset(Assets.icons.clear),
                        ),
                      ),
                    ),
                    Container(
                      height: 50.h,
                      padding: EdgeInsets.only(right: 10.w, left: 16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: AppColors.colorF2,
                      ),
                      child: DropdownButton<String>(
                        value: langKey,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        style: AppTextStyles.body14w4,
                        borderRadius: BorderRadius.circular(12.r),
                        underline: const SizedBox.shrink(),
                        items: langList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          langKey = newValue;
                          context.setLocale(
                              Locale(newValue == 'Русский' ? 'ru' : 'uz'));
                          setState(() {});
                        },
                      ),
                    ),
                    CustomButton(
                      margin: EdgeInsets.only(top: 24.h, bottom: 42.h),
                      text: LocaleKeys.register.tr(),
                      onPressed: () async {
                        if (adressCon.text.isNotEmpty &&
                            nameController.text.isNotEmpty &&
                            lastNameCon.text.isNotEmpty) {
                          context.read<AuthBloc>().add(
                                RegisterEvent(
                                  id: widget.userId,
                                  adress: adressCon.text,
                                  fullName:
                                      '${lastNameCon.text} ${nameController.text} ',
                                  language: langKey == 'Русский' ? 'ru' : 'uz',
                                ),
                              );
                        } else {
                          await Flushbar(
                            flushbarPosition: FlushbarPosition.TOP,
                            title: LocaleKeys.error.tr(),
                            message:
                                LocaleKeys.barcha_qatorlarni_toldiring.tr(),
                            duration: const Duration(seconds: 3),
                          ).show(context);
                        }
                      },
                    ),
                    Row(
                      children: [
                        const Flexible(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Text(
                            LocaleKeys.or.tr(),
                            style: AppTextStyles.body15w5
                                .copyWith(color: AppColors.mediumBlack),
                          ),
                        ),
                        const Flexible(child: Divider()),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 28.h),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                        overlayColor:
                            MaterialStateProperty.all(AppColors.transparent),
                        onTap: () {
                          context.pushReplacement(Routes.loginPage);
                        },
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.have_an_account.tr(),
                                style: AppTextStyles.body15w4
                                    .copyWith(color: AppColors.mediumBlack),
                              ),
                              Text(
                                LocaleKeys.log_in.tr(),
                                style: AppTextStyles.body15w5
                                    .copyWith(color: AppColors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
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
