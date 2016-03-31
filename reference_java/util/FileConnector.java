package autopay.util;

import java.io.File;
import java.io.FileReader;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.text.*;
import java.util.*;
import java.io.FileNotFoundException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.poifs.filesystem.POIFSFileSystem; 
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;   
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;   
import org.apache.poi.xssf.usermodel.XSSFSheet;   
import org.apache.poi.xssf.usermodel.XSSFWorkbook;   
import org.apache.xmlbeans.XmlException;

import autopay.Employee;
import autopay.Party;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPCell;


/**
 * Class to provide function for file import and export
 * File import type: BCM format DAT file(.DAT), Excel file(.xls, .xlsx)
 * File export type: BCM format DAT file(.DAT), Excel 2003 or below file(.xls), PDF file(.pdf)
 * 
 * @author Alvin Lei  BB16PGM
 * 
 */

public class FileConnector{

	public static final int PARTY = 0;
	public static final int EMPLOYEE = 1;
	
	protected static String extension = null;	
	protected static StringBuilder phrase = new StringBuilder();
	protected static File file;
	protected static final String NOTEPAD = "dat";
	protected static final String EXCEL2003before = "xls";
	protected static final String EXCEL2007after = "xlsx";
	
	//Header record format for the exported and imported DAT file
	public enum Header {
		PART1(1, 1, 1, "D"),				//Header Format ID
		PART2(4, 2, 5, "    "),				//Debit Party (Company) code
		PART3(8, 6, 13, "        "),		//Debit Payroll Date
		PART4(11, 14, 24, "00000000000"),		//Total Payroll Amount
		PART5(4, 25, 28, "0000"),				//Total employee record
		PART6(9, 29, 37, "         "),			//Payroll ID
		PART7(25, 38, 62, "                         "),	//Debit Party Name
		PART8(26, 63, 88, "                          ");		//Filler
		
		private final int length, startPos, endPos;
		private String value;
		Header(int length, int startPos, int endPos, String defaultValue) {
			this.length = length;
			this.startPos = startPos;
			this.endPos = endPos;
			value = defaultValue;
		}
		public int length(){return length;}
		public int startPos(){return startPos;}
		public int endPos(){return endPos;}
		public String value(){return value;}
		public String setValue(String value){return (this.value = value);}
	}
	
	//Detail record format for the exported and imported DAT file
	public enum Detail {
		PART1(3, 1, 3, "000"),					//Filler
		PART2(10, 4, 13, "0000000000"),			//Credit Party (employee) A/C Number
		PART3(8, 14, 21, "00000000"),			//Credit Amount (salary)
		PART4(16, 22, 37, "                "),		//Credit (employee) Party reference 1
		PART5(16, 38, 53, "                "),		//Credit (employee) Party reference 2 
		PART6(30, 54, 83, "                              "),	//Credit (employee) Party name
		PART7(5, 84, 88, "     ");				//Filler
		
		private final int length, startPos, endPos;
		private String value;
		Detail(int length, int startPos, int endPos, String defaultValue) {
			this.length = length;
			this.startPos = startPos;
			this.endPos = endPos;
			value = defaultValue;
		}
		public int length(){return length;}
		public int startPos(){return startPos;}
		public int endPos(){return endPos;}
		public String value(){return value;}
		public String setValue(String value){return (this.value = value);}
	}
	

