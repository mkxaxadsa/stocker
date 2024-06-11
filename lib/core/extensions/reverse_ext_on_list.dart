extension Reverse<T> on List<T>{
  List<T> reverseWhen(bool condition){
    if(condition == true){
      return reversed.toList();
    }
    return this;
  } 
}