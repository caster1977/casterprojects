package Lesson05;

public class Circle implements IShape {
	private double radius;
	
	public Circle() {
		super();
	}
	
	public Circle(double radius) {
		super();
		this.radius = radius;
	}

	public double getRadius() {
		return radius;
	}

	public void setRadius(double radius) {
		this.radius = radius;
	}

	@Override
	public double getSquare() 
	{
		return Math.PI*radius*radius;
	}

	@Override
	public double getPerimeter() 		
	{
		return Math.PI*radius;
	}

	@Override
	public String toString() 
	{
		return "КРУГ\nРадиус: "+ getRadius() + "\nПлощадь: "+ getSquare() +"\nПериметр: "+ getPerimeter()+"\n";
	}

}
