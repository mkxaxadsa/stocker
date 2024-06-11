extension CapitalFirstLetter on String {
  String makeFirstLetterCapital(){
    if(isEmpty) return "";
    if(length == 1) return toUpperCase();
    String result = "";
    List<String> splited = split("");
    List<String> temp = [];
    for(int i = 0; i < splited.length;i++){
      if(i == 0){
        temp.add(splited[i].toUpperCase());
      } else {
        temp.add(splited[i].toLowerCase());
      }
    }
    result = temp.join();
    return result;
  }
}