import 'package:another_flushbar/flushbar.dart';
import 'package:bizda_bor/common/all_contants.dart';
import 'package:bizda_bor/common/components/custom_textfield.dart';
import 'package:bizda_bor/common/components/custombutton.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/auth/presentation/manager/auth_bloc.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, this.userModel});

  static Widget screen({UserData? userModel}) {
    return BlocProvider(
      create: (context) => di<AuthBloc>(),
      child: EditProfilePage(userModel: userModel),
    );
  }

  final UserData? userModel;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController adressCon = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    adressCon.text = widget.userModel?.user?.country ?? '';
    nameController.text = widget.userModel?.user?.fullName?.split(' ')[1] ?? '';
    lastNameCon.text = widget.userModel?.user?.fullName?.split(' ')[0] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          LocaleKeys.edit_profile.tr(),
          style: AppTextStyles.body18w5.copyWith(color: AppColors.mediumBlack),
        ),
        leadingWidth: 60.w,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios,
              color: AppColors.mediumBlack.withOpacity(0.5)),
        ),
        elevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStateStatus.loading) {
            Fluttertoast.showToast(
              msg: LocaleKeys.profile_editing.tr(),
              backgroundColor: AppColors.black.withOpacity(0.6),
            );
          } else if (state.status == AuthStateStatus.registerFailure) {
            pop(context);
            Fluttertoast.showToast(
              msg:
                  state.error?.message ?? LocaleKeys.profile_editing_error.tr(),
              backgroundColor: AppColors.black.withOpacity(0.6),
            );
          } else if (state.status == AuthStateStatus.registerSuccess) {
            pop(context);
            Fluttertoast.showToast(
              msg: state.error?.message ??
                  LocaleKeys.profile_editing_success.tr(),
              backgroundColor: AppColors.black.withOpacity(0.6),
            );
            context.go(Routes.profilePage);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                SizedBox(height: 38.h),

                Padding(
                  padding: EdgeInsets.only(top: 18.h, bottom: 16.h),
                  child: CustomTextField(
                    controller: nameController,
                    borderColor: AppColors.transparent,
                    radius: 12.r,
                    backgroundColor: AppColors.colorF2,
                    style: AppTextStyles.body15w4,
                    hintText: LocaleKeys.first_name.tr(),
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
                    radius: 12.r,
                    backgroundColor: AppColors.colorF2,
                    style: AppTextStyles.body15w4,
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
                    style: AppTextStyles.body15w4,
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
                // const Spacer(),
                CustomButton(
                  margin: EdgeInsets.only(top: 18.h),
                  text: LocaleKeys.update.tr(),
                  onPressed: () async {
                    if (adressCon.text.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        lastNameCon.text.isNotEmpty) {
                      context.read<AuthBloc>().add(
                            RegisterEvent(
                              id: widget.userModel?.user?.id,
                              adress: adressCon.text,
                              fullName:
                                  '${lastNameCon.text} ${nameController.text} ',
                            ),
                          );
                    } else {
                      await Flushbar(
                        flushbarPosition: FlushbarPosition.TOP,
                        title: LocaleKeys.error.tr(),
                        message: LocaleKeys.barcha_qatorlarni_toldiring.tr(),
                        duration: const Duration(seconds: 3),
                      ).show(context);
                    }
                  },
                ),
                const Spacer(flex: 2),
              ],
            ),
          );
        },
      ),
    );
  }
}
