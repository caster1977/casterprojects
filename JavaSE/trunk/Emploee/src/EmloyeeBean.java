import java.sql.Date;


public class EmloyeeBean {
private int empNo;
private String empName;
private Date birthDay;
public EmloyeeBean() {
	super();
	// TODO Auto-generated constructor stub
}
public EmloyeeBean(int empNo, String empName, Date birthDay) {
	super();
	this.empNo = empNo;
	this.empName = empName;
	this.birthDay = birthDay;
}
public int getEmpNo() {
	return empNo;
}
public void setEmpNo(int empNo) {
	this.empNo = empNo;
}
public String getEmpName() {
	return empName;
}
public void setEmpName(String empName) {
	this.empName = empName;
}
public Date getBirthDay() {
	return birthDay;
}
public void setBirthDay(Date birthDay) {
	this.birthDay = birthDay;
}
}
