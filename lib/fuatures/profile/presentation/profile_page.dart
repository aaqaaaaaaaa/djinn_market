import 'dart:io';

import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/common/components/modal_bottom_sheet_top_divider.dart';
import 'package:bizda_bor/common/components/phone_formatter.dart';
import 'package:bizda_bor/common/constants.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/edit_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences? prefs;
  File? _image;
  final picker = ImagePicker();
  UserData? userModel;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  FlutterLocalization localization = FlutterLocalization.instance;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs?.getString('userImage') != null) {
      _image = File(prefs?.getString('userImage') ?? '');
    }
    final box = Hive.box(UserData.boxKey);
    userModel = box.get(UserData.boxKey);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 206.h),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 300.h,
              alignment: Alignment.topCenter,
              child: Image.asset(
                Assets.icons.newLogo,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 14.w, top: 10.h),
                child: Text(
                  LocaleKeys.profile.tr(),
                  style:
                      AppTextStyles.body12w6.copyWith(color: AppColors.white),
                ),
              ),
            ),
            Positioned(
                left: 0, right: 0, bottom: 0.h, child: profileAvatarWidget()),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userModel?.user?.fullName ?? '',
                style: AppTextStyles.body18w5,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.all(4.w),
                    height: 24.w,
                    width: 24.w,
                    child: SvgPicture.asset('assets/icons/phone.svg'),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    userModel?.user?.phoneNumber?.phone ?? '',
                    style: AppTextStyles.body14w4,
                  ),
                ],
              ),
              Divider(height: 20.h, endIndent: 24.w, indent: 24.w),
              OptionsItemWidget(
                onTap: () =>
                    context.pushNamed(Routes.editProfile, extra: userModel),
                title: LocaleKeys.edit_profile.tr(),
                leadingIcon: Assets.icons.profile,
              ),
              OptionsItemWidget(
                onTap: () => context.pushNamed(Routes.orderHistory),
                title: LocaleKeys.order_story.tr(),
                leadingIcon: Assets.icons.story,
              ),
              OptionsItemWidget(
                onTap: () {
                  languageSheet(context);
                },
                title: LocaleKeys.language.tr(),
                actionWidget: FittedBox(
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Text(
                      context.locale.languageCode == 'uz'
                          ? 'O`zbek tili'
                          : "Русский",
                      style: AppTextStyles.body16w5,
                    ),
                  ),
                ),
                leadingIcon: Assets.icons.language,
              ),
              OptionsItemWidget(
                onTap: () => logOutSheet(context),
                color: Colors.red,
                title: LocaleKeys.logout.tr(),
                leadingIcon: Assets.icons.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logOutSheet(BuildContext context) async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
        clipBehavior: Clip.hardEdge,
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: AppColors.white,
            padding: EdgeInsets.only(
                top: 10.h, bottom: 24.h, left: 25.w, right: 25.w),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ModalBottomSheetTopDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    LocaleKeys.logout.tr(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body18w6.copyWith(color: Colors.red),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Text(
                    LocaleKeys.logout_title.tr(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body16w6,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => pop(context),
                      child: Container(
                        height: 48.h,
                        width: MediaQuery.of(context).size.width / 2.5,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.orange),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 13.h),
                        child: FittedBox(
                          child: Text(
                            LocaleKeys.cancel.tr(),
                            style: AppTextStyles.body14w6
                                .copyWith(color: AppColors.orange),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.h),
                    InkWell(
                      onTap: () {
                        context.go(Routes.loginPage);
                        final box = Hive.box(UserModel.boxKey);
                        box.clear();
                      },
                      child: Container(
                        width: 160.w,
                        height: 48.h,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 13.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.orange,
                        ),
                        child: FittedBox(
                          child: Text(
                            LocaleKeys.yes_logout.tr(),
                            style: AppTextStyles.body14w6
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void languageSheet(BuildContext context) async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
        clipBehavior: Clip.hardEdge,
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: AppColors.white,
            padding: EdgeInsets.only(
                top: 10.h, bottom: 24.h, left: 25.w, right: 25.w),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ModalBottomSheetTopDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    LocaleKeys.languages.tr(),
                    style: AppTextStyles.body18w6,
                  ),
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Text(
                    LocaleKeys.languages_subtitle.tr(),
                    style: AppTextStyles.body16w6,
                  ),
                ),
                LanguageItemWidget(
                  title: 'Русский',
                  isSelected: context.locale == const Locale('ru'),
                  onTap: () {
                    context.setLocale(const Locale('ru'));
                  },
                ),
                LanguageItemWidget(
                  title: 'O`zbekcha',
                  onTap: () {
                    context.setLocale(const Locale('uz'));
                  },
                  isSelected: context.locale == const Locale('uz'),
                ),
                // LanguageItemWidget(
                //   title: 'Kirilcha',
                //   isSelected: true,
                //   onTap: () {},
                // ),
                InkWell(
                  onTap: () => pop(context),
                  child: Container(
                    height: 48.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.orange,
                    ),
                    child: FittedBox(
                      child: Text(
                        LocaleKeys.save.tr(),
                        style: AppTextStyles.body14w6
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget profileAvatarWidget() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(15.r),
            onTap: () async {
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile?.path != null) {
                _image = File(pickedFile?.path ?? '');
                setState(() {});
                prefs?.setString('userImage', _image?.path ?? '');
              }
            },
            child: Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.5),
                        blurRadius: 4.r,
                        offset: const Offset(2, 2),
                      )
                    ]),
                child: _image?.path == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: SvgPicture.asset(
                          Assets.icons.profile,
                          width: 100.r,
                          height: 100.r,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Image.file(
                          File(_image?.path ?? ''),
                          width: 100.r,
                          fit: BoxFit.cover,
                          height: 100.r,
                        ),
                      )),
          ),
          Positioned(
              bottom: -8.h,
              right: -8.h,
              child: EditButton(
                width: 28.h,
                height: 28.h,
                color: AppColors.orange,
                onTap: () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile?.path != null) {
                    _image = File(pickedFile?.path ?? '');
                    setState(() {});
                    prefs?.setString('userImage', _image?.path ?? '');
                  }
                },
              ))
        ],
      ),
    );
  }
}

class OptionsItemWidget extends StatelessWidget {
  const OptionsItemWidget({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    this.color,
    this.actionWidget,
  });

  final String title;
  final String leadingIcon;
  final VoidCallback onTap;
  final Widget? actionWidget;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style:
              AppTextStyles.body16w5.copyWith(color: color ?? AppColors.black)),
      leading: Container(
        width: 36.w,
        alignment: Alignment.center,
        child: SvgPicture.asset(
          leadingIcon,
          color: color ?? AppColors.color26,
          fit: BoxFit.none,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (actionWidget != null) actionWidget!,
          Icon(
            CupertinoIcons.right_chevron,
            color: color ?? AppColors.orange,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class LanguageItemWidget extends StatelessWidget {
  const LanguageItemWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.isSelected});

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: AppTextStyles.body16w5),
      trailing: Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: Icon(
          isSelected ? Icons.check : null,
        ),
      ),
      onTap: onTap,
    );
  }
}
