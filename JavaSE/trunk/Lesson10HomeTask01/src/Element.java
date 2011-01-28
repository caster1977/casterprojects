public class Element 
{
	private long id;
	private long parent_id;
	private String name;
	private boolean is_catalog;
	
	public Element(long id, String name, boolean is_catalog, long parent_id) throws MyException {
		super();
		
		if (id<0)
			throw new WrongIdException();
		else this.id = id;
		
		if (parent_id<-1)
			throw new WrongParentIdException();
		else this.parent_id = parent_id;		

		if (name.trim()=="")
			throw new WrongNameException();
		else this.name = name;

		this.is_catalog = is_catalog;		
	}

	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public boolean isIs_catalog() {
		return is_catalog;
	}
	public void setIs_catalog(boolean is_catalog) {
		this.is_catalog = is_catalog;
	}
	public long getParent_id() {
		return parent_id;
	}
	public void setParent_id(long parent_id) {
		this.parent_id = parent_id;
	}
	
	@Override
	public String toString() {
		return "Element [id=" + id + ", name=" + name + ", is_catalog="
				+ is_catalog + ", parent_id=" + parent_id + "]";
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (id ^ (id >>> 32));
		result = prime * result + (is_catalog ? 1231 : 1237);
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + (int) (parent_id ^ (parent_id >>> 32));
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Element other = (Element) obj;
		if (id != other.id)
			return false;
		if (is_catalog != other.is_catalog)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (parent_id != other.parent_id)
			return false;
		return true;
	}
	
}
