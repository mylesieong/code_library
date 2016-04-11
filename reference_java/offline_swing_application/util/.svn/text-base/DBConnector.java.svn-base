package autopay.util;

import java.sql.*;
import java.util.Properties;
import java.util.Vector;

import autopay.Employee;
import autopay.Party;
import autopay.client.Language;

/**
 * @author Alvin Lei  BB16PGM
 * 
 * Class to provide function for read and write database records
 */

public class DBConnector {
	
	public static final String DATABASE_NAME = "payroll.mdb";
	public static final int PARTY = 0;
	public static final int EMPLOYEE = 1;
	
	private static final String username = "root";
	private static final String password = "B8R98u23";
	
	private int pdate = 0;
	private double eamount = 0;
	private String pname = null;
	private String pid = null;
	private String pcode = null;
	private long pSeq = 0;
	private String ename = null;
	private String eAcctNo = null;
	private String reference = null;
	
	protected Connection dbcon;
	protected Statement statement;
	
	
	//Constructor without parameter to create connection to the database
	public DBConnector() throws ClassNotFoundException, SQLException{
		this("");
	}
	
	//Constructor with file directory parameter to create connection to the database
	public DBConnector(String directory) throws ClassNotFoundException, SQLException{
		if(directory == null)
			directory = "";
		String dbURL = "jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ=" + directory + DATABASE_NAME;

		Properties props = new Properties();
		props.put("user", username);
		props.put("password", password);
		
    	Properties config = FileConnector.loadConfig();
    	String charSet = config.getProperty("CharSet", "Big5");
    	if(!charSet.equals("")) {
    		props.put ("charSet", charSet);
    	}
    	
		dbcon = DriverManager.getConnection(dbURL, props);
		statement = dbcon.createStatement();
	}
	
	
	//return the party details and that party employee records
	public Object[] read(String strParty) throws SQLException{
		
		Party p = null;
		boolean blnParty = false;
		Vector<Employee> vecEmp = new Vector<Employee>();

		ResultSet rsParty = statement.executeQuery("SELECT * FROM party WHERE party_code = '" + strParty + "'");
		while(rsParty.next()){	
			pcode = rsParty.getString("party_code");
			pname = rsParty.getString("party_name");
			pid = rsParty.getString("payment_id");
			pdate = rsParty.getInt("payment_date");
			pSeq = rsParty.getLong("modify_seq");
			blnParty = true;
		}		

		if (blnParty){
			p = new Party(pcode,pname,pid,pdate,pSeq);
		
			ResultSet rsEmployee = statement.executeQuery("SELECT * FROM employee WHERE party_code = '" + strParty + "'");
			while(rsEmployee.next()){	
				ename = rsEmployee.getString("name");
				eAcctNo = rsEmployee.getString("account_no");
				eamount = rsEmployee.getDouble("salary");
				reference = rsEmployee.getString("reference");
				vecEmp.add(new Employee(ename,eAcctNo,eamount,reference));
//				p.addTotal(eamount);			
			}
			Object[] objArray = {p,vecEmp};
			return objArray;
		}else{
			return null;
		}	
	}
	
	//return the operator password according to party code
	public String readOperatorPassword(String strParty) throws SQLException{
		
		String oprPassword = null;
		
		ResultSet rsPassword = statement.executeQuery("SELECT operator_pwd FROM password WHERE party_code = '" + strParty + "'");
		while (rsPassword.next()){
			oprPassword = rsPassword.getString("operator_pwd");
		}
		return oprPassword;
	}
	
	//return the supervisor password according to party code
	public String readSupervisorPassword(String strParty) throws SQLException{
		
		String supPassword = null;
		
		ResultSet rsPassword = statement.executeQuery("SELECT supervisor_pwd FROM password WHERE party_code = '" + strParty + "'");
		while (rsPassword.next()){
			supPassword = rsPassword.getString("supervisor_pwd");
		}
		return supPassword;
	}
	
