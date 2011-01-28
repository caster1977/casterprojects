package Lesson09;

public class AccountDanger implements Runnable 
{
    private Account acct = new Account();
 
    public static void main(String[] args) 
    {
        AccountDanger r = new AccountDanger();
 
        Thread one = new Thread(r);
        Thread two = new Thread(r);
 
        one.setName("Вова");
        two.setName("Саша");
 
        one.start();
        two.start();
    }
 
    public void run() 
    {
        for (int x = 0; x < 20; x++) 
        {
        	makeWithdrawal(150000);
 
            if (acct.getBalance() < 0) 
            {
                System.out.println("Баланс меньше 0!");
            }
        }
    }
 
    private 
    //synchronized 
    void makeWithdrawal(int amt) 
    {
    	synchronized(acct)
    	{
    		if (acct.getBalance() >= amt) 
    		{
    			
    			System.out.println("Пользователь " + Thread.currentThread().getName()
                    + " совершил проверку счета");
 
    			try 
    			{
    				Thread.sleep(500);
    			} 
    			catch (InterruptedException ex) 
    			{
    			}
 
    			acct.withdraw(amt);
 
    			System.out.println(Thread.currentThread().getName()
                    + " вывел средства");
 
    		} 
    		else 
    		{
    			System.out.println("Недостаточно средств на счете для клиента с именем "
                    + Thread.currentThread().getName()
                    + ". Доступно для вывода: " + acct.getBalance());
    		}
    	}
    }
}
