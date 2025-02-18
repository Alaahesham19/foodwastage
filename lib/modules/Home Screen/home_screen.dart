import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      builder: (BuildContext context, state) {
        return BuildCondition(
          condition: FoodCubit.get(context).postsList.isNotEmpty &&
              FoodCubit.get(context).userModel != null,
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: filtersButtons(context),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => postBuilder(
                          viewPost: true,
                          postModel: FoodCubit.get(context).isSearching
                              ? FoodCubit.get(context).searchedForPosts[index]
                              : FoodCubit.get(context).filterValue == 'All'
                                  ? FoodCubit.get(context).postsList[index]
                                  : FoodCubit.get(context).filteredPosts[index],
                          context: context,
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 20.0,
                        ),
                    itemCount: FoodCubit.get(context).isSearching
                        ? FoodCubit.get(context).searchedForPosts.length
                        : FoodCubit.get(context).filterValue == 'All'
                            ? FoodCubit.get(context).postsList.length
                            : FoodCubit.get(context).filteredPosts.length),
              ),
            ],
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget filtersButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        filterButton(
            context: context,
            filterValue: FoodCubit.get(context).filterValue,
            text: AppLocalizations.of(context)!.filterButtonAll,
            value: 'All',
            onPressed: () {
              FoodCubit.get(context).filterPosts('All');
            }),
        const SizedBox(
          width: 7.0,
        ),
        filterButton(
            context: context,
            filterValue: FoodCubit.get(context).filterValue,
            text: AppLocalizations.of(context)!.filterButtonMainDishes,
            value: 'Main dishes',
            onPressed: () {
              FoodCubit.get(context).filterPosts('Main dishes');
            }),
        const SizedBox(
          width: 7.0,
        ),
        filterButton(
            context: context,
            filterValue: FoodCubit.get(context).filterValue,
            text: AppLocalizations.of(context)!.filterButtonDesserts,
            value: 'Desserts',
            onPressed: () {
              FoodCubit.get(context).filterPosts('Desserts');
            }),
        const SizedBox(
          width: 7.0,
        ),
        filterButton(
            context: context,
            filterValue: FoodCubit.get(context).filterValue,
            text: AppLocalizations.of(context)!.filterButtonSandwiches,
            value: 'Sandwiches',
            onPressed: () {
              FoodCubit.get(context).filterPosts('Sandwiches');
            }),
      ],
    );
  }
}
