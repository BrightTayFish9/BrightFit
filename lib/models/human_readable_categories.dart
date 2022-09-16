import 'package:bright_fit/models/wp_category.dart';

class HumanReadableCategories{
  static String videos = "VIDEOS";
  static String quotes = "QUOTES";
  static String education = "EDUCATION";
  static String recipes = "RECIPES";

  static List<String> labels = [videos, quotes, education, recipes];

  static Map<String, int> mappedLabels = {
    videos: WPCategoryCodes.video,
    quotes: WPCategoryCodes.quote,
    education: WPCategoryCodes.education,
    recipes: WPCategoryCodes.recipe
  };

  static String parse(String str){
    str = str.toUpperCase();
    switch(str){
      case 'VIDEO OF THE WEEK':
        return videos;
      case 'QUOTE OF THE WEEK':
        return quotes;
      case 'EDUCATION OF THE WEEK':
        return education;
      case 'RECIPE OF THE WEEK':
        return recipes;
      default:
        throw new Error();
    }
  }
}