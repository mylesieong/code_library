package autopay.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.Vector;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.xmlbeans.XmlException;
import autopay.Employee;
import autopay.Party;

public class CollectionFileConnector extends FileConnector {

	private static DecimalFormat df = new DecimalFormat("0");

	// File format for the DAT file
	public enum FileFormat {
		// Import file, Header record
		IM_HD_PART1(4, 0, 3), // Credit party
		IM_HD_PART2(4, 4, 7), // Total New & eff record
		IM_HD_PART3(4, 8, 11), // Total Old & eff record
		IM_HD_PART4(4, 12, 15), // Total Cancel record
		IM_HD_PART5(4, 16, 19), // Total suspended record
		IM_HD_PART6(68, 20, 87), // filler

		// Import file, Detail record
		IM_DT_PART1(3, 0, 2), // Filler
		IM_DT_PART2(10, 3, 12), // Debit Party Account number
		IM_DT_PART3(16, 13, 28), // Reference 1
		IM_DT_PART4(16, 29, 44), // Reference 2
		IM_DT_PART5(1, 45, 45), // Authorization status
		IM_DT_PART6(30, 46, 75), // Customer Name
		IM_DT_PART7(11, 76, 86), // Filler
		IM_DT_PART8(1, 87, 87), // star

		// Export file, Header record
		EX_HD_PART1(1, 0, 0), // "C"
		EX_HD_PART2(4, 1, 4), // Credit party
		EX_HD_PART3(8, 5, 12), // Collect Payment date
		EX_HD_PART4(11, 13, 23), // Accepted payment amount
		EX_HD_PART5(4, 24, 27), // total accepted record
		EX_HD_PART6(9, 28, 36), // Rejected payment amount
		EX_HD_PART7(25, 37, 61), // total rejected record
		EX_HD_PART8(26, 62, 87), // filler

		// Export file, Detail record
		EX_DT_PART1(3, 0, 2), // Filler
		EX_DT_PART2(10, 3, 12), // Debit Party Account number
		EX_DT_PART3(8, 13, 20), // Payment amount
		EX_DT_PART4(16, 21, 36), // Reference 1
		EX_DT_PART5(16, 37, 52), // Reference 2
		EX_DT_PART6(30, 53, 82), // Name
		EX_DT_PART7(5, 83, 87); // filler

		private final int length, startPos, endPos;
		private String value;

		FileFormat(int length, int startPos, int endPos) {
			this.length = length;
			this.startPos = startPos;
			this.endPos = endPos;
			value = null;
		}

		public int length() {
			return length;
		}

		public int startPos() {
			return startPos;
		}

		public int endPos() {
			return endPos;
		}

		public String value() {
			return value;
		}

		public String setValue(String value) {
			return (setValue(value, false, " "));
		}

		public String setValue(int value) {
			return (setValue(String.valueOf(value), true, "0"));
		}

		public String setValue(double value) {
			return (setValue(df.format(value), true, "0"));
		}

		public String setValue(String value, boolean fillLeft, String leading) {
			if (value.length() < length) {
				StringBuilder temp = new StringBuilder(value);
				while (length - temp.length() > 0) {
					if (fillLeft)
						temp.insert(0, leading);
					else
						temp.append(leading);
				}
				return temp.toString();
			} else {
				return value;
			}
		}
	}

	// write BCM format DAT file
	public static void writeBCMDAT(String key, String filePath, Party party,
			Vector<Employee> vecEmp) throws InvalidKeyException,
			NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidAlgorithmParameterException, IOException,
			IllegalBlockSizeException, BadPaddingException {

		initialize(filePath);
		Cryptography cryp = new Cryptography();
		String enKey = cryp.encrypt(key);
		BufferedWriter writer = new BufferedWriter(new FileWriter(file));
		writer.write(enKey);

		cryp = new Cryptography(key);

		phrase.delete(0, phrase.length());
		phrase.append(FileFormat.EX_HD_PART1.setValue("C"));
		phrase.append(FileFormat.EX_HD_PART2.setValue(party.getCode()));
		phrase.append(FileFormat.EX_HD_PART3.setValue(party.getPaymentDate()));
		phrase.append(FileFormat.EX_HD_PART4.setValue(party.getTotalAmount() * 100));
		phrase.append(FileFormat.EX_HD_PART5.setValue(party.getTotalEmployees()));
		phrase.append(FileFormat.EX_HD_PART6.setValue("000000000"));
		phrase.append(FileFormat.EX_HD_PART7.setValue("0000000000000000000000000"));
		writer.append(cryp.encrypt(phrase.toString())); // encrypt the party info and write it to DAT file

		for (Employee emp : vecEmp) {
			phrase.delete(0, phrase.length());
			phrase.append(FileFormat.EX_DT_PART1.setValue("000"));
			/*Myles
			phrase.append(FileFormat.EX_DT_PART2.setValue(emp.getACNumber(),true, "0"));
			*/
			/*Myles*/
			phrase.append(FileFormat.EX_DT_PART2.setValue(0));
			/*/Myles*/
			phrase.append(FileFormat.EX_DT_PART3.setValue(emp.getAmount() * 100));
			phrase.append(FileFormat.EX_DT_PART4.setValue(emp.getReference()));
			phrase.append(FileFormat.EX_DT_PART5.setValue("                "));
			phrase.append(FileFormat.EX_DT_PART6.setValue("                              "));
			writer.append(cryp.encrypt(phrase.toString())); // encrypt the customer info and write it to DAT file
		}

		writer.close();
	}

