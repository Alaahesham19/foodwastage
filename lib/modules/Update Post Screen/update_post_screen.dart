import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import '../../shared/cubit/Food_Cubit/food_cubit.dart';
import '../../styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//بتستدعي الصفحه من الليست اللي فيها البوست علشان تقدر تمرر فيها Post Id
// ignore: must_be_immutable
class UpdatePost extends StatelessWidget {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String postId;
  PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //هنا بنخزن القيم اللي جايه علشان نظهرها ونعدل عليها
        locationController.text = postModel.location!;
        foodNameController.text = postModel.itemName!;
        descriptionController.text = postModel.description!;
        FoodCubit.get(context).foodType = postModel.foodType!;

        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // first text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      defaultText(
                          text: AppLocalizations.of(context)!
                              .layoutAppBarTitleDonate,
                          fontWeight: FontWeight.normal,
                          fontSize: 26),
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  FoodCubit.get(context)
                                      .minusItemCount();
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  size: 15,
                                  color: defaultColor,
                                )),
                            defaultText(
                                text: "${FoodCubit.get(context).itemQuantity}",
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                            IconButton(
                                onPressed: () {
                                  FoodCubit.get(context)
                                      .incrementItemCount();
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 15,
                                  color: defaultColor,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height / 50),
                  //form F
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        rowTextAndFormInput(
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .donateScreenLocationFieldValidation;
                              } else {
                                return null;
                              }
                            },
                            textEditingController: locationController,
                            rowText: AppLocalizations.of(context)!
                                .donateScreenLocationFieldHeader,
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            icon: Icons.add_location_alt_outlined,
                            hintTextForm: AppLocalizations.of(context)!
                                .donateScreenLocationFieldHint),
                        SizedBox(
                          height: size.height / 60,
                        ),
                        rowTextAndFormInput(
                            textEditingController: foodNameController,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .donateScreenNameFieldValidation;
                              } else {
                                return null;
                              }
                            },
                            rowText: AppLocalizations.of(context)!
                                .donateScreenNameFieldHeader,
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            icon: Icons.fastfood_outlined,
                            hintTextForm: AppLocalizations.of(context)!
                                .donateScreenNameFieldHint),
                        SizedBox(
                          height: size.height / 60,
                        ),
                        //Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            defaultText(
                                text: AppLocalizations.of(context)!
                                    .donateScreenDateFieldHeader,
                                fontSize: 19,
                                fontWeight: FontWeight.normal),
                            const Icon(Icons.date_range_outlined,
                                color: defaultColor),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              currentTime: DateTime.now(),
                              locale: LocaleType.en,
                              maxTime: DateTime(2030, 1, 1),
                              minTime: DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day),
                              onChanged: (date) {
                                FoodCubit.get(context).changDateTime(date);
                              },
                              onConfirm: (date) {
                                FoodCubit.get(context).changDateTime(date);
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: Container(
                              padding: EdgeInsets.zero,
                              height: size.height / 15,
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                border: Border.all(color: KBlack, width: 0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 6),
                                child: Text(
                                  FoodCubit.get(context).date,
                                  style: const TextStyle(
                                      color: KBlack, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 120,
                        ),
                        /////////////////////////////////////Description
                        rowTextAndFormInput(
                            textEditingController: descriptionController,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .donateScreenDescriptionFieldValidation;
                              } else if (value.toString().length <= 50) {
                                return AppLocalizations.of(context)!
                                    .donateScreenDescriptionFieldValidation2;
                              } else {
                                return null;
                              }
                            },
                            rowText: AppLocalizations.of(context)!
                                .donateScreenDescriptionFieldHeader,
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            icon: Icons.description,
                            hintTextForm: AppLocalizations.of(context)!
                                .donateScreenDescriptionFieldHint),
                        SizedBox(
                          height: size.height / 60,
                        ),
                        //Photo
                        Text(
                          AppLocalizations.of(context)!
                              .donateScreenPhotoFieldHeader,
                          style: const TextStyle(fontSize: 19),
                        ),
                        SizedBox(
                          height: size.height / 90,
                        ),

                        //هنا لو ضفت صور هيتعملها update لو مضفتش هتفضل زي مهي عادي
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            if (FoodCubit.get(context).imageFile1 == null)
                              FoodCubit.get(context).imageFile2 != null
                                  ? DottedBorder(
                                      color: defaultColor,
                                      strokeWidth: 2,
                                      dashPattern: const [
                                        3,
                                        3,
                                      ],
                                      child: InkWell(
                                        onTap: () {
                                          if (FoodCubit.get(context)
                                                  .imageFile1 ==
                                              null) {
                                            FoodCubit.get(context).getImage1();
                                          } else if (FoodCubit.get(context)
                                                  .imageFile2 ==
                                              null) {
                                            FoodCubit.get(context).getImage2();
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: size.width * .23,
                                          height: size.width * .23,
                                          padding: const EdgeInsets.all(16.0),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.grey,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            else if (FoodCubit.get(context).imageFile1 != null)
                              Stack(
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(),
                                      alignment: Alignment.center,
                                      width: size.width * .23,
                                      height: size.width * .23,
                                      //    padding: const EdgeInsets.all(16.0),
                                      child: Image.file(
                                        FoodCubit.get(context).imageFile1!,
                                        fit: BoxFit.cover,
                                      )),
                                  Positioned(
                                    right: 3,
                                    top: 3,
                                    child: CircleAvatar(
                                      backgroundColor: defaultColor,
                                      maxRadius: size.width * .03,
                                      minRadius: size.width * .03,
                                      child: Center(
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            FoodCubit.get(context)
                                                .deleteImage1();
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                            color: KBlack,
                                            size: size.width * .05,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (FoodCubit.get(context).imageFile2 == null)
                              DottedBorder(
                                color: defaultColor,
                                strokeWidth: 2,
                                dashPattern: const [
                                  3,
                                  3,
                                ],
                                child: InkWell(
                                  onTap: () {
                                    if (FoodCubit.get(context).imageFile1 ==
                                        null) {
                                      FoodCubit.get(context).getImage1();
                                    } else if (FoodCubit.get(context)
                                            .imageFile2 ==
                                        null) {
                                      FoodCubit.get(context).getImage2();
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: size.width * .23,
                                    height: size.width * .23,
                                    padding: const EdgeInsets.all(16.0),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              )
                            else
                              Stack(
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(),
                                      alignment: Alignment.center,
                                      width: size.width * .23,
                                      height: size.width * .23,
                                      //    padding: const EdgeInsets.all(16.0),
                                      child: ClipRRect(
                                        child: Image.file(
                                          FoodCubit.get(context).imageFile2!,
                                          fit: BoxFit.fill,
                                        ),
                                      )),
                                  Positioned(
                                    right: 3,
                                    top: 3,
                                    child: CircleAvatar(
                                      backgroundColor: defaultColor,
                                      maxRadius: size.width * .03,
                                      minRadius: size.width * .03,
                                      child: Center(
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            FoodCubit.get(context)
                                                .deleteImage2();
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                            color: KBlack,
                                            size: size.width * .05,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                          ],
                        ),
                        SizedBox(
                          height: size.height / 60,
                        ),
                        //row text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width / 2,
                              decoration: const BoxDecoration(),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // <-- Radius
                                    ),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate() &&
                                        FoodCubit.get(context).addPostPolicyIsChecked ==
                                            true) {
                                      FoodCubit.get(context).updatePost(
                                        location: locationController.text,
                                        itemName: foodNameController.text,
                                        postDate: FoodCubit.get(context).date,
                                        foodQuantity: FoodCubit.get(context).itemQuantity.toString(),
                                        description: descriptionController.text,
                                        imageUrl1: postModel.imageUrl1!,
                                        imageUrl2: postModel.imageUrl2!,
                                        foodType: FoodCubit.get(context).foodType,
                                        contactMethod: FoodCubit.get(context).contactMethod,
                                        isFavorite: false,

                                      );
                                    }
                                  },
                                  child: state is UpdatePostLoadingState
                                      ? SizedBox(
                                          height: size.width * .05,
                                          width: size.width * .05,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : defaultText(
                                          text: "Update",
                                          fontSize: 26,
                                          fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  UpdatePost({Key? key, required this.postId, required this.postModel})
      : super(key: key);
}
