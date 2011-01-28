package Lesson05;

public class Rectangle implements IShape 
{
	private double width, height;
	
	public Rectangle() {
		super();
	}

	public Rectangle(int width, int height) {
		super();
		this.width = width;
		this.height = height;
	}

	public double getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public double getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	@Override
	public double getSquare()
	{
		return this.width*this.height;
	}

	@Override
	public double getPerimeter() 
	{
		return this.width*2+this.height*2;
	}

	@Override
	public String toString() {
		return "ÏĞßÌÎÓÃÎËÜÍÈÊ\nÄëèíà: "+ getWidth() +"\nØèğèíà: "+ getHeight() + "\nÏëîùàäü: "+ getSquare() +"\nÏåğèìåòğ: "+ getPerimeter()+"\n";
	}
}
