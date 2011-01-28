package Lesson09;

class Account 
{
    private int balance = 3000000;
 
    public int getBalance() 
    {
        return balance;
    }
 
    public void withdraw(int amount) 
    {
        balance = balance - amount;
    }
}
