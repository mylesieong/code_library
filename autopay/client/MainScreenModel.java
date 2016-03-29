package autopay.client;

import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.Vector;

import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableModel;
import autopay.Employee;
import autopay.Party;
import autopay.util.DBConnector;

public class MainScreenModel {

	public static final int NAME_INDEX = 0;
	public static final int ACCOUNT_INDEX = 1;
	public static final int AMOUNT_INDEX = 2;
	public static final int REF_INDEX = 3;

	public static final int LOGOUT = 0;
	public static final int SUPERVISOR = 1;
	public static final int OPERATOR = 2;

	private MainScreen view;
	private AutoPayTableModel tm;
	private int loginStatus;
	
	private String[] partyCodeList;
	private Party party;
	private boolean modified = false;

	private static final Class<?>[] className = 
		/*Myles
		{String.class, Long.class, Double.class, String.class};
		 */
		{String.class, String.class, Double.class, String.class};
		 
	
	public MainScreenModel(String[] columnName, MainScreen view) throws SQLException, ClassNotFoundException {
		tm = new AutoPayTableModel(columnName, className);
		party = new Party();
		loginStatus = LOGOUT;
		this.view = view;
		
		DBConnector db = new DBConnector();
		partyCodeList = db.readPartyList();
		db.close();
	}
	
	public TableModel getTableModel() {
		return tm;
	}

	public String[] getPartyList()  {
		return partyCodeList;
	}
	
	public Party getParty() {
		return party;
	}
	
	/**
	 * Set party information
	 * @param party the party object
	 * @param initialise true if first time set up, false otherwise
	 */
	public void setParty(Party party, boolean initialise) {
		this.party = party;
		if(initialise) {
			dataSaved();
		} else {
			dataModified();
		}
	}
	
	public String getPartyCode() {
		return party.getCode();
	}
	
	public void setPartyCode(String partyCode) {
		party.setCode(partyCode);
	}
	
	public String getPartyName() {
		return party.getName();
	}
	
	public void setPartyName(String partyName) {
		party.setName(partyName);
	}
	
	public String getPaymentID() {
		return party.getPaymentID();
	}
	
	public void setPaymentID(String paymentId) {
		party.setPaymentID(paymentId);
	}
	
	public int getPaymentDate() {
		return party.getPaymentDate();
	}
	
	public void setPaymentDate(int paymentDate) {
		party.setPaymentDate(paymentDate);
	}
	
	public long getModifySeq() {
		return party.getWholeModifySeq();
	}
	
	public boolean isModified() {
		return modified;
	}

	/**
	 * Inform the model data had been saved. (Modify Seq saved)
	 */
	public void dataSaved() {
		modified = false;
	}
	
	/**
	 * Inform the model data had been changed
	 */
	public void dataModified() {
		if(!modified) {
			modified = true;
			party.incrementWholeModifySeq();
			view.setModifiedSeq(party.getWholeModifySeq());
		}
	}
	
	public int getLoginStatus() {
		return loginStatus;
	}
	
	public void setLoginStatus(int loginStatus) {
		this.loginStatus = loginStatus;
	}
	
	public int getTotalInputtedRecord() {
		return party.getTotalEmployees();
	}
	
	public double getTotalInputtedAmount() {
		return party.getTotalAmount();
	}
	
	public void addNewEmptyRow() {
		tm.addRow();
		party.addTotal(0);
		view.setInputtedRecord(party.getTotalEmployees());
	}
	
	public void addNewRow(Employee emp) {
		party.addTotal(emp.getAmount());
		tm.addData(emp);
	}
	
	public void addNewRows(Vector<Employee> emps) {
		for(Employee e: emps) {
			party.addTotal(e.getAmount());
		}
		tm.addData(emps);
	}
	
	public void insertNewEmptyRow(int row) {
		tm.insertRow(row);
		party.addTotal(0);
		view.setInputtedRecord(party.getTotalEmployees());
	}
	
	public void deleteRow(int rowsModelIndex[]) {
		Employee[] deletedEmps = tm.deleteRow(rowsModelIndex);
		for(Employee emp : deletedEmps) {
			party.minusTotal(emp.getAmount());
		}
		view.setInputtedRecord(party.getTotalEmployees());
		view.setInputtedAmount(party.getTotalAmount());
	}
	
