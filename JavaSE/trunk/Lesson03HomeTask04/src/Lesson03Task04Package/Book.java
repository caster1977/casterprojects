/* 
������ � ������� 03
������� ������, ������������ ������� ��������� ����.
���������� ������������ � ������ set����(), get����, toString(). 
���������� ������������� ������ � ������, ��������� ������ ��������. 
������ �������� ������ ������ � ������� ��� ������ �� �������.

* 4. Book: id, ��������, �����(�), ������������, ��� �������, ���������� �������, ����, ��������.
* ������� ������ ��������. �������:
* a) ������ ���� ��������� ������;
* b) ������ ����, ���������� �������� �������������;
* c) ������ ����, ���������� ����� ��������� ����.
*/

package Lesson03Task04Package;

import java.util.Arrays;

enum TCover {������, ������};

public class Book {
	
	// ���������� ������ ������
	private String _name;
	private String[] _authors;
	private String _publishing_house;
	private int _year;
	private int _page_quantity;
	private double _price;
	private TCover _cover;

	// ������������
	public Book() 
	{
		super();
	}
	public Book(int id, String name, String[] authors, String publishing_house, int year, int page_quantity, double price, TCover cover) 
	{
		super();
		this._id = id;
		this._name = name;
		this._authors = authors;
		this._publishing_house = publishing_house;
		this._year = year;
		this._page_quantity = page_quantity;
		this._price = price;
		this._cover = cover;
	}
	
	// ������ ������
	public long get_id() {
		return _id;
	}
	public void set_id(long _id) {
		this._id = _id;
	}
	public String get_name() {
		return _name;
	}
	public void set_name(String _name) {
		this._name = _name;
	}
	public String[] get_authors() {
		return _authors;
	}
	public void set_authors(String[] _authors) {
		this._authors = _authors;
	}
	public String get_publishing_house() {
		return _publishing_house;
	}
	public void set_publishing_house(String _publishing_house) {
		this._publishing_house = _publishing_house;
	}
	public int get_year() {
		return _year;
	}
	public void set_year(int _year) {
		this._year = _year;
	}
	public int get_page_quantity() {
		return _page_quantity;
	}
	public void set_page_quantity(int _page_quantity) {
		this._page_quantity = _page_quantity;
	}
	public double get_price() {
		return _price;
	}
	public void set_price(double _price) {
		this._price = _price;
	}
	public TCover get_cover() {
		return _cover;
	}
	public void set_cover(TCover _cover) {
		this._cover = _cover;
	}
	private long _id;
	@Override
	public String toString() {
		return "����� #" + _id + "\n\n��������: " + _name + "\n������: "
				+ Arrays.toString(_authors) + "\n������������: "
				+ _publishing_house + "\n��� �������: " + _year + "\n���������� �������: "
				+ _page_quantity + "\n����: " + _price + "\n��� �������: " + _cover
				+ "\n\n";
	}
}
