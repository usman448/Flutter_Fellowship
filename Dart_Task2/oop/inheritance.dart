//to access parent class data by using inheritance

class Person{ //parent class
  String name;

  Person(this.name); //constructor
  
  void display(){ 
    print("Name: $name \n--------");
  }
}

class Student extends Person{ //child class
  int rollno;

  Student(String name, this.rollno) : super(name); // parent class constructor calling super(name) 

  void displayinfo(){
    print("Name: $name \nRollnumber: $rollno");
  }
}

void main(){
  Student s1 = new Student("Hamza", 23);
  s1.display();
  s1.displayinfo();
}