//sets not allowed duplication in output or results and searching is faster then list
void main(){
  Set<int> num = {1,2,3,4,3,5,6,4};
  num.add(0); //add at the end of set
  print(num);
  print(num.contains(4)); //check 1 value
  print(num.containsAll([4,3,5])); //check multiple vale
  print(num.lookup(9)); //check if value exist print value otherwise null
  print(num.toString()); //it convert it into simple text
  print(num.toList()); //it convert it into list
}