	//write operator password to database
	public boolean writeOperatorPassword(String strParty, String pwd) throws SQLException{
		
		return statement.executeUpdate("UPDATE password SET operator_pwd = '" + pwd
			    + "' WHERE party_code = '" + strParty + "'") > 0 ? true : false;		
	}
	
	//write supervisor password to database
	public boolean writeSupervisorPassword(String strParty, String pwd) throws SQLException{
		
		return statement.executeUpdate("UPDATE password SET supervisor_pwd = '" + pwd
				    + "' WHERE party_code = '" + strParty + "'") > 0 ? true : false;	
	}
	
	//write party details to database
	public void writeParty(Party par) throws SQLException{
		
		Statement stmt = dbcon.createStatement();
		pcode = par.getCode();
		pname = par.getName();
		pid = par.getPaymentID();
		pdate = par.getPaymentDate();
		pSeq = par.getWholeModifySeq();

		ResultSet rspcode = statement.executeQuery("SELECT party_code FROM party WHERE party_code = '" + pcode + "'");
		if (rspcode.next()){
			stmt.executeUpdate("UPDATE party SET party_name = '" + pname + "' WHERE party_code = '" + pcode + "'");
			stmt.executeUpdate("UPDATE party SET payment_id = '" + pid + "' WHERE party_code = '" + pcode + "'");
			stmt.executeUpdate("UPDATE party SET payment_date = " + pdate + " WHERE party_code = '" + pcode + "'");
			stmt.executeUpdate("UPDATE party SET modify_seq = " + pSeq + " WHERE party_code = '" + pcode + "'");
		}
		stmt.close();
	}
	
	//write the employee records to database
	public void writeEmployee(Vector<Employee> vecEmp) throws SQLException{
		
		Statement stmt = dbcon.createStatement();
		stmt.executeUpdate("UPDATE employee SET new_data = false");
		
		for(Employee emp : vecEmp){	
			ename = emp.getName();
			eAcctNo = emp.getACNumber();
			eamount = emp.getAmount();
			reference = emp.getReference();
			stmt.executeUpdate("INSERT INTO employee VALUES('" + pcode + "','" + ename + "','" + eAcctNo
																+ "'," + eamount + ",'" + reference + "', true)");		
		}
		stmt.executeUpdate("DELETE FROM employee WHERE party_code = '" + pcode + "' AND new_data = false");
		stmt.close();
	}
	
	//return all the party code in database
	public String[] readPartyList() throws SQLException{
		
		String[] partylist = null;
		int numOfLength = 0;
		
		ResultSet rsnum = statement.executeQuery("SELECT party_code FROM party");

		while (rsnum.next()){
			++numOfLength; 
		}
		
		partylist = new String[numOfLength];
		
		ResultSet rspl = statement.executeQuery("SELECT party_code FROM party ORDER BY party_code");
		rspl.next();
		for(int i = 0; i < numOfLength; i++){
			partylist[i] = rspl.getString("party_code");
			rspl.next();
		}
		return partylist;
	}
	
	/**
	 * Return the screen text. Array index always equals to the 'id' in the database.
	 */
	public String[][] readScreenText(String programName) throws SQLException{
		ResultSet rs = statement.executeQuery("SELECT MAX(id) AS arraySize FROM language");
		rs.next();
		int arraySize = rs.getInt("arraySize");
		rs.close();
		
		String screenType;
		if(programName.equalsIgnoreCase("autopay")) {
			screenType = "P";	//autopay
		} else {
			screenType = "C";	//auto collection
		}
		
		int id;
		String[][] lang = new String[arraySize+1][Language.AVAILABLE_LANGUAGE];
		rs = statement.executeQuery("SELECT * FROM language WHERE screen IN ('B','" + screenType + "')");
		while(rs.next()) {
			id = rs.getInt("id");
			lang[id][Language.EN] = rs.getString("english");
			lang[id][Language.CN] = rs.getString("chinese");
		}
		rs.close();
		return lang;
	}
	
	//close Connection and Statement object to release memory	
	public void close() throws SQLException{
		
		dbcon.close();
		statement.close();
	}
	
	
}	
