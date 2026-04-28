import 'dart:io';

List<String> studentlist = [];
Map<String, int> studentmarks ={};

void addstd(String name, int marks){
  studentlist.add(name);
  studentmarks[name] = marks;
  print("$name add succesfully");
}

void showstd(){
  if(studentlist.isEmpty){
    print("no student in list");
  }
  else{
    for(var name in studentlist){
      print("Name: $name  Marks ${studentmarks[name]}");
    }
  }
}

void removestd(String name){
  if(studentlist.contains(name)){
    studentlist.remove(name);
    studentmarks.remove(name);
    print("$name remove sucessfully");
  }else{
    print("$name not exist");
  }
}

void main(){
  while(true){
    print("---Welcome to Student Manager---");
    print("1. Add Student");
    print("2. View All Students");
    print("3. Remove Student");
    print("4. Exit");
    print("Enter your choice ");
    int choice = int.parse(stdin.readLineSync()!);
    switch(choice){
      case 1:
        addstd('ali', 56);
        break;
      case 2:
        showstd();
        break;
      case 3:
        removestd('hamza');
        break;
      case 4:
        return;
      default:
        print("invalid choice");
    }
  }
}