List<String> student = ['hamza', 'qasim'];
void main(){
  print("it is list activity");
  addstdname('ali');
  print(student);
  removestdname(2);

  print("\nit is set activity");
  Map<String, int> result = {'ali':95, 'ramzan':89};
  print(result['ali']);
  result.putIfAbsent('usman', ()=> 78);
  print(result);
  //for more method check maps.dart file
}
void addstdname(String name){
  student.add(name);
  print("$name add in student list");
}
void removestdname(int index_number){
  if(student.length>index_number){
    student.removeAt(index_number);
    print("name is delete from $index_number index number");
    print(student);
  }
  else{
    print("list size is less than indexnumber");
    print(student);
  }
}