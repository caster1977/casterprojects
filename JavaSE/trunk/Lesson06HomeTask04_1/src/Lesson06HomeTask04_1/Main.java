/*
”рок 6. «адание 1. ¬ариант 4. 
¬ тексте слова заданной длины заменить указанной подстрокой, длина которой может не совпадать с длиной слова. 
*/

package Lesson06HomeTask04_1;

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
		"УI'm going to nail your self-righteous corpse to that jumpgate, Mattias,Ф snarled Trald. УAs a reminder to others about the perils in pursuing delusional moral obligations.Ф\n"; 
		
	public static void main(String[] args) 
	{
		Scanner sc = new Scanner(System.in);
		int len = 0;
		boolean flag = false;
		String substring = ""; 

		while (! flag)
		{
			System.out.print("¬ведите длину слов, которые нужно заменить на указанную подстроку или нажмите Ctrl+Z дл€ выхода: ");
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
		
		flag = false;
		while (! flag)
		{
			System.out.print("¬ведите подстроку дл€ вставки вместо слов укащанной длины или нажмите Ctrl+Z дл€ выхода: ");
			if (sc.hasNext())
			{
				flag = true;
				substring = sc.next();
			}
		}
		
		sc.close();
		
		System.out.printf("\n»сходный текст: \n\n%s", Text);		

		System.out.printf("\nЅудет произведЄна замена слов длинной %d на строку %s.\n", len, substring); 

		String tokens = " \n\t,.:;!?УФ-\"";
		StringTokenizer stringTokenizer = new StringTokenizer(Text, tokens);
		String[] dic = new String[0];
		

		while (stringTokenizer.hasMoreTokens()) 
		{
			// получение очередного слова 
			String s = stringTokenizer.nextToken().trim();

			// если слово имеет указанную пользователем длину, добавл€ем слово в масссив-словарь
			if (s.length()==len)
			{
				// добавление нововго элемента в 
				String[] dic2 = new String[dic.length + 1];
				System.arraycopy(dic, 0, dic2, 0, dic.length);
				dic2[dic.length] = s;
				dic = new String[dic2.length];
				System.arraycopy(dic2, 0, dic, 0, dic2.length);
			}
		}		

		// вывод содержимого массива-словар€
		if (dic.length>0)
		{
			System.out.printf("\nЌайдено %d слов длиной %d символов:\n", dic.length, len);
			for (int m=0;m<dic.length;m++)
				System.out.println(dic[m]);

			StringBuffer sb = new StringBuffer(Text);
			
			for (int m=0;m<dic.length;m++)
			{
				// находим первое упоминание слова в тексте 
				int k = sb.indexOf(dic[m], 0);
				// если оно было найдено, замен€ем его на указанную подстроку
				if (k>-1)
				{
					// провер€ем, не €вл€етс€ ли найдена€ подстрока частью большого слова

					// провер€ем, €вл€етс€ ли подстрока началом слова
					boolean WordStart = false;
					// если подстрока не находитс€ в начале текста
					if (k>0)
					{
						// получаем символ до начала подстроки
						Character before = sb.charAt(k-1);
						// если символ €вл€етс€ разделителем слов
						if (tokens.contains(before.toString())==true)
							WordStart = true;
					}
					else 
						if (k==0)
							WordStart = true;
					
					// провер€ем, €вл€етс€ ли подстрока концом слова
					boolean WordStop = false;
					// если подстрока не находитс€ в конце текста
					if ((k+len)<sb.length())
					{
						// получаем символ до начала подстроки
						Character after = sb.charAt(k+len);
						// если символ €вл€етс€ разделителем слов
						if (tokens.contains(after.toString())==true)
							WordStop = true;
					}
					else 
						if ((k+len)==sb.length())
							WordStop = true;
					
					if (WordStart && WordStop)
						sb.replace(k, k+len, substring);
				}
			}
			System.out.printf("\n–езультирующий текст: \n\n%s", sb.toString());			
		}
		else System.out.printf("\nЌе найдено ни одного слова длиной %d символов!\n", len);
	}
}
