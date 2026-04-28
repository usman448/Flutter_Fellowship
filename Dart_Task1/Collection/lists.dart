//list maintain order and also allow duplicates
void main(){
  List<String> student = ['hamza','ali','ramzan','ali'];
  print(student);
  student.add('fizan'); // it will add at the end of list
  student.insert(0, 'ali'); // add specific index
  student.remove('hamza'); // delete by giving value
  student.removeAt(3); //delte by giving index
  List<String> marks = ['amna','anila','hamna'];
  student.addAll(['siyam','abdullah']); //add multiple value 
  student.addAll(marks);//add full new another list
  for(var s in student){
    print(s);
  }
  student.sort(); //sort list by character or number //.clear is used to delete all data
  print("new list");
  student.forEach((s) => print(s)); //print list item by using foreach loop with arrow function syntax

  var uppercase = student.map((s)=>s.toUpperCase()); //map function implement on whole list its size is equal or greater than actual list
  print(uppercase);

  var check_length = student.where((s) => s.length>3);
  print(check_length);
}