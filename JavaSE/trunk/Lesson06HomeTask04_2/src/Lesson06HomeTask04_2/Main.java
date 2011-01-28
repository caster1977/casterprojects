/* 
”рок 6. «адание 2. ¬ариант 4. 
¬о всех вопросительных предложени€х текста найти и напечатать без повторений слова заданной длины. 
*/
package Lesson06HomeTask04_2;

import java.util.Scanner;
import java.util.StringTokenizer;

public class Main 
{
	private static String Text = "E8-YS9 Solar System, EL8Z-M Constellation, Immensea Region\n" +
	"20.01.106 - 05:41 EVT\n"+
	"Failure always begets reflection, and Mattias found himself asking the same question over and over again:\n"+  
	"How could it have come to this?\n"+ 
	"He stared in crushed disbelief at the rippling translucent inner membrane of the warp tunnel, watching the planets and moons of the E8-YS9 system shoot past his ship. The Blackbird-class cruiser at his command was hurtling through the tunnel at hundreds of times the speed of light. Mattias was amazed the battered vessel was still capable of sustaining this speed without breaking apart.\n"+ 
	"We were so close to killing him, he thought. So very, very close.\n"+ 
	"The tragedy would not be in his own death, but in the fact that his prey would continue to live out its wretched, despicable existence. For Mattias and the team of loyal bounty hunters that he had dedicated his life to, this was the ultimate failure. They had lost the bounty, were about to lose their lives, and worst of all, lost an opportunity to do some good in a galaxy controlled by greed and evil above all else.\n"+ 
	"УDo you believe in God, Mattias?Ф asked the voice of his enemy. Mattias cursed his own misfortune and refused to answer.\n"+ 
	"УAnd what of the Amarr and Minmatar comrades that you are leading to death?Ф the wicked voice sneered. УAre they believers in an afterlife?Ф\n"+ 
	"In an instant, Mattias thought of the entire history of the two outstanding bounty huntersЧand great friendsЧwhose lives were in as much peril as his own. Kirlana was an Amarr by birth, but had rebelled against her lavish upbringing and become ashamed of her cultural roots. She renounced her family name and turned her back on the fortune that would have been hers by birthright. The only УpossessionФ she took with her was Matuno, the Brutor slave that had looked after her since childhood. She transformed him into an independent, Tempest-class battleship captain. Now, he answered to no one. But he would never forget those he was beholden to.\n"+ 
	"Forever grateful for being set free of Amarrian bondage, Matuno found himself unable to leave Kirlana's side, and together they sought greater purpose in life. After months of wandering Empire space, fate would introduce them to Mattias Kakkichi. Inspired by his passion for truth and justice, they readily joined his self-appointed mission: To become the arm of justice where the laws of Empire space could not reach. The money received from collected bounties was unimportant to them. The real reward was the righted wrong, accomplished through the kill itself. Watching evil succumb to the thunder of guns filled each of their souls with delicious satisfaction. No single feeling was more powerful than knowing that an injustice had been avenged. But on this day, the odds of lethal misfortune for pursuing such a risky profession finally caught up with them.\n"+ 
	"Mattias, Kirlana, and Matuno were fleeing from the scene of an assassination attempt on Trald Vukenda, the leader of the infamous Angel Cartel and the highest profile target they had ever hunted. The operation had gone horribly wrong. Within sight of their prey, the enemy surprised the bounty hunters with reinforcements, and they suddenly found themselves greatly outnumbered. Their ships were punished almost to the breaking point, and they were lucky to have escaped into warp. But there were only two jumpgates leading out of the system, and Trald already knew which one the bounty hunters were running towards. Both exits were already blockaded by Angel Cartel ships.\n"+
	"УI'm going to nail your self-righteous corpse to that jumpgate, Mattias,Ф snarled Trald. УAs a reminder to others about the perils in pursuing delusional moral obligations.Ф"; 

	public static void main(String[] args) 
	{

		Scanner sc = new Scanner(System.in);
		int len = 0;
		boolean flag = false;
		while (! flag)
		{
			System.out.print("¬ведите длину слов, которые нужно выбрать без повторений из вопросительных предложений или нажмите Ctrl+Z дл€ выхода: ");
			if (sc.hasNextInt())
			{
				flag = true;
				len = sc.nextInt();
			}
			else 
			{
				System.out.println("ќшибка: введено отличное от целочисленного значение!");
				sc.next();
			}
		}
		sc.close();

		// делим текст на предложени€ и разделители
		StringTokenizer stringTokenizer = new StringTokenizer(Text,"\n:.!?",true);
		String last = "";
		String current = "";
		String[] dic = new String[0];
		String[] dicUnique = new String[0];

		while (stringTokenizer.hasMoreTokens()) 
		{
			// сохран€ем очередное предложение во временной переменной
			last = current; 
			// получаем очередное "предложение" 
			current = stringTokenizer.nextToken().trim();
			//System.out.println(current.toString());

			// если полученное предложение €вл€етс€ токеном "?"
			if (current.equals("?")==true)
			{
				// добавл€ем предыдущее предложение в массив предложений  
				String[] dic2 = new String[dic.length + 1];
				System.arraycopy(dic, 0, dic2, 0, dic.length);
				dic2[dic.length] = last+current;
				dic = new String[dic2.length];
				System.arraycopy(dic2, 0, dic, 0, dic2.length);
				//System.out.println(last+current);
			}
	    }
		// вывод результатов отбора вопросительных предложегний
		if (dic.length>0)
		{
			System.out.println("\n—писок вопросительных предложений:");
			for (int i = 0; i < dic.length; i++) 
			{
				System.out.println(dic[i]);
			}
			
			// разбиение вопросительных предложений на слова и выборка уникальных слов указанной длины
			
			for (int i = 0; i < dic.length; i++)
			{
				StringTokenizer stringTokenizer2 = new StringTokenizer(dic[i]," \n\t,.:;!?УФ-\"");
				while (stringTokenizer2.hasMoreTokens()) 
				{
					// получаем очередное слово 
					String tok = stringTokenizer2.nextToken().trim();
					if (tok.length()==len)
					{
						// ищем слово среди уже существующих в массиве слов
						boolean b = false;
						for (int j = 0; j < dicUnique.length; j++) 
						{
							String string = dicUnique[j];
							// если слово найдено
							if (string.equalsIgnoreCase(tok)==true)
							{
								b = true;
								break;
							}
						}
						// если слово не было найдено в списке слов нужной длины
						if (b==false)
						{
							// добавл€ем слово в массив слов нужной длины
							String[] dic2 = new String[dicUnique.length + 1];
							System.arraycopy(dicUnique, 0, dic2, 0, dicUnique.length);
							dic2[dicUnique.length] = tok;
							dicUnique = new String[dic2.length];
							System.arraycopy(dic2, 0, dicUnique, 0, dic2.length);
							// System.out.println(tok);
						}
					}
				}
			}
			if (dicUnique.length>0)
			{
				System.out.printf("\n—писок уникальных слов указанной длины (%d):\n",len);
				for (int i = 0; i < dicUnique.length; i++) 
					System.out.println(dicUnique[i]);
			}
			else System.out.printf("\n¬ вопросительных предложени€х не найдено ни одного слово указанной длины (%d)!\n", len);
		}
		else System.out.printf("\nЌе найдено ни одного вопросительного предложени€!\n", len);
	}
}
