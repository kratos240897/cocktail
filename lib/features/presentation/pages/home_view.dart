import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktail/features/presentation/pages/detail.dart';
import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../config/theme/theme_bloc.dart';
import '../../../core/utils/debounce.dart';
import '../../domain/entities/drink.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/animated_visibility.dart';

class HomeView extends HookWidget {
  const HomeView({super.key});

  static const route = '/home';
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeCubit>();

    final themeColor = useState(Styles.colors.kPrimaryColor);
    useEffect(() {
      Future.microtask(() => cubit.fetchDrinks());
      return null;
    }, []);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(22.w, 16.h, 22.w, 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => showColorPickerDialog(context, themeColor),
                      child: Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.purple,
                                  Colors.red,
                                  Colors.green,
                                  Colors.blue
                                ])),
                      ),
                    ),
                  ),
                  Text(
                    'Beat the heat 🥵\nwith our refreshing Cocktails 🍹',
                    style:
                        Styles.textStyles.f18SemiBold().copyWith(height: 1.5),
                  ),
                  8.verticalSpace,
                  CustomSearchBar(cubit: cubit),
                ],
              ),
              16.verticalSpace,
              Expanded(
                  child: switch (cubit.state) {
                HomeLoadingState() =>
                  const Center(child: CircularProgressIndicator()),
                HomeLoadedState(drinks: var drinks) => drinks.isEmpty
                    ? const InfoWidget(message: 'No results found.')
                    : DrinkList(drinks: drinks),
                HomeErrorState(errorMessage: var errorMessage) =>
                  InfoWidget(message: errorMessage),
                HomeInitial() => const SizedBox.shrink()
              })
            ],
          ),
        ),
      ),
    );
  }

  showColorPickerDialog(
      BuildContext context, ValueNotifier<MaterialColor> themeColor) {
    final cubit = BlocProvider.of<ThemeCubit>(context);
    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 150),
        pageBuilder: (context, animation, secondaryAnimation) => Container(),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          final curve = Curves.easeInOut.transform(animation.value);
          return Transform.scale(
            scale: curve,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r)),
              title: Text(
                'Pick a color',
                style: Styles.textStyles.f16SemiBold(),
              ),
              content: SingleChildScrollView(
                  child: ColorPicker(
                pickerColor: themeColor.value,
                onColorChanged: (value) =>
                    themeColor.value = Utils.getMaterialColorFromColor(value),
              )),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      'Cancel',
                      style: Styles.textStyles.f14SemiBold(color: Colors.grey),
                    )),
                TextButton(
                    onPressed: () {
                      cubit.changeTheme(themeColor.value);
                      context.pop();
                    },
                    child: Text(
                      'Apply',
                      style: Styles.textStyles.f14SemiBold(),
                    ))
              ],
            ),
          );
        });
  }
}

class InfoWidget extends StatelessWidget {
  final String message;
  const InfoWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      message,
      textAlign: TextAlign.center,
      style: Styles.textStyles.f14Regular(),
    ));
  }
}

class CustomSearchBar extends HookWidget {
  CustomSearchBar({
    super.key,
    required this.cubit,
  });
  final searchController = useTextEditingController();
  final searchFieldHasValue = useState(false);
  final HomeCubit cubit;
  final debounce = Debounce(const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.microtask(() {
        searchController.addListener(() {
          final value = searchController.text.trim();
          if (value.isNotEmpty) {
            searchFieldHasValue.value = true;
            debounce(() => cubit.searchDrinks(value));
          } else {
            searchFieldHasValue.value = false;
            cubit.clearSearch();
          }
        });
      });
      return () {
        searchController.dispose();
      };
    }, []);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.grey.shade200),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
            hintText: 'Start exploring...',
            hintStyle: Styles.textStyles.f14Regular(),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
              size: 24.spMin,
            ),
            suffixIcon: searchFieldHasValue.value
                ? GestureDetector(
                    onTap: () {
                      searchController.clear();
                      searchFieldHasValue.value = false;
                      cubit.clearSearch();
                    },
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                      size: 24.spMin,
                    ),
                  )
                : null,
            border: InputBorder.none),
      ),
    );
  }
}

class DrinkList extends HookWidget {
  final List<Drink> drinks;
  const DrinkList({
    super.key,
    required this.drinks,
  });

  @override
  Widget build(BuildContext context) {
    final isNeedToShowScrollUpButton = useState(false);
    final controller = useScrollController();
    useEffect(() {
      Future.microtask(() => controller.addListener(() =>
          _drinkListScrollListener(controller, isNeedToShowScrollUpButton)));
      return null;
    }, []);
    return Stack(
      children: [
        AnimationLimiter(
          child: ListView.builder(
              controller: controller,
              itemCount: drinks.length,
              itemBuilder: (context, index) {
                final drink = drinks[index];
                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                            child: DrinkListItem(drink: drink))));
              }),
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: AnimatedVisibility(
            isVisible: isNeedToShowScrollUpButton.value,
            child: FloatingActionButton(
              onPressed: () => controller.animateTo(
                  controller.position.minScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn),
              child: const Icon(Icons.arrow_upward),
            ),
          ),
        )
      ],
    );
  }

  void _drinkListScrollListener(ScrollController controller,
      ValueNotifier<bool> isNeedToShowScrollUpButton) {
    if (controller.position.pixels != controller.position.minScrollExtent &&
        controller.position.userScrollDirection == ScrollDirection.forward) {
      isNeedToShowScrollUpButton.value = true;
    } else {
      isNeedToShowScrollUpButton.value = false;
    }
  }
}

class DrinkListItem extends StatelessWidget {
  const DrinkListItem({
    super.key,
    required this.drink,
  });

  final Drink drink;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(DetailView.route, extra: drink),
      child: Card(
        margin: EdgeInsets.only(bottom: 12.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.r),
                      topRight: Radius.circular(22.r)),
                  child: CachedNetworkImage(
                    imageUrl: drink.strDrinkThumb ??
                        'https://b.zmtcdn.com/data/collections/b2f4b4e29c3cee6a3e5820944a71113a_1674844520.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 0.35.sh,
                  ),
                ),
                Positioned(
                    right: 12.w,
                    top: 12.h,
                    child: Container(
                      padding: EdgeInsets.all(16.spMin),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.8)),
                      child: Icon(
                        FontAwesomeIcons.solidHeart,
                        color: Theme.of(context).primaryColor,
                        size: 22.spMin,
                      ),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.spMin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          drink.strDrink,
                          style: Styles.textStyles.f16SemiBold(),
                        ),
                        Text(
                          drink.strCategory,
                          style: Styles.textStyles.f14Regular(),
                        )
                      ],
                    ),
                  ),
                  Text(drink.strAlcoholic,
                      style: Styles.textStyles
                          .f14Bold()
                          .copyWith(color: Theme.of(context).primaryColor))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
