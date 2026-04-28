import 'dart:io'; //it is used to get input from user

//basic structure of dart code start from main() function print(keyword) is used for to print output
void main() {
  print("Enter your name: ");
  String? name = stdin.readLineSync(); //this line is used for take input from user stringtype
  print('Hello, $name');
  
  print("Enter your age: ");
  int age = int.parse(stdin.readLineSync()!); //this line is used for take input from user integer
  print('Hello, $age');
}
