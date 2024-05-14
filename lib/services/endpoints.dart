class Endpoints {
  static String login() => "auth/login";
  static String register() => "auth/register";
  static String addUserInfo() => "User/addPersonalInfo";

  static String getFoods({String? searchText, int? page, int? pageSize}) {
    var queryParams = <String, dynamic>{};
    if (searchText != null) queryParams['SearchText'] = searchText;
    if (page != null) queryParams['Page'] = page;
    if (pageSize != null) queryParams['PageSize'] = pageSize;

    var queryString = Uri(queryParameters: queryParams).query;
    return "Ingredient/get?$queryString";
  }

  static String getHealts({String? searchText, int? page, int? pageSize}) {
    var queryParams = <String, dynamic>{};
    if (searchText != null) queryParams['SearchText'] = searchText;
    if (page != null) queryParams['Page'] = page;
    if (pageSize != null) queryParams['PageSize'] = pageSize;

    var queryString = Uri(queryParameters: queryParams).query;
    return "Health/get?$queryString";
  }

  static String getCuisines({String? searchText, int? page, int? pageSize}) {
    var queryParams = <String, dynamic>{};
    if (searchText != null) queryParams['SearchText'] = searchText;
    if (page != null) queryParams['Page'] = page;
    if (pageSize != null) queryParams['PageSize'] = pageSize;

    var queryString = Uri(queryParameters: queryParams).query;
    return "CuisinePreference/get?$queryString";
  }

  static String getRecipes({String? searchText, int? page, int? pageSize}) {
    var queryParams = <String, dynamic>{};
    if (searchText != null) queryParams['SearchText'] = searchText;
    if (page != null) queryParams['Page'] = page;
    if (pageSize != null) queryParams['PageSize'] = pageSize;

    var queryString = Uri(queryParameters: queryParams).query;
    return "Recipe/get?$queryString";
  }
}