	public static Object[] readFirstDownload(String filePath, boolean encrypted)
			throws IOException, InvalidKeyException, NoSuchAlgorithmException,
			NoSuchPaddingException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException {
		Party party = null;
		String key = null;
		Employee emp;
		Vector<Employee> emps = new Vector<Employee>();

		initialize(filePath);

		// read BCM format DAT file

		String lineRead;
		int totalRec = 0;
		BufferedReader reader = new BufferedReader(new FileReader(file));

		// use first line of text as a key to decrypt the rest of file
		Cryptography cryp = null;
		if (encrypted) {
			if ((lineRead = reader.readLine()) == null)
				return null;
			cryp = new Cryptography();
			key = cryp.decrypt(lineRead);
			cryp = new Cryptography(key);
		}

		// header record
		if ((lineRead = reader.readLine()) == null)
			return null;
		if (encrypted)
			lineRead = cryp.decrypt(lineRead);
		party = new Party();
		party.setCode(lineRead.substring(FileFormat.IM_HD_PART1.startPos(),
				FileFormat.IM_HD_PART1.endPos() + 1));
		try {
			totalRec += Integer.parseInt(lineRead.substring(
					FileFormat.IM_HD_PART2.startPos(),
					FileFormat.IM_HD_PART2.endPos() + 1));
			totalRec += Integer.parseInt(lineRead.substring(
					FileFormat.IM_HD_PART3.startPos(),
					FileFormat.IM_HD_PART3.endPos() + 1));
			totalRec += Integer.parseInt(lineRead.substring(
					FileFormat.IM_HD_PART4.startPos(),
					FileFormat.IM_HD_PART4.endPos() + 1));
			totalRec += Integer.parseInt(lineRead.substring(
					FileFormat.IM_HD_PART5.startPos(),
					FileFormat.IM_HD_PART5.endPos() + 1));
		} catch (NumberFormatException e) {
			return null;
		}

		// detail records
		char authSts;
		int cancelCount = 0;
		while ((lineRead = reader.readLine()) != null) {
			if (encrypted)
				lineRead = cryp.decrypt(lineRead);
			if (lineRead.length() - 1 == FileFormat.IM_DT_PART8.endPos) {
				authSts = lineRead.charAt(FileFormat.IM_DT_PART5.startPos());
				if (authSts == 'N' || authSts == 'E') {
					emp = new Employee();
					emp.setACNumber(lineRead.substring(
							FileFormat.IM_DT_PART2.startPos(),
							FileFormat.IM_DT_PART2.endPos() + 1));
					emp.setName(lineRead.substring(
							FileFormat.IM_DT_PART6.startPos(),
							FileFormat.IM_DT_PART6.endPos() + 1));
					emp.setReference(lineRead.substring(
							FileFormat.IM_DT_PART3.startPos(),
							FileFormat.IM_DT_PART3.endPos() + 1));
					emps.add(emp);
				} else {
					cancelCount++;
				}
			}
		};

		if (cancelCount + emps.size() != totalRec)
			return null;

		Object[] objArray = { party, emps, key }; // add Party object,
													// Vector<Employee> object
													// and key to Object array
		return objArray;
	}

	public static Object[] read(String filePath) throws InvalidKeyException,
			NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidAlgorithmParameterException, IOException,
			IllegalBlockSizeException, BadPaddingException, IOException,
			NoSuchElementException, OpenXML4JException, XmlException {
		return read(filePath, true);
	}

