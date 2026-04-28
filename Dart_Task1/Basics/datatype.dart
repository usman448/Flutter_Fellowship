//where we use datatype with variable at the time of initialization that are called explicit type variable
void main(){
  int a;
  a=10;
  print(a);
  double b=2.2;
  print(b);
  String name = "Ramzan";
  print(name);
  bool check =true;
  print(check);
  final time = DateTime.now(); //fix value at the runtime only once
  print(time);
  dynamic x = 10; x = "Hello"; //it allow to change datatype
  print(x);
  var y = 15; //it allow to save any type of data but once set we donnot change the type of variable
  print(y);
  const pi = 3.14; //it value will be fixed on compile time and never change
  print(pi);
  //list, set, map or object also data type we will cover it later also called collection data types
}