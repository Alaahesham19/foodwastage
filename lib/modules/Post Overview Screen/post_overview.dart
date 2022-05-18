import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import '../../shared/constants.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import '../../shared/cubit/Food_Cubit/food_states.dart';
import '../../styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostOverview extends StatelessWidget {
  const PostOverview({Key? key, required this.postModel}) : super(key: key);
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Image(
                  height: 230.0,
                  width: double.infinity,
                  image: NetworkImage(
                    postModel.imageUrl1!,
                  ),
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  postModel.foodType!,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${AppLocalizations.of(context)!.postDateHeader} ${postModel.postDate!}",
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /////////////////////////////////////Name/////////////////////////////////////
                          rowTextAndFormInput(
                              rowText: AppLocalizations.of(context)!
                                  .donateScreenNameFieldHeader,
                              initialValue: postModel.itemName!,
                              fontSize: 19,
                              color: KBlack,
                              isEnabled: false,
                              fontWeight: FontWeight.normal,
                              icon: Icons.fastfood_outlined,
                              hintTextForm: AppLocalizations.of(context)!
                                  .donateScreenNameFieldHint),

                          const SizedBox(height: 20),

                          rowTextAndFormInput(
                              /////////////////////////////////////Location/////////////////////////////////////
                              rowText: AppLocalizations.of(context)!
                                  .donateScreenLocationFieldHeader,
                              initialValue: postModel.location!,
                              isEnabled: false,
                              fontSize: 19,
                              color: KBlack,
                              fontWeight: FontWeight.normal,
                              icon: Icons.add_location_alt_outlined,
                              hintTextForm: AppLocalizations.of(context)!
                                  .donateScreenLocationFieldHint),

                          const SizedBox(height: 20),

                          /////////////////////////////////////Date/////////////////////////////////////
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              defaultText(
                                  text: AppLocalizations.of(context)!
                                      .donateScreenDateFieldHeader,
                                  fontSize: 19,
                                  color: KBlack,
                                  fontWeight: FontWeight.normal),
                              const Icon(Icons.date_range_outlined,
                                  color: defaultColor),
                            ],
                          ),
                          TextFormField(
                            decoration: const InputDecoration(),
                            initialValue: postModel.pickupDate!,
                            enabled: false,
                          ),
                          const SizedBox(height: 20),

                          /////////////////////////////////////Quantity/////////////////////////////////////

                          rowTextAndFormInput(
                              isEnabled: false,
                              rowText: AppLocalizations.of(context)!
                                  .donateScreenQuantityFieldHeader,
                              initialValue: postModel.quantity!,
                              fontSize: 19,
                              color: KBlack,
                              fontWeight: FontWeight.normal,
                              icon: Icons.list_alt,
                              hintTextForm: AppLocalizations.of(context)!
                                  .donateScreenQuantityFieldHint),

                          const SizedBox(height: 20),

                          /////////////////////////////////////Description/////////////////////////////////////

                          rowTextAndFormInput(
                              isEnabled: false,
                              linesNumber: 5,
                              rowText: AppLocalizations.of(context)!
                                  .donateScreenDescriptionFieldHeader,
                              initialValue: postModel.description!,
                              fontSize: 19,
                              color: KBlack,
                              fontWeight: FontWeight.normal,
                              icon: Icons.description,
                              hintTextForm: AppLocalizations.of(context)!
                                  .donateScreenDescriptionFieldHint),
                        ],
                      ),
                    ),
                  ),
                ),
                postModel.donorId != uId
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: defaultButton(
                                function: () {},
                                text: AppLocalizations.of(context)!
                                    .chatButton
                                    .toUpperCase(),
                                height: 30.0,
                                context: context,
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: Container(
                                height: 30.0,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  color: postModel.receiverId != uId
                                      ? defaultColor
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: MaterialButton(
                                  onPressed: postModel.receiverId != uId
                                      ? () {
                                          FoodCubit.get(context).receiveFood(
                                              postModel: postModel);
                                        }
                                      : () {},
                                  child: state is FoodReceiveFoodLoadingState
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          AppLocalizations.of(context)!
                                              .getButton
                                              .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.white),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
