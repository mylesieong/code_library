package autopay.client;

import java.util.*;
import javax.print.PrintException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.apache.xmlbeans.XmlException;

import autopay.Employee;
import autopay.Party;
import autopay.util.Cryptography;
import autopay.util.DBConnector;
import autopay.util.FileConnector;
import autopay.util.Printer;
import autopay.utility.ResetPasswordDialog;

import com.itextpdf.text.DocumentException;

/**
 * The data model of main screen. It provides all necessary methods for the screen to 
 * retrieve and modify data. It consist of one instance of Party and one table model.
 * 
 * @author Francisco Lo BB14PGM
 * @since 28/10/2010
 */

@SuppressWarnings("unchecked")
public class MainScreenController {

	protected MainScreenModel model;
	
	private String lastSearch;
	private int lastSearchIndex;
	
	public MainScreenController(MainScreenModel model) throws SQLException, ClassNotFoundException {
		this.model = model;
		lastSearch = "";
	}
	
	public void addRow() {
		model.addNewEmptyRow();
		model.dataModified();
	}
	
	public void insertRow(int rowIndex) {
		if(rowIndex >= 0) {
			model.insertNewEmptyRow(rowIndex);
		} else if(model.getTotalInputtedRecord() == 0){
			model.addNewEmptyRow();
		}
		model.dataModified();
	}
	
	public void deleteRow(int[] rows, int[] rowsModelIndex) {
		if(rows.length > 0) {
			model.deleteRow(rowsModelIndex);
			model.dataModified();
		}
	}

	public void partyInfoUpdate(String partyCode, String partyName, String paymentID, 
			String paymentDate) {
		int date = 0;
		try {
			date = Integer.parseInt(paymentDate);
		} catch (NumberFormatException nfe) {}

		model.setPartyCode(partyCode);
		model.setPartyName(partyName);
		model.setPaymentID(paymentID);
		model.setPaymentDate(date);
		model.dataModified();		
	}
	
	/**
	* Search for the field Name and Account. If the pass in searchText is same as last time when this method was 
	* called, the search will continue from the index where the last successive search was.
	* @return The row index if the field Name or Account matched the searchText, otherwise return -1
	*/
	public int searchRow(String searchText) {
		if(!lastSearch.equals(searchText)) {
			lastSearchIndex = -1;
		}
		lastSearch = searchText;
		Employee e;
		Vector<Employee> emps = model.getAllRowsFromTable();
		int searchAccount = -1;
		try {
			searchAccount = Integer.parseInt(searchText);
		} catch (NumberFormatException nfe) {}//assume not search for account number 
		for(int i=lastSearchIndex+1; i<emps.size(); i++) {
			lastSearchIndex = i;
			e = emps.get(i);
			if(e.getName().equalsIgnoreCase(searchText)) {
				return i;
			} else if(Integer.parseInt(e.getACNumber()) == searchAccount) {
				return i;
			} 
		}
		return -1;
	}
	
	public void saveToDatabase(int[] order) throws ClassNotFoundException, SQLException {
		Vector<Employee> modelData = model.getAllRowsFromTable();
		Vector<Employee> orderedData = new Vector<Employee>(modelData.size());
		for(int i=0; i<order.length; i++) {
			orderedData.add(modelData.get(order[i]));
		}
		
		DBConnector db = new DBConnector();
		db.writeParty(model.getParty());
		db.writeEmployee(orderedData);
		db.close();
		
		model.dataSaved();
	}
	
	/**
	 * Compare password, return the login status, and depends on the login status to load data as well.
	 * @param partyCode
	 * @param password
	 * @param changeLoginStatus Change the "login status" as well if this == true
	 * @return Login status in int
	 */
	public int comparePassword(String partyCode, char[] password, 
			boolean changeLoginStatus) throws NoSuchAlgorithmException, 
				UnsupportedEncodingException, SQLException, ClassNotFoundException {
		
		String inputtedPW = Cryptography.hash(password);
		DBConnector db = new DBConnector();
		if(db.readSupervisorPassword(partyCode).equals(inputtedPW)) {
			if(changeLoginStatus) {
				if(model.getLoginStatus() == MainScreenModel.LOGOUT) {
					model.setLoginStatus(MainScreenModel.SUPERVISOR);
					loadData(partyCode);
				} else {
					model.setLoginStatus(MainScreenModel.SUPERVISOR);
					if(!partyCode.equals(model.getPartyCode()))
						loadData(partyCode);
				}
			}
			db.close();
			return MainScreenModel.SUPERVISOR;
			
		} else if(db.readOperatorPassword(partyCode).equals(inputtedPW)) {
			if(changeLoginStatus) {
				if(model.getLoginStatus() == MainScreenModel.LOGOUT) {
					model.setLoginStatus(MainScreenModel.OPERATOR);
					loadData(partyCode);
				} else {
					model.setLoginStatus(MainScreenModel.OPERATOR);
					if(!partyCode.equals(model.getPartyCode()))
						loadData(partyCode);
				}
			}
			db.close();
			return MainScreenModel.OPERATOR;
			
		} else {
			if(changeLoginStatus) {
				if(model.getLoginStatus() != MainScreenModel.LOGOUT) {
					logout();
				}
			}
			db.close();
			return MainScreenModel.LOGOUT;
		}
	}
	
