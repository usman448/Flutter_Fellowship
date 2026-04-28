import 'dart:io';
void main(){
  print("Enter table number which you want to print : ");
  int number = int.parse(stdin.readLineSync()!);
  print("Enter limit of table 10,20,etc......");
  int limit = int.parse(stdin.readLineSync()!);
  for(int i=1; i<=limit; i++){
    int result = number*i;
    print("$number * $i = $result");
  }
}