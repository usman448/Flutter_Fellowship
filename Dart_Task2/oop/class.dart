//class is blueprint or template to create objects
//it define the property (what is it ) and behavior (what it does) that all object created from it will have

class Student{
  var name;
  var age;

  // Student(){
  //   print("default constructor run automatically"); //it run automatically when we create object
  // }

  Student(this.name, this.age); //parameterize constructor

  Student.guest() : name = 'guest' , age = 20; //named constructor in this we set default value for variable 
                                               //and change when needed (also create multiple with different named)

  void display(){
    print("Name: $name \nAge: $age");
  }
}
void main(){
  // Student s1 = new Student(); //object (it is a instance of class)
  // s1.name = "ali";
  // s1.age = 23;
  // print(s1.name);
  // print(s1.age);

  Student s1 = new Student('hamza', 12);
  s1.display();
  Student s2 = new Student.guest();
  s2.display();
  s2.name = 'Ramzan';
  s2.display();
}