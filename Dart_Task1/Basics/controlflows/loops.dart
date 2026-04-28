//loops are allows to perform same activity as per needed time
//for loop (when we know number of iteration)
//for-in or foreach loop (when we want to check every item of list)
//while loop (it works until conditon will false)
//do-while (it must run 1 time then condition will check)
void main(){
  for(int i=1; i<10; i++){ //10 is not include
    print("count is $i");
  }

  List<String> laptops = ["hp",'dell','toshiba']; //list we will cover in next seesion
  for(var laptop in laptops){
    print("i like $laptop");
  }

  int door_height = 5;
  while(door_height < 12){
    print("we have $door_height feet heighted door");
    door_height++;
  }

  var login_attempt = 0;
  do{
    print("$login_attempt  login attempt "); //this statement will run once without checking condition
    login_attempt++;
  }while(login_attempt<0);
  
}