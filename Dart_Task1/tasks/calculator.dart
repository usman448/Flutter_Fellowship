import 'dart:io';
void main(){
  int num1 = 23;
  int num2 = 23;
  print("1. Addtion \n2. Subtraction \n3. Multiplication \n4. Division");
  print("Enter operation number : ");
  int operation = int.parse(stdin.readLineSync()!);
  switch(operation){
    case 1:
      num  result = num1 + num2;
      print("Sum of $num1 and $num2 is $result");
      break;
    case 2:
      num  result = num1 - num2;
      print("Subtraction of $num1 and $num2 is $result");
      break;
    case 3:
      num  result = num1 * num2;
      print("Multiplication of $num1 and $num2 is $result");
      break;
    case 4:
      num  result = num1 / num2;
      print("Divsion of $num1 and $num2 is $result");
      break;
    default:
      print("invalid operation");
  }
}