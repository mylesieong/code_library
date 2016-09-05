package autopay.client.collection;

import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.NoSuchElementException;
import java.util.Properties;
import java.util.Vector;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.apache.xmlbeans.XmlException;

import com.itextpdf.text.DocumentException;

import autopay.Employee;
import autopay.Party;
import autopay.client.MainScreenController;
import autopay.client.MainScreenModel;
import autopay.util.CollectionFileConnector;
import autopay.util.FileConnector;

public class CollectionScreenController extends MainScreenController {
	
	private Properties autocollectionOption;
	
	public CollectionScreenController(MainScreenModel model) throws SQLException, ClassNotFoundException {
		super(model);
		autocollectionOption = FileConnector.loadAutoCollectionSetting();
	}
	
	public boolean importCollectionFile(String path) throws InvalidKeyException, 
				NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, 
				IllegalBlockSizeException, BadPaddingException, InvalidFormatException, 
				NoSuchElementException, IllegalStateException, IOException, OpenXML4JException, XmlException { 
		Object[] data = CollectionFileConnector.readFirstDownload(path, Boolean.valueOf(autocollectionOption.getProperty("DecryptFirstDownloadFile", "true")));
		if(data != null) {
			Vector<Employee> vec = (Vector<Employee>) data[CollectionFileConnector.EMPLOYEE];
			Party temp = (Party)data[CollectionFileConnector.PARTY];
			if(temp != null) {
				//not allow one party read another party DAT file
				if(!model.getPartyCode().equals(temp.getCode())) {
					return false;
				}
			} 
			model.deleteAllRows();	//remove all data
			model.addNewRows(vec);	//add the new data
			model.dataModified();
			return true;
		}

		//tell the screen the file is in incorrect format
		throw new IllegalBlockSizeException("");
	}
	
	@Override
	public void exportFile(String path, String extension) throws InvalidKeyException, 
				NoSuchAlgorithmException, NoSuchPaddingException, 
				InvalidAlgorithmParameterException, IllegalBlockSizeException, 
				BadPaddingException, IOException, DocumentException, InvalidFormatException {
		if(extension.equalsIgnoreCase("dat"))
			CollectionFileConnector.writeBCMDAT(model.getPartyCode()+model.getPaymentDate(), path+"."+extension, model.getParty(), model.getAllRowsFromTable());
		else if(extension.equalsIgnoreCase("xls"))
			CollectionFileConnector.writeExcel(path+"."+extension, model.getParty(), model.getAllRowsFromTable());
		else if(extension.equalsIgnoreCase("pdf"))
			CollectionFileConnector.writePDF(path+"."+extension, model.getParty(), model.getAllRowsFromTable());
		else throw new IOException();
	}
	
	@Override
	public boolean importFile(String path) throws InvalidKeyException, 
				NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, 
				IllegalBlockSizeException, BadPaddingException, InvalidFormatException, 
				NoSuchElementException, IllegalStateException, IOException, OpenXML4JException, XmlException {
		Object[] data = CollectionFileConnector.read(path);
		if(data != null) {
			Vector<Employee> vec = 
				(Vector<Employee>) data[CollectionFileConnector.EMPLOYEE];
			Party temp = (Party)data[CollectionFileConnector.PARTY];
			if(temp != null) {
				//not allow one party read another party DAT file
				if(!model.getPartyCode().equals(temp.getCode())) {
					return false;
				}
				temp.setModifyCalendar(model.getParty().getModifyCalendar());
				temp.setModifySeq((model.getParty().getModifySeq()));
				//no need to reset party in model because the file did not contain enough party info
			}
			
			model.deleteAllRows();	//remove all data
			model.addNewRows(vec);	//add the new data
			model.dataModified();
			return true;
		}
		
		//tell the screen the file is in incorrect format
		throw new IllegalBlockSizeException("");
	}
}
