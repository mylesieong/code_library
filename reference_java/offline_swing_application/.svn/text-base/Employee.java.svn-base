package autopay;

/**
 * @author Francisco Lo BB14PGM
 * @since 26/10/2010
 * 
 * This is to simulate a record in the table, each instance of this class represent 
 * one record.
 */

public class Employee {
	
	private String name;
	private String acNumber;
	private double amount;
	private String reference;
	
	public Employee () {
		this("", "0", 0, "");
	}
	
	public Employee(String name, String acNumber, double amount, String reference) {
		this.name = name;
		this.acNumber = acNumber;
		this.amount = amount;
		this.reference = reference;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getACNumber() {
		return acNumber;
	}

	public void setACNumber(String acNumber) {
		this.acNumber = acNumber;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}
	
	//return a copy of this instance
	public Employee clone() {
		return new Employee(name, acNumber, amount, reference);
	}
}
