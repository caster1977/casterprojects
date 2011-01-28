package Lesson05;

public abstract class Triangle implements IShape 
{
	private double width1, width2, width3;

	public double getWidth1() {
		return width1;
	}

	public void setWidth1(double width1) {
		this.width1 = width1;
	}

	public double getWidth2() {
		return width2;
	}

	public void setWidth2(double width2) {
		this.width2 = width2;
	}

	public double getWidth3() {
		return width3;
	}

	public void setWidth3(double width3) {
		this.width3 = width3;
	}

	private double getHalfPerimeter()
	{
		return (getWidth1()+getWidth2()+getWidth3())/2;
	}
	
	@Override
	public double getSquare() 
	{
		return Math.sqrt(getHalfPerimeter()*(getHalfPerimeter()-getWidth1())*(getHalfPerimeter()-getWidth2())*(getHalfPerimeter()-getWidth3()));
	}

	@Override
	public double getPerimeter() 
	{
		return getWidth1()+getWidth2()+getWidth3();
	}

	public Triangle(double width1, double width2, double width3) {
		super();
		this.width1 = width1;
		this.width2 = width2;
		this.width3 = width3;
	}

	@Override
	public String toString() 
	{
		return "ТРЕУГОЛЬНИК\nДлина стороны 1: "+ getWidth1() +"\nДлина стороны 2: "+ getWidth2() + "\nДлина стороны 3: "+ getWidth3() + "\nПлощадь: "+ getSquare() +"\nПериметр: "+ getPerimeter()+"\n";
	}

}