	public static Object[] read(String filePath, boolean encrypted)
			throws InvalidKeyException, NoSuchAlgorithmException,
			NoSuchPaddingException, InvalidAlgorithmParameterException,
			IOException, IllegalBlockSizeException, BadPaddingException,
			IOException, NoSuchElementException, OpenXML4JException,
			XmlException {

		Party party = null;
		String key = null;
		Employee emp;
		Vector<Employee> emps = new Vector<Employee>();
		DecimalFormat df = new DecimalFormat("#");

		initialize(filePath);

		// read BCM format DAT file
		if (extension.equals(NOTEPAD)) {
			String lineRead;
			int totalRec = 0;
			double totalAmount = 0;
			BufferedReader reader = new BufferedReader(new FileReader(file));

			// use first line of text as a key to decrypt the rest of file
			Cryptography cryp = null;
			if (encrypted) {
				if ((lineRead = reader.readLine()) == null)
					return null;
				cryp = new Cryptography();
				key = cryp.decrypt(lineRead);
				cryp = new Cryptography(key);
			}

			// header record
			if ((lineRead = reader.readLine()) == null)
				return null;
			if (encrypted)
				lineRead = cryp.decrypt(lineRead);
			
			if(!lineRead.substring(FileFormat.EX_HD_PART1.startPos(), 
					FileFormat.EX_HD_PART1.endPos() + 1).equals("C")) 
				return null;
			
			party = new Party();
			party.setCode(lineRead.substring(FileFormat.EX_HD_PART2.startPos(),
					FileFormat.EX_HD_PART2.endPos() + 1));
			try {
				totalAmount += Double.parseDouble(lineRead.substring(
						FileFormat.EX_HD_PART4.startPos(),
						FileFormat.EX_HD_PART4.endPos() + 1));
				
				totalRec += Integer.parseInt(lineRead.substring(
						FileFormat.EX_HD_PART5.startPos(),
						FileFormat.EX_HD_PART5.endPos() + 1));

				// detail records
				while ((lineRead = reader.readLine()) != null) {
					if (encrypted) 
						lineRead = cryp.decrypt(lineRead);
//					if (lineRead.length() - 1 == FileFormat.EX_DT_PART7.endPos) {
						emp = new Employee();
						emp.setACNumber(lineRead.substring(
								FileFormat.EX_DT_PART2.startPos(),
								FileFormat.EX_DT_PART2.endPos() + 1));
						emp.setAmount(Double.parseDouble(lineRead.substring(
								FileFormat.EX_DT_PART3.startPos(),
								FileFormat.EX_DT_PART3.endPos() + 1))/100);
						emp.setName(lineRead.substring(
								FileFormat.EX_DT_PART6.startPos(),
								FileFormat.EX_DT_PART6.endPos() + 1));
						emp.setReference(lineRead.substring(
								FileFormat.EX_DT_PART4.startPos(),
								FileFormat.EX_DT_PART4.endPos() + 1));
						emps.add(emp);
//					}
				};
			} catch (NumberFormatException e) {
				return null;
			}

			if (emps.size() != totalRec)
				return null;
		}

		// read Excel 2003 or before file
		else if (extension.equals(EXCEL2003before)) {
			InputStream inStream = new FileInputStream(filePath);
			POIFSFileSystem fs = new POIFSFileSystem(inStream);
			HSSFWorkbook wb = new HSSFWorkbook(fs);
			HSSFSheet hsheet = wb.getSheetAt(0);
			Iterator<Row> rows = hsheet.rowIterator();
			HSSFRow row;
			HSSFCell cell;

			while (rows.hasNext()) {
				emp = new Employee();
				row = (HSSFRow) rows.next();

				// get first 4 column values and add them to Vector<Employee> object
				for (int i = 0; i < 4; i++) {
					cell = row.getCell(i);
					switch (i) {
					case 0:
						emp.setName(cell != null ? cell.toString() : "");
						break;
					case 1:
						emp.setACNumber(cell != null ? df.format(cell
								.getNumericCellValue()) : "0");
						break;
					case 2:
						emp.setAmount(cell != null ? cell.getNumericCellValue(): 0);
						break;
					case 3:
						emp.setReference(cell != null ? cell.toString() : "");
					}
				}
				emps.add(emp);
			}
			inStream.close();
		}

		// read Excel 2007 or after file
		else if (extension.equals(EXCEL2007after)) {
			XSSFWorkbook xwb = new XSSFWorkbook(filePath);
			XSSFSheet xsheet = xwb.getSheetAt(0);
			XSSFRow row;
			XSSFCell cell;

			for (int i = xsheet.getFirstRowNum(); i < xsheet
					.getPhysicalNumberOfRows(); i++) {
				emp = new Employee();
				row = xsheet.getRow(i);

				// get first 4 column values and add them to Vector<Employee> object
				for (int j = 0; j < 4; j++) {
					cell = row.getCell(j);
					switch (j) {
					case 0:
						emp.setName(cell != null ? cell.toString() : "");
						break;
					case 1:
						emp.setACNumber(cell != null ? 
								df.format(cell.getNumericCellValue()) : "0");
						break;
					case 2:
						emp.setAmount(cell != null ? cell.getNumericCellValue()
								: 0);
						break;
					case 3:
						emp.setReference(cell != null ? cell.toString() : "");
					}
				}
				emps.add(emp);
			}
		}

		Object[] objArray = { party, emps, key }; // add Party object,
													// Vector<Employee> object
													// and key to Object array
		return objArray;
	}
}
