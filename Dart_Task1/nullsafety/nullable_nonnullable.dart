//by default in dart no variable will be null 
// we use this ? sign with data type it store null as default
void main(){
  String name="ramzan"; 
  // name = null not allowed
  print(name);

  int? age; //this ? save null by default 
  print(age);
  age = 30; //allow to change value
  print(age);
  age = null; //allow again to assign it null
  print(age);

}