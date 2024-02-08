class Utils {

  List<String> screenTypes = ["Very Compact", "Compact", "Medium", "Expanded"];

  // Responsive value decider
  responsive(var veryCompact, var compact, var medium, var extended, String screenType){
    if (screenType == screenTypes[3]) { // Extended
      return extended;
    } else if (screenType == screenTypes[2]) { // Medium
      return medium;
    } else if (screenType == screenTypes[1]) { // Compact
      return compact;
    } else if (screenType == screenTypes[0]) {
      return veryCompact;
    }
  }

}