	public void deleteAllRows() {
		party.setTotalEmployees(0);
		party.setTotalAmount(0);
		tm.deleteData();
	}
	
	public Vector<Employee> getAllRowsFromTable() {
		return tm.getAllRows();
	}
	
	

	@SuppressWarnings("serial")
	private class AutoPayTableModel extends AbstractTableModel {
		
		private Vector<Employee> data = new Vector<Employee>();
		private String[] columnName;
		private Class<?>[] className;
		private DecimalFormat twoDForm;
		
		public AutoPayTableModel(String[] title, Class<?>[] className) {
			columnName = title;
			this.className = className;
			twoDForm = new DecimalFormat("#.##"); 
		}
		
		public int getRowCount() {
			return data.size();
		}

		public int getColumnCount() {
			return columnName.length;
		}

		public String getColumnName(int columnIndex) {
			return columnName[columnIndex];
		}

		public Class<?> getColumnClass(int columnIndex) {
			return className[columnIndex];
		}

		public boolean isCellEditable(int rowIndex, int columnIndex) {
			return true;
		}

		public Object getValueAt(int rowIndex, int columnIndex) {
			switch(columnIndex) {
				case NAME_INDEX: return data.get(rowIndex).getName(); 
				/*Myles
				case ACCOUNT_INDEX: return Long.parseLong(data.get(rowIndex).getACNumber()); 
				*/
				/*Myles*/
				case ACCOUNT_INDEX: return data.get(rowIndex).getACNumber(); 
				/*/Myles*/
				case AMOUNT_INDEX: return data.get(rowIndex).getAmount(); 
				case REF_INDEX: return data.get(rowIndex).getReference(); 
				default: return new Object();
			}
		}

		public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
			switch(columnIndex) {
				case NAME_INDEX:
					data.get(rowIndex).setName(aValue.toString().trim());
					break;
				case ACCOUNT_INDEX:
					data.get(rowIndex).setACNumber(aValue.toString().trim());
					break;
				case AMOUNT_INDEX:
					if(aValue == null)
						aValue = 0;
					party.minusTotal((Double)getValueAt(rowIndex, columnIndex));       
					double value = Double.valueOf(twoDForm.format(Double.parseDouble(aValue.toString())));
					data.get(rowIndex).setAmount(value); 
					party.addTotal(value);
					break;
				case REF_INDEX: 
					data.get(rowIndex).setReference(aValue.toString().trim());
			}
			dataModified();
			fireTableCellUpdated(rowIndex, columnIndex);
		}
		
		//Add data to the table
		public void addData(Employee emp) {
			data.add(emp);
			int row = data.size()-1;
			fireTableRowsInserted(row, row);
		}
		
		//Add multiple data to the table
		public void addData(Vector<Employee> emps) {
			if(emps.size() > 0) {
				int beginRow = data.size()-1;
				for(Employee e : emps) {
					data.add(e);
				}
				fireTableRowsInserted(beginRow, data.size()-1);
			}
		}
		
		//remove all data from the table
		public void deleteData() {
			if(data.size() > 0) {
				int size = data.size();
				data.removeAllElements();
				fireTableRowsDeleted(0, size-1);
			}
		}
		
		//add a new row with no data
		public void addRow() {
			data.add(new Employee());
			fireTableRowsInserted(data.size()-1, data.size()-1);
		}
		
		//insert a new row to a specify index with no data
		public void insertRow(int row) {
			data.add(row, new Employee());
			fireTableRowsInserted(row, row);
		}
		
		//remove row(s) regardless does it have data or not
		public Employee[] deleteRow(int[] rows) {
			Employee[] removedEmployee = new Employee[rows.length];
			Arrays.sort(rows);
			for(int i=rows.length-1; i>=0; i--) 
				removedEmployee[i] = data.remove(rows[i]);
			if(rows.length == 1) 
				fireTableRowsDeleted(rows[0], rows[0]);
			else 
				fireTableRowsDeleted(0, data.size() + rows.length - 1);
			return removedEmployee;
		}
		
		@SuppressWarnings("unchecked")
		public Vector<Employee> getAllRows() {
			return (Vector<Employee>)data.clone();
		}
	}


	
}	
