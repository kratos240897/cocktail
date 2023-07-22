import 'package:json_annotation/json_annotation.dart';

part 'cocktail_response.g.dart';

@JsonSerializable()
class CocktailResponse {
  CocktailResponse({
    required this.drinks,
  });
  late final List<Drink> drinks;

  factory CocktailResponse.fromJson(Map<String, dynamic> json) =>
      _$CocktailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CocktailResponseToJson(this);
}

@JsonSerializable()
class Drink {
  Drink({
    required this.idDrink,
    required this.strDrink,
    this.strDrinkAlternate,
    this.strTags,
    this.strVideo,
    required this.strCategory,
    this.strIBA,
    required this.strAlcoholic,
    required this.strGlass,
    required this.strInstructions,
    this.strInstructionsES,
    this.strInstructionsDE,
    this.strInstructionsFR,
    this.strInstructionsIT,
    this.strInstructionsZHHANS,
    this.strInstructionsZHHANT,
    this.strDrinkThumb,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    this.strImageSource,
    this.strImageAttribution,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });
  late final String idDrink;
  late final String strDrink;
  late final String? strDrinkAlternate;
  late final String? strTags;
  late final String? strVideo;
  late final String strCategory;
  late final String? strIBA;
  late final String strAlcoholic;
  late final String strGlass;
  late final String strInstructions;
  late final String? strInstructionsES;
  late final String? strInstructionsDE;
  late final String? strInstructionsFR;
  late final String? strInstructionsIT;
  @JsonKey(name: 'strInstructionsZH-HANS')
  late final String? strInstructionsZHHANS;
  @JsonKey(name: 'strInstructionsZH-HANT')
  late final String? strInstructionsZHHANT;
  late final String? strDrinkThumb;
  late final String? strIngredient1;
  late final String? strIngredient2;
  late final String? strIngredient3;
  late final String? strIngredient4;
  late final String? strIngredient5;
  late final String? strIngredient6;
  late final String? strIngredient7;
  late final String? strIngredient8;
  late final String? strIngredient9;
  late final String? strIngredient10;
  late final String? strIngredient11;
  late final String? strIngredient12;
  late final String? strIngredient13;
  late final String? strIngredient14;
  late final String? strIngredient15;
  late final String? strMeasure1;
  late final String? strMeasure2;
  late final String? strMeasure3;
  late final String? strMeasure4;
  late final String? strMeasure5;
  late final String? strMeasure6;
  late final String? strMeasure7;
  late final String? strMeasure8;
  late final String? strMeasure9;
  late final String? strMeasure10;
  late final String? strMeasure11;
  late final String? strMeasure12;
  late final String? strMeasure13;
  late final String? strMeasure14;
  late final String? strMeasure15;
  late final String? strImageSource;
  late final String? strImageAttribution;
  late final String? strCreativeCommonsConfirmed;
  late final String? dateModified;

  factory Drink.fromJson(Map<String, dynamic> json) => _$DrinkFromJson(json);
  Map<String, dynamic> toJson() => _$DrinkToJson(this);
}
