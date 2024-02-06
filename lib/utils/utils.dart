class Utils {

  List<String> screenTypes = ["Compact", "Medium", "Expanded"];

  // Responsive value decider
  responsive(var compact, var medium, var extended, String screenType){
    if (screenType == screenTypes[2]) { // Extended
      return extended;
    } else if (screenType == screenTypes[1]) { // Medium
      return medium;
    } else if (screenType == screenTypes[0]) { // Compact
      return compact;
    }
  }

}