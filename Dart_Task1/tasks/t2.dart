void main(){
  int a = 512;
  int b = 34;
  int c = 233;
  if(a>b && a>c){
    print("a is greater number $a");
  }
  else if(b>a && b>c){
    print("b is greater number $b");
  }
  else{
    print("c is greater number $c");
  }

  for(int i=1; i<=10; i++){
    int tablenumber = 5;
    int result = tablenumber*i;
    print("$tablenumber * $i = $result");
  }
}