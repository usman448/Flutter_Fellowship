//different catagory of operator 
//arithmetic operators (for mathematic calculation)
//rational operetors (for value comparing)
//logical operators (when we need to check conditions)
//assignment operator (for assigning values )
void main(){
int a = 10;
int b = 3;
print(a/b); //by default double
print(a~/b); //answer in integer 
print(a%b);

int speed = 80;
print(speed > 100); 
print(speed == 80);  
print(speed != 0);  

double balance = 1000;
balance += 500; //increase balance
print(balance);
balance -= 200; // decrease balance
print(balance);
balance *= 2;   //double balance
print(balance);
}