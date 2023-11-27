import 'package:cocktail/features/domain/entities/drink.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drink_dto.g.dart';

@JsonSerializable()
class DrinkDto extends Drink {
  DrinkDto(
      {required super.idDrink,
      required super.strDrink,
      required super.strDrinkAlternate,
      required super.strTags,
      required super.strVideo,
      required super.strCategory,
      required super.strAlcoholic,
      required super.strGlass,
      required super.strInstructions,
      required super.strDrinkThumb,
      required super.strIngredient1,
      required super.strIngredient2,
      required super.strIngredient3,
      required super.strIngredient4,
      required super.strIngredient5,
      required super.strIngredient6,
      required super.strIngredient7,
      required super.strIngredient8,
      required super.strIngredient9,
      required super.strIngredient10,
      required super.strIngredient11,
      required super.strIngredient12,
      required super.strIngredient13,
      required super.strIngredient14,
      required super.strIngredient15,
      required super.strMeasure1,
      required super.strMeasure2,
      required super.strMeasure3,
      required super.strMeasure4,
      required super.strMeasure5,
      required super.strMeasure6,
      required super.strMeasure7,
      required super.strMeasure8,
      required super.strMeasure9,
      required super.strMeasure10,
      required super.strMeasure11,
      required super.strMeasure12,
      required super.strMeasure13,
      required super.strMeasure14,
      required super.strMeasure15,
      required super.strImageSource});

  factory DrinkDto.fromJson(Map<String, dynamic> json) =>
      _$DrinkDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DrinkDtoToJson(this);
}