	//write BCM format DAT file
	public static void writeBCMDAT(String key, String filePath, Party par, Vector<Employee> vecEmp) throws InvalidKeyException, 
				NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IOException, IllegalBlockSizeException, BadPaddingException{
		
		initialize(filePath);
		
		FileWriter fw = new FileWriter(file);
		fw.write("");		//clear the file while start writing
		fw.close();

		Cryptography c = new Cryptography();	
		writeDAT(c.encrypt(key));				//encrypt the key and write it to DAT file

		
		Cryptography cryp = new Cryptography(key);
		DecimalFormat df = new DecimalFormat("#");	
		
		phrase.append(Header.PART1.value());
		phrase.append(formatString(Header.PART2.value(), par.getCode(),true));
		phrase.append(formatString(Header.PART3.value(), df.format(par.getPaymentDate()),true));
		phrase.append(formatAmount(Header.PART4.value(), par.getTotalAmount(),true));
		phrase.append(formatString(Header.PART5.value(), Integer.toString(par.getTotalEmployees()),true));
		phrase.append(formatString(Header.PART6.value(), par.getPaymentID(),true));
		phrase.append(formatString(Header.PART7.value(), par.getName(),true));
		phrase.append(Header.PART8.value());

		writeDAT(cryp.encrypt(phrase.toString()));			//encrypt the party details and write it to DAT file
		phrase.delete(0, phrase.length());
	
		for(Employee emp : vecEmp){	
			phrase.append(Detail.PART1.value());
			phrase.append(formatString(Detail.PART2.value(), emp.getACNumber(),true)); 
			phrase.append(formatAmount(Detail.PART3.value(), emp.getAmount(),true));
			phrase.append(formatString(Detail.PART4.value(), emp.getReference(),true));
			phrase.append(Detail.PART5.value());
			phrase.append(formatString(Detail.PART6.value(), "",false));		//employee name not needed
			phrase.append(Detail.PART7.value());

			writeDAT(cryp.encrypt(phrase.toString()));		//encrypt the Employee details and write it to DAT file		//encrypt the party details and write it to DAT file
			phrase.delete(0, phrase.length());
		}
	}		
	
	
	//write PDF file
	public static void writePDF(String filePath, Party par, Vector<Employee> vecEmp) throws DocumentException, IOException{
		PdfPTable parTable = new PdfPTable(2);					//create table to hold party details
		PdfPTable empTable = new PdfPTable(4);					//create table to hold employee records
	    DecimalFormat dfAmount = new DecimalFormat("#,###.00");
	    DecimalFormat df = new DecimalFormat("#");
	    String strPDate = df.format(par.getPaymentDate());
		Document document = new Document();
		PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(filePath));       

		//setting of party details table
	    int parWidth[] = {5,3};    
	    parTable.setWidths(parWidth); 
		parTable.getDefaultCell().setBorder(Rectangle.NO_BORDER);
    	parTable.setWidthPercentage(95);	
		
	    document.open();  
	    
	    //add the report header picture
	    Image img = Image.getInstance("bcmNlogoC.JPG");
	    img.scalePercent(67);
	    document.add(img);

	    //add the report header
	    PdfContentByte cb = writer.getDirectContent();
	    BaseFont fontHeader = BaseFont.createFont("MHei-Medium", "UniCNS-UCS2-H", BaseFont.NOT_EMBEDDED);

	    cb.setFontAndSize(fontHeader, 18);
	    cb.beginText();
	    cb.showTextAligned(PdfContentByte.ALIGN_RIGHT, "Auto Payroll Input Report", 475, 770, 0);
	    cb.endText();

	    Font font = new Font(fontHeader,12); 
	    parTable.addCell(" ");
	    parTable.addCell(" ");
	    parTable.addCell(" ");
	    parTable.addCell(" ");
    	parTable.addCell(new Phrase("Party Code:                         " + par.getCode(), font));
    	parTable.addCell(new Phrase("    Payment ID:     " + par.getPaymentID(), font)); 
    	parTable.addCell(new Phrase("Party Name:                        " + par.getName(), font));
    	parTable.addCell(new Phrase("Payment Date:     " + strPDate.substring(0,4) + "-" + strPDate.substring(4,6) + "-" + strPDate.substring(6,8), font));
    	parTable.addCell(" ");
    	parTable.addCell(" ");
    	parTable.addCell(new Phrase("Total No. of Transaction:     " + par.getTotalEmployees(), font));
    	parTable.addCell("                 Seq:    " + par.getWholeModifySeq());
    	parTable.addCell(new Phrase("Total Amount:                      " + dfAmount.format(par.getTotalAmount()), font));
    	parTable.addCell(" ");
    	parTable.addCell(" ");
    	parTable.addCell(" ");
    	parTable.addCell(" ");
    	parTable.addCell(" ");
    	document.add(parTable);

    	//setting of employee records table
		int empWidth[] = {6,3,3,4};    
		empTable.setWidths(empWidth);
		empTable.getDefaultCell().setBorder(Rectangle.NO_BORDER);			
		empTable.setWidthPercentage(95);

    	empTable.addCell("Name");
    	empTable.addCell("Account No.");
    	empTable.addCell("Amount");
    	empTable.addCell("Reference");
    	
    	//create a dotted line for separate the column header and employee records 	
    	String dottedLine = ""; 	
    	for (int i = 0; i<123; i++){
    		dottedLine += "-";
    	}
    	PdfPCell cellSeparateLine = new PdfPCell(new Phrase(dottedLine));
    	cellSeparateLine.setColspan(4);
    	cellSeparateLine.setBorder(0); 
    	empTable.addCell(cellSeparateLine);

