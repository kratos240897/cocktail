import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/base/service_locator.dart';
import '../../../core/init/routes/routes.dart';
import '../../../core/init/theme/theme_bloc.dart';
import '../data/models/cocktail_response.dart';
import 'bloc/home_bloc.dart';

class Home extends HookWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    final searchController = useTextEditingController();
    final searchFieldHasValue = useState(false);
    final themeColor = useState(Styles.colors.kPrimaryColor);
    useEffect(() {
      Future.microtask(() => bloc.add(FetchDataEvent()));
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
                style: Styles.textStyles.f18SemiBold().copyWith(height: 1.5),
              ),
              8.verticalSpace,
              CustomSearchBar(
                  searchController: searchController,
                  searchFieldHasValue: searchFieldHasValue,
                  bloc: bloc),
              16.verticalSpace,
              Expanded(
                child:
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  if (state is HomeLoadedState) {
                    return state.drinks.isEmpty
                        ? const InfoWidget(message: 'No results found.')
                        : DrinkList(drinks: state.drinks);
                  }
                  if (state is HomeErrorState) {
                    return InfoWidget(message: state.errorMessage);
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  showColorPickerDialog(
      BuildContext context, ValueNotifier<MaterialColor> themeColor) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
                      themeBloc.add(ChangeThemeEvent(color: themeColor.value));
                      serviceLocator<NavigationService>().goBack();
                    },
                    child: Text(
                      'Apply',
                      style: Styles.textStyles.f14SemiBold(),
                    ))
              ],
            ));
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

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.searchController,
    required this.searchFieldHasValue,
    required this.bloc,
  });

  final TextEditingController searchController;
  final ValueNotifier<bool> searchFieldHasValue;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.grey.shade200),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            searchFieldHasValue.value = true;
            bloc.add(SearchEvent(query: value));
          } else {
            searchFieldHasValue.value = false;
            bloc.add(ClearSearchEvent());
          }
        },
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
                      bloc.add(ClearSearchEvent());
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

class DrinkList extends StatelessWidget {
  final List<Drinks> drinks;
  const DrinkList({
    super.key,
    required this.drinks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          final drink = drinks[index];
          return DrinkListItem(drink: drink);
        });
  }
}

class DrinkListItem extends StatelessWidget {
  const DrinkListItem({
    super.key,
    required this.drink,
  });

  final Drinks drink;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => serviceLocator<NavigationService>()
          .goTo(Routes.DETAIL, arguments: drink),
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
                  child: Hero(
                    tag: Key(drink.idDrink),
                    transitionOnUserGestures: true,
                    child: Image.network(
                      drink.strDrinkThumb ??
                          'https://b.zmtcdn.com/data/collections/b2f4b4e29c3cee6a3e5820944a71113a_1674844520.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 0.35.sh,
                    ),
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
                  Column(
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
