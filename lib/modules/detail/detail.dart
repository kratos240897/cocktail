// ignore_for_file: must_be_immutable

import 'dart:isolate';

import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/base/service_locator.dart';
import '../home/data/models/cocktail_response.dart';

class Detail extends HookWidget {
  final Drinks drink;
  late List<Widget> ingredients;
  Detail({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);
    useEffect(() {
      Future.microtask(() async {
        ingredients = await getIngredients(drink);
        isLoading.value = false;
      });
      return null;
    }, []);
    return Scaffold(
      body: isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: Key(drink.idDrink),
                          transitionOnUserGestures: true,
                          child: Image.network(
                            drink.strDrinkThumb ?? '',
                            height: 0.5.sh,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 16.h,
                          top: MediaQuery.of(context).viewPadding.top,
                          child: GestureDetector(
                            onTap: () => serviceLocator<NavigationService>().goBack(),
                            child: Container(
                              padding: EdgeInsets.all(16.spMin),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.5.sh,
                    )
                  ],
                ),
                Positioned(
                  left: -5.0,
                  right: -5.0,
                  bottom: 0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.r),
                            topRight: Radius.circular(40.r))),
                    child: SizedBox(
                      height: 0.6.sh,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(18.w, 22.h, 18.w, 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                drink.strDrink,
                                style: Styles.textStyles.f18Bold().copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                              2.verticalSpace,
                              Text(
                                drink.strCategory,
                                style: Styles.textStyles.f16Bold(),
                              ),
                              16.verticalSpace,
                              Text(
                                'INSTRUCTIONS',
                                style: Styles.textStyles
                                    .f14Bold()
                                    .copyWith(letterSpacing: 1.2)
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                              2.verticalSpace,
                              Text(
                                drink.strInstructions,
                                style: Styles.textStyles
                                    .f14Regular()
                                    .copyWith(height: 1.6),
                              ),
                              16.verticalSpace,
                              Text(
                                'INGREDIENTS',
                                style: Styles.textStyles
                                    .f14Bold()
                                    .copyWith(letterSpacing: 1.2)
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                              2.verticalSpace,
                              ...ingredients,
                              16.verticalSpace,
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14.r)),
                                      minimumSize: Size(double.infinity, 40.h)),
                                  onPressed: () {},
                                  child: Text(
                                    'Try it out!',
                                    style: Styles.textStyles.f16Regular(),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Future<List<Widget>> getIngredients(Drinks drink) async {
    ReceivePort receivePort = ReceivePort();
    Isolate isolate =
        await Isolate.spawn(parseIngredients, [drink, receivePort.sendPort]);
    final result = await receivePort.first as List<Widget>;
    receivePort.close();
    isolate.kill();
    return result;
  }

  void parseIngredients(List<dynamic> args) {
    final Drinks drink = args[0];
    final SendPort sendPort = args[1];
    final List<Widget> ingredients = [];
    if (drink.strIngredient1 != null) {
      ingredients
          .add(IngredientsListItem(count: '1', label: drink.strIngredient1!));
    }
    if (drink.strIngredient2 != null) {
      ingredients
          .add(IngredientsListItem(count: '2', label: drink.strIngredient2!));
    }
    if (drink.strIngredient3 != null) {
      ingredients
          .add(IngredientsListItem(count: '3', label: drink.strIngredient3!));
    }
    if (drink.strIngredient4 != null) {
      ingredients
          .add(IngredientsListItem(count: '4', label: drink.strIngredient4!));
    }
    if (drink.strIngredient5 != null) {
      ingredients
          .add(IngredientsListItem(count: '5', label: drink.strIngredient5!));
    }
    if (drink.strIngredient6 != null) {
      ingredients
          .add(IngredientsListItem(count: '6', label: drink.strIngredient6!));
    }
    if (drink.strIngredient7 != null) {
      ingredients
          .add(IngredientsListItem(count: '7', label: drink.strIngredient7!));
    }
    if (drink.strIngredient8 != null) {
      ingredients
          .add(IngredientsListItem(count: '8', label: drink.strIngredient8!));
    }
    if (drink.strIngredient9 != null) {
      ingredients
          .add(IngredientsListItem(count: '9', label: drink.strIngredient9!));
    }
    if (drink.strIngredient10 != null) {
      ingredients
          .add(IngredientsListItem(count: '10', label: drink.strIngredient10!));
    }
    if (drink.strIngredient11 != null) {
      ingredients
          .add(IngredientsListItem(count: '11', label: drink.strIngredient11!));
    }
    if (drink.strIngredient12 != null) {
      ingredients
          .add(IngredientsListItem(count: '12', label: drink.strIngredient12!));
    }
    if (drink.strIngredient13 != null) {
      ingredients
          .add(IngredientsListItem(count: '13', label: drink.strIngredient13!));
    }
    if (drink.strIngredient14 != null) {
      ingredients
          .add(IngredientsListItem(count: '14', label: drink.strIngredient14!));
    }
    if (drink.strIngredient15 != null) {
      ingredients
          .add(IngredientsListItem(count: '15', label: drink.strIngredient15!));
    }
    sendPort.send(ingredients);
  }
}

class IngredientsListItem extends StatelessWidget {
  final String count;
  final String label;
  const IngredientsListItem({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.spMin),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).primaryColor)),
          child: Text(
            count,
            style: Styles.textStyles.f14Regular(),
          ),
        ),
        6.horizontalSpace,
        Text(
          label,
          style: Styles.textStyles.f14Regular(),
        )
      ],
    );
  }
}
