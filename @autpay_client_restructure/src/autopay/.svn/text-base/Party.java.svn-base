package autopay;

import java.math.*;
import java.util.Calendar;

/**
 * This class simulate a party in the application. This class also keeps records of the 
 * total number of employees (number of records) and the total amount(salary) that should 
 * have.
 * @author Francisco Lo BB14PGM
 * @since 26/10/2010
 */

public class Party {
	
	private String code;
	private String name;
	private String paymentID;
	private int paymentDate;
	private int totalEmployees;
	private BigDecimal totalAmount;
	
	//Keep track of changes to the data made by user
	//Whole modify seq consist of calendar + seq (YYYYMMDDxx)
	private Calendar modifyCalendar;
	private long modifySeq;
	
	public Party() {
		this("", "", "0", 20120101, Calendar.getInstance(), 0L);
	}
	
	public Party(String code, String name, String paymentID, int paymentDate) {
		this(code, name, paymentID, paymentDate, Calendar.getInstance(), 0L);
	}
	
	public Party(String code, String name, String paymentID, int paymentDate, Calendar cSeq, long modifySeq) {
		this.code = code;
		this.name = name;
		this.paymentID = paymentID;
		this.paymentDate = paymentDate;
		totalEmployees = 0;
		totalAmount = new BigDecimal("0", MathContext.DECIMAL64);
		this.modifyCalendar = cSeq;
		this.modifySeq = modifySeq;
	}
	
	public Party(String code, String name, String paymentID, int paymentDate, long wholeModifySeq) {
		this.code = code;
		this.name = name;
		this.paymentID = paymentID;
		this.paymentDate = paymentDate;
		totalEmployees = 0;
		totalAmount = new BigDecimal("0", MathContext.DECIMAL64);
		modifySeq = wholeModifySeq % 100;
		modifyCalendar = Calendar.getInstance();
		long calSeq = wholeModifySeq / 100L;
		modifyCalendar.set((int)calSeq/10000, (int)((calSeq%10000)/100)-1, (int)calSeq%100);
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPaymentID() {
		return paymentID;
	}

	public void setPaymentID(String paymentID) {
		this.paymentID = paymentID;
	}

	public int getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(int paymentDate) {
		this.paymentDate = paymentDate;
	}

	public int getTotalEmployees() {
		return totalEmployees;
	}

	/**
	 * Should not use this method unless knowing the totalAmount is correct after using
	 * this method. Alternatively, use addTotal() or minusTotal() instead.
	 * @param totalEmployees total number of employees
	 */
	public void setTotalEmployees(int totalEmployees) {
		this.totalEmployees = totalEmployees;
	}

	public double getTotalAmount() {
		return totalAmount.doubleValue();
	}

	/**
	 * Should not use this method unless knowing the totalEmployees is correct after using
	 * this method. Alternatively, use addTotal() or minusTotal() instead.
	 * @param totalAmount amount in total
	 */
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = new BigDecimal(Double.toString(totalAmount), MathContext.DECIMAL64);
	}
	
	/**
	 * Add the total amount to totalAmount and plus one employee to totalEmployee
	 * @param amount the amount that need to add
	 */
	public void addTotal(double amount) {
		totalAmount = totalAmount.add(new BigDecimal(Double.toString(amount), MathContext.DECIMAL64));
		totalEmployees++;
//		System.out.println(amount + " + = " + totalAmount.doubleValue());
	}

	/**
	 * Minus the total amount from totalAmount and minus one employee from totalEmployee
	 * @param amount the amount that need to minus
	 */
	public void minusTotal(double amount) {
		totalAmount = totalAmount.subtract(new BigDecimal(Double.toString(amount), MathContext.DECIMAL64));
		if(totalAmount.doubleValue() < 0)
			totalAmount = new BigDecimal("0", MathContext.DECIMAL64);
		totalEmployees--;
		totalEmployees = (totalEmployees < 0 ? 0 : totalEmployees);
	}

	public final Calendar getModifyCalendar() {
		return modifyCalendar;
	}

	public final void setModifyCalendar(Calendar modifyCalendar) {
		this.modifyCalendar = modifyCalendar;
	}

	public final long getModifySeq() {
		return modifySeq;
	}

	public final void setModifySeq(long modifySeq) {
		this.modifySeq = modifySeq;
	}

	/**
	 * Return whole modify sequence (YYYYMMDDxx, modify Calendar + modify seq). 
	 * @return whole modify sequence
	 */
	public final long getWholeModifySeq() {
		return modifyCalendar.get(Calendar.YEAR)*1000000L + 
			(modifyCalendar.get(Calendar.MONTH)+1)*10000 + 
			modifyCalendar.get(Calendar.DAY_OF_MONTH)*100 +
			modifySeq;
	}
	
	/**
	 * Increase whole modify seq, if the calendar in the seq is not today, reset modify seq.
	 */
	public final void incrementWholeModifySeq() {
		Calendar c = Calendar.getInstance();
		if(modifyCalendar.get(Calendar.YEAR) == c.get(Calendar.YEAR) &&
			modifyCalendar.get(Calendar.MONTH) == c.get(Calendar.MONTH) &&
			modifyCalendar.get(Calendar.DAY_OF_MONTH) == c.get(Calendar.DAY_OF_MONTH)) {
			modifySeq++;
			if(modifySeq >= 100) 
				modifySeq = 0;
		} else {
			modifyCalendar = c;
			modifySeq = 0;
		}
	}
}
