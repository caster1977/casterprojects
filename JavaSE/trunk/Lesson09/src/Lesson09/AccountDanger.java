package Lesson09;

public class AccountDanger implements Runnable 
{
    private Account acct = new Account();
 
    public static void main(String[] args) 
    {
        AccountDanger r = new AccountDanger();
 
        Thread one = new Thread(r);
        Thread two = new Thread(r);
 
        one.setName("����");
        two.setName("����");
 
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
                System.out.println("������ ������ 0!");
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
    			
    			System.out.println("������������ " + Thread.currentThread().getName()
                    + " �������� �������� �����");
 
    			try 
    			{
    				Thread.sleep(500);
    			} 
    			catch (InterruptedException ex) 
    			{
    			}
 
    			acct.withdraw(amt);
 
    			System.out.println(Thread.currentThread().getName()
                    + " ����� ��������");
 
    		} 
    		else 
    		{
    			System.out.println("������������ ������� �� ����� ��� ������� � ������ "
                    + Thread.currentThread().getName()
                    + ". �������� ��� ������: " + acct.getBalance());
    		}
    	}
    }
}
