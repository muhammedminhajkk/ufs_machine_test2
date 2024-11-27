class Categories {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  Categories({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        idCategory: json["idCategory"],
        strCategory: json["strCategory"],
        strCategoryThumb: json["strCategoryThumb"],
        strCategoryDescription: json["strCategoryDescription"],
      );

  Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
      };
}

class CategoryModel {
  List<Categories> categoriesitems;

  CategoryModel({
    required this.categoriesitems,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoriesitems: List<Categories>.from(
            json["categories"].map((x) => Categories.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories":
            List<dynamic>.from(categoriesitems.map((x) => x.toJson())),
      };
}