	public void logout() throws SQLException, ClassNotFoundException {
		model.setLoginStatus(MainScreenModel.LOGOUT);
		loadData(null);
	}
	
	/**
	 * Export new file
	 * @param path Where the file will store
	 * @param extension The exported file type, either dat, xls or pdf
	 */
	public void exportFile(String path, String extension) throws InvalidKeyException, 
					NoSuchAlgorithmException, NoSuchPaddingException, 
					InvalidAlgorithmParameterException, IllegalBlockSizeException, 
					BadPaddingException, IOException, DocumentException, InvalidFormatException {
		if(extension.equalsIgnoreCase("dat"))
			FileConnector.writeBCMDAT(model.getPartyCode()+model.getPaymentDate(), path+"."+extension, model.getParty(), model.getAllRowsFromTable());
		else if(extension.equalsIgnoreCase("xls"))
			FileConnector.writeExcel(path+"."+extension, model.getParty(), model.getAllRowsFromTable());
		else if(extension.equalsIgnoreCase("pdf"))
			FileConnector.writePDF(path+"."+extension, model.getParty(), model.getAllRowsFromTable());
		else throw new IOException();
	}
	
	public boolean importFile(String path) throws InvalidKeyException, 
				NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, 
				IllegalBlockSizeException, BadPaddingException, InvalidFormatException, 
				NoSuchElementException, IllegalStateException, IOException, OpenXML4JException, XmlException {
		Object[] data = FileConnector.read(path);
		if(data != null) {
			Vector<Employee> vec = 
				(Vector<Employee>) data[FileConnector.EMPLOYEE];
			Party temp = (Party)data[FileConnector.PARTY];
			//When importing DAT file, party info will also imported
			if(temp != null) {
				//not allow one party read another party DAT file
				if(!model.getPartyCode().equals(temp.getCode())) {
					return false;
				}
				temp.setModifyCalendar(model.getParty().getModifyCalendar());
				temp.setModifySeq((model.getParty().getModifySeq()));
				model.setParty(temp, false);
			} 
			model.deleteAllRows();	//remove all data
			model.addNewRows(vec);	//add the new data
			model.dataModified();
			return true;
		}
		return false;
	}
	
	public void print() throws IllegalArgumentException, PrintException, 
				DocumentException, IOException, InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		new Printer(model.getParty(), model.getAllRowsFromTable());
	}
	
	public void resetPassword() throws ClassNotFoundException, SQLException {
		ResetPasswordDialog pwDialog = new ResetPasswordDialog(null, "Reset password(s).", 
				new String[] {model.getPartyCode()}, 
				ResetPasswordDialog.RESET_PASSWORD, 
				new DBConnector());
		pwDialog.setVisible(true);
	}
	
	
	/*
	 * Private method
	 */
	
	/**
	 * load data from the database depends on the loginStatus
	 */
	private void loadData(String partyCode) throws SQLException, ClassNotFoundException {
		switch(model.getLoginStatus()) {
		case MainScreenModel.LOGOUT:
			model.deleteAllRows();
			model.setParty(new Party(), true);
			break;
		case MainScreenModel.SUPERVISOR:
		case MainScreenModel.OPERATOR:
			DBConnector db = new DBConnector();
			Object[] data = db.read(partyCode);
			if(data != null) {
				Party party = (Party)data[DBConnector.PARTY];
				Vector<Employee> vec = (Vector<Employee>) data[DBConnector.EMPLOYEE];
				model.deleteAllRows();
				model.setParty(party, true);
				model.addNewRows(vec);
			}
			db.close();
		}
	}
}