		int employeeCount = 0;			//set each page of employee records to zero
		int pages = 1;					//set there is the first page of the report
		
    	for(Employee emp : vecEmp){
    		if(employeeCount >= 32){							//set the maximum of first page can print 32 employee records
    			if (employeeCount >= 45 || pages == 1 ){		//set the maximum of following each page can print 45 employee records
    				empTable.addCell(" ");
    				empTable.addCell(" ");
    				empTable.addCell(" ");
    				empTable.addCell(" ");
    				empTable.addCell("Employee");
    				empTable.addCell("Account No.");
    				empTable.addCell("Payroll Amount");
    				empTable.addCell("Reference");
    				empTable.addCell(cellSeparateLine);
    				++pages;							//add a page
    				employeeCount = 0;					//set the next page employee records to zero
    			}
    		}    		
    		empTable.addCell(new Phrase(emp.getName(), font));
    		empTable.addCell(new Phrase(adjustAcctNoPosition(emp.getACNumber(),10), font)); 
    		empTable.addCell(new Phrase(adjustAmountPosition(dfAmount.format(emp.getAmount()),10), font));
    		empTable.addCell(new Phrase(emp.getReference(), font));
    		++employeeCount;							//add a employee record  		
    	}
    	
    	empTable.addCell(cellSeparateLine);    			//at last of the report add a separate line to indicate finish
    	document.add(empTable); 	    
	    document.close();    
	}    

	
	//write Excel 2003 or before file
	public static void writeExcel(String filePath, Party par, Vector<Employee> vecEmp) throws IOException, InvalidFormatException{
		
		Workbook wb = new HSSFWorkbook();     			//create a Excel 2003 or before format workbook object
        Sheet sheet1 = wb.createSheet("Sheet1");		//create a sheet for this workbook object
        CreationHelper helper = wb.getCreationHelper(); 
		Employee emp;
        Row row = null;   
        Cell cell = null;   
        
        for(int i=0; i<par.getTotalEmployees(); i++){
        	row = sheet1.createRow(i);
        	emp = vecEmp.get(i);
        	
        	for(int j=0 ; j<4; j++){  
        		sheet1.autoSizeColumn(j+1, true);     
                cell = row.createCell(j);
                
                switch(j){
                	case 0:
                		cell.setCellValue(helper.createRichTextString(emp.getName())); 
                		break;
                		
                	case 1:
                		cell.setCellValue(new Double(Double.parseDouble(emp.getACNumber())));               		
                		break;
                	
                	case 2:
                		cell.setCellValue(new Double(emp.getAmount()));              		
                		break;
                		
                	case 3:
                		cell.setCellValue(helper.createRichTextString(emp.getReference()));	
                		break;
                }               
        	}       	
        }
		
        FileOutputStream outStream = new FileOutputStream(new File(filePath));   
        wb.write(outStream);   
        outStream.close();                    
	}
	
	
	//read function
	public static Object[] read(String filePath) throws InvalidKeyException, NoSuchAlgorithmException, 
	                 NoSuchPaddingException, InvalidAlgorithmParameterException, IOException, IllegalBlockSizeException, 
	                    BadPaddingException, IOException, NoSuchElementException, OpenXML4JException, XmlException {
		
	  initialize(filePath);
	  
	  double eamount = 0;
	  String ename = null;
	  String eAcctNo = null;
	  String reference = null;
	  String strKey = null;
	  Party p = null;
	  Vector<Employee> vecEmp = new Vector<Employee>();
	  DecimalFormat df = new DecimalFormat("#");	
	  
	  //read BCM format DAT file
	  if (extension.equals(NOTEPAD)){	  
		String strAllData = readDAT();						//read all data from DAT file
		String[] strArray = strAllData.split("[\n]");		//add each line into array
		Cryptography c = new Cryptography();
		strKey = c.decrypt(strArray[0]);					//decrypt the first line for key
				
		Cryptography cryp = new Cryptography(strKey);		//use the key to decrypt the party details and employee records
		String strParty = cryp.decrypt(strArray[1]);

		//If the party not begin with D, then return null meaning that the file format is incorrect 
		if(!strParty.substring(Header.PART1.startPos()-1, Header.PART1.endPos()).equals("D")){
			return null;
		}
		
		String pcode = strParty.substring(Header.PART2.startPos()-1, Header.PART2.endPos()).trim();
		String pname = strParty.substring(Header.PART7.startPos()-1, Header.PART7.endPos()).trim();
		String pid = strParty.substring(Header.PART6.startPos()-1, Header.PART6.endPos()).trim();
		String pdate = strParty.substring(Header.PART3.startPos()-1, Header.PART3.endPos()).trim();
		p = new Party(pcode,pname,pid, Integer.parseInt(pdate));		//add the party details to the Party object
		
		
		//decrypt the employee records
		for (int i = 2; i< strArray.length; i++){			
			String strEmployee = cryp.decrypt(strArray[i]);	
			ename = strEmployee.substring(Detail.PART6.startPos()-1, Detail.PART6.endPos()).trim();
			eamount = Double.parseDouble(strEmployee.substring(Detail.PART3.startPos()-1, Detail.PART3.endPos()))/100;
			reference = strEmployee.substring(Detail.PART4.startPos()-1, Detail.PART4.endPos()).trim();
			eAcctNo = strEmployee.substring(Detail.PART2.startPos()-1, Detail.PART2.endPos()).trim();
			//remove prepositive "0" from the decrypted account no.
			if (eAcctNo.substring(0,1).equals("0")){
				int count = 1;
				for (int j = 1; j < Detail.PART2.length()-1; j++){
					if(eAcctNo.substring(j,j+1).equals("0")){
						++count;
					}else{
						break;
					}
				}
				eAcctNo = eAcctNo.substring(count,Detail.PART2.length());
			}
			
			p.addTotal(eamount);											//count the total employees and amount
			vecEmp.add(new Employee(ename,eAcctNo,eamount,reference));		//add the employee records to the Vector<Employee> object
		}			 	  
	  }
	  
	  //read Excel 2003 or before file
	  else if (extension.equals(EXCEL2003before)){
		InputStream inStream = new FileInputStream(filePath);   		
	    POIFSFileSystem fs = new POIFSFileSystem(inStream);   
	    HSSFWorkbook wb = new HSSFWorkbook(fs);   
	    HSSFSheet hsheet = wb.getSheetAt(0);   
	    Iterator<Row> rows = hsheet.rowIterator();   
	    
	    while (rows.hasNext()) {	    	
    		eamount = 0;
    		ename = null;
    		eAcctNo = null;
    		reference = null;
    		
	    	HSSFRow row = (HSSFRow) rows.next();    
	    	
	    	//get first 4 column values and add them to Vector<Employee> object   
	        HSSFCell cell; 		 
	    	for (int i = 0; i < 4; i++){
    			cell = row.getCell(i);
	 	   		switch (i) {
	    			case 0:	
	        			ename = (cell != null? cell.toString(): "");
	    				break;
	    			case 1:
	        			eAcctNo = (cell != null? df.format(cell.getNumericCellValue()): "0");   						    				
	    				break;
	    			case 2:
	        			eamount = (cell != null? cell.getNumericCellValue(): 0);
    					break;
	    			case 3:
	        			reference = (cell != null? cell.toString(): "");
	    				break;
	    		}
	    	}
	    	vecEmp.add(new Employee(ename,eAcctNo,eamount,reference));
	    }   	          	  	
	  }
	  
	  //read Excel 2007 or after file
	  else if (extension.equals(EXCEL2007after)){
	 	XSSFWorkbook xwb = new XSSFWorkbook(filePath);
	    XSSFSheet xsheet = xwb.getSheetAt(0); 
	   	XSSFRow row;      

	    for (int i = xsheet.getFirstRowNum(); i < xsheet.getPhysicalNumberOfRows(); i++) {
	    	eamount = 0;
	    	ename = null;
	    	eAcctNo = null;
	    	reference = null;
	    	
	        row = xsheet.getRow(i);      
	        
	        //get first 4 column values and add them to Vector<Employee> object
	        XSSFCell cell;
	        for (int j = 0; j < 4; j++) {   
    			cell = row.getCell(j);
	        	switch (j) {
		    		case 0:
		    			ename = (cell != null? cell.toString(): "");
		    			break;
		    		case 1:
		    			eAcctNo = (cell != null? df.format(cell.getNumericCellValue()): "0");
		    			break;
		    		case 2:
		    			eamount = (cell != null? cell.getNumericCellValue(): 0);
		    			break;
		    		case 3:
		    			reference = (cell != null? cell.toString(): "");	    					 		
		    			break;
	        	}			
	        }   
	        vecEmp.add(new Employee(ename,eAcctNo,eamount,reference));         
	    }   
	  }
	  Object[] objArray = {p,vecEmp,strKey};		//add Party object, Vector<Employee> object and key to Object array
	  return objArray;	
	}
	
	//Get a set of all config
	public static Properties loadConfig(){
		return loadConfig("Config//config.ini");
	}
	
	public static Properties loadConfig(String path){
		Properties pro = new Properties();
		try {
			FileReader fr = new FileReader(new File(path));
			pro.load(fr);
			fr.close();
		} 
		catch(IOException e) {
			//catch exception here as we want to keep the application running with defaults value if 
			//there are IO error were found for any reason.
		}
		return pro;
	}
	
	//Get a set of all AutoPay option
	public static Properties loadAutopaySetting(){
		Properties pro = new Properties();
		try {
			FileReader fr = new FileReader(new File("Config//autopay_option.ini"));
			pro.load(fr);
			fr.close();
		} 
		catch(IOException e) {
			//catch exception here as we want to keep the application running with defaults value if 
			//there are IO error were found for any reason.
		}
		return pro;
	}
	
	//Get a set of all AutoCollection option
	public static Properties loadAutoCollectionSetting(){
		Properties pro = new Properties();
		try {
			FileReader fr = new FileReader(new File("Config//autocollection_option.ini"));
			pro.load(fr);
			fr.close();
		} 
		catch(IOException e) {
			//catch exception here as we want to keep the application running with defaults value if 
			//there are IO error were found for any reason.
		}
		return pro;
	}

	//initialize the file and get file extension 
	protected static void initialize(String fp) throws FileNotFoundException{
		String[] tempArray = fp.split("[.]");
		extension = tempArray[tempArray.length - 1].toLowerCase();
		file = new File(fp);
		phrase.delete(0, phrase.length());
	}

	
	//write string to DAT file
	private static void writeDAT(String ph) throws IOException{	
		FileOutputStream outStream = new FileOutputStream(file,true);
		FileChannel channel = outStream.getChannel();
		ByteBuffer buf = ByteBuffer.allocate(ph.length());
		byte[] bytes = ph.getBytes(); 
		buf.put(bytes);
		buf.flip();
		channel.write(buf);
		channel.close();
		outStream.close();
	}
	

	//read string from DAT file
	private static String readDAT() throws IOException{
		FileInputStream inStream = new FileInputStream(file);
        byte b[] = new byte[(int)file.length()];
        String str = "";    
        inStream.read(b);
        inStream.close();
        str = new String(b);

		return str;
	}

	
	//convert string into BCM DAT file format
	private static String formatString(String en, String strc, boolean rightSide){
		String formattedString = "";
	
		if(strc.length() < en.length()){
			int numOfLength = en.length() - strc.length();
			for(int i = 0; i < numOfLength; i++){
				formattedString += en.substring(0,1);
			}
			formattedString += strc;
			if (rightSide == false){
				formattedString = "";
				formattedString += strc;
				for(int i = 0; i < numOfLength; i++){
					formattedString += en.substring(0,1);
				}
			}		
		}else if(strc.length() > en.length()) {
			if (rightSide == true){
				formattedString = strc.substring(strc.length() - en.length());
			}else{		
				formattedString = strc.substring(0, en.length());
			}		
		}else{
			return strc;
		}
		return formattedString;
	}


	//convert amount into BCM DAT file format
	private static String formatAmount(String en, Double cur, boolean rightSide){
		DecimalFormat df = new DecimalFormat("#.00");
		String formattedAmount = df.format(cur);
		String[] strArray = {"","00"};
		strArray = formattedAmount.split("[.]");
		formattedAmount = strArray[0] + strArray[1];

		return formatString(en,formattedAmount,rightSide);
	}

	//adjust account no. to be right alignment
	private static String adjustAcctNoPosition(String str, int totalStrLength){		
		int len = totalStrLength - str.length();	
		if (len > 0){
			for (int i = 0; i < len; i++){
					str = "  " + str;
			}
		}		
		return str;
	}
	
	//adjust amount to be right alignment
	private static String adjustAmountPosition(String str, int totalStrLength){
		int strOriginalLength = str.length();
		int len = totalStrLength - str.length();		
		if (len > 0){
			for (int i = 0; i < len; i++){
					str = "  " + str;
			}
		}		
		if (strOriginalLength < 7){
			str = str.substring(1);
		}		
		return str;
	}
	
	

}	

	
