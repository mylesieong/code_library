package autopay.utility;

import autopay.util.Cryptography;

import java.io.*;
import java.net.URL;
import java.net.URLDecoder;

import javax.swing.JOptionPane;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Properties;

/**
 * 
 * @author Francisco Lo BB14PGM
 * @since 08/11/2010
 * 
 * Class to decrypt DBPBCM.DAT file which encrypted by Auto Payroll Application.
 */

public class DecryptcoExe {

	static final String FILENAME_INI = "decryptcoExe.ini";
	static String filePath;
	static String fileName;
	static String fileName_temp;
	
	static Properties pro;
	static FileReader reader;
	static BufferedReader in;
	
	public static void main(String[] args) {
		pro = new Properties();
		try {
			String path = DecryptcoExe.class.getProtectionDomain().getCodeSource().getLocation().getPath(); 
			path = URLDecoder.decode(path, "UTF-8"); 
			path = path.replaceAll("%20", " ").substring(0, path.lastIndexOf('/')+1);	
//			String path = "C:\\ZAUTOPAY\\decrypt\\";		//for testing only
    		System.out.println(path+FILENAME_INI);
			FileReader fr = new FileReader(path+FILENAME_INI);
    		pro.load(fr);
    		fr.close();
		}
		catch(Exception e) {
			JOptionPane.showMessageDialog(null, 
				"File " + FILENAME_INI + " not found. \n" +
						"Application is now using its default values to continue execution.",
				"", JOptionPane.WARNING_MESSAGE);
			e.printStackTrace();
		}
		
		try {
			filePath = pro.getProperty("FilePath", "C:\\ZAUTOPAY\\collect\\");
			fileName = pro.getProperty("FileName", "crpbcm.DAT");
			fileName_temp = "temp_" + fileName;
			
			//rename from fileName to temp_fileName
			if(rename(true)) {
				File inFile = new File(filePath + fileName_temp);
				reader = new FileReader(inFile);
				in = new BufferedReader(reader);
		        
		        Cryptography decryptor = new Cryptography();
		        String key = decryptor.decrypt(in.readLine());
		        if(key.length() == 12) {
//		        	int option = JOptionPane.showConfirmDialog(null, 
//		        			"Party Code: " + key.subSequence(0, 4) +
//		        			"\nPayment Date: " + key.substring(4), 
//		        			"", JOptionPane.YES_NO_OPTION);
		        	FileWriter writer = new FileWriter(
	        				new File(filePath + fileName));
	        		BufferedWriter out = new BufferedWriter(writer);
	        		String line;
	        		decryptor = new Cryptography(key);
	        		
	        		while((line = in.readLine()) != null) {
	        			out.write(decryptor.decrypt(line));
	        			out.newLine();
	        		}
	        		out.close();
	        		writer.close();
	        		in.close();
	        		reader.close();
	        		key = null;
	        		decryptor = null;
	        		inFile.delete();	//delete the temp file
	        		
	        		try {
	        			Runtime.getRuntime().exec("cmd /C start " + 
	        					pro.getProperty("DataTransfer", 
	        							"c:\\progra~1\\ibm\\client~1\\rfrompcb c:\\zautopay\\collect\\coul.tfr"));
	        		} catch(Exception e) {
	        			JOptionPane.showMessageDialog(null, 
	        					"File transfer may not correct.",
	        					"", JOptionPane.ERROR_MESSAGE);
	        			e.printStackTrace();
	        		}
//		        	if(option == JOptionPane.YES_OPTION) {
//		        		
//		        	} else {
//		    			closeInput();
//		        		key = null;
//		        		decryptor = null;
//		    			rename(false);
//		        	}
		        } else {
					closeInput();
		        	foxproDecryption();
		        }
			}
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, 
					"Error occurs while trying to read and write the file - \"" + filePath+ fileName + "\" ",
					"", JOptionPane.ERROR_MESSAGE);
			e.printStackTrace();
	        rename(false);
		} catch (InvalidKeyException e) {
			closeInput();
			foxproDecryption();
		} catch (NoSuchAlgorithmException e) {
			closeInput();
			foxproDecryption();
		} catch (NoSuchPaddingException e) {
			closeInput();
			foxproDecryption();
		} catch (InvalidAlgorithmParameterException e) {
			closeInput();
			foxproDecryption();
		} catch (IllegalBlockSizeException e) {
			closeInput();
			foxproDecryption();
		} catch (BadPaddingException e) {
			closeInput();
			foxproDecryption();
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, 
					"Unknown error.",
					"", JOptionPane.ERROR_MESSAGE);
			e.printStackTrace();
			closeInput();
	        rename(false);
		} finally {
			System.exit(0);
		}
	}
	
	private static boolean rename(boolean normalToTemp) {
		//rename from normal name to temp name
		if(normalToTemp) {
			try {
				File inFile = new File(filePath + fileName);
				if(!inFile.exists()) throw new FileNotFoundException();
				if(!inFile.renameTo(new File(filePath + fileName_temp))) throw new IOException();
				return true;
			} catch(FileNotFoundException e) {
				JOptionPane.showMessageDialog(null, 
						"File \"" + filePath + fileName + "\" not found.",
						"", JOptionPane.ERROR_MESSAGE);
				return false;
			} catch(IOException e) {
				JOptionPane.showMessageDialog(null, 
						"There is another \"" + filePath + fileName_temp + "\" file exists, please delete it if not in use.",
						"", JOptionPane.ERROR_MESSAGE);
				return false;
			}
		} 
		
		//rename back from temp name to normal name
		else {
			try {
				File inFileTemp = new File(filePath + fileName_temp);
				if(!inFileTemp.exists()) throw new FileNotFoundException();
				if(!inFileTemp.renameTo(new File(filePath + fileName))) throw new IOException();
				return true;
			} catch(FileNotFoundException e) {
				JOptionPane.showMessageDialog(null, 
						"File \"" + filePath + fileName_temp + "\" not found.",
						"", JOptionPane.ERROR_MESSAGE);
				return false;
			} catch(IOException e) {
				JOptionPane.showMessageDialog(null, 
						"There is another \"" + filePath + fileName + "\" file exists, please delete it if not in use.",
						"", JOptionPane.ERROR_MESSAGE);
				return false;
			}
		}
	}
	
	private static void closeInput() {
    	try {
			in.close();
	    	reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private static void foxproDecryption() {
		if(pro.getProperty("RetryFoxPro", "Y").equalsIgnoreCase("Y")) {
			try{
				File file = new File(fileName);
				if(file.exists()) file.delete();
				rename(false);
				
    			String foxProPath = pro.getProperty("FoxProDecryptPath", "C:\\ZAUTOPAY\\decrypt\\decryptco.exe");
    			Runtime.getRuntime().exec("cmd /C start " + foxProPath);
    		}catch (IOException e) {
    			e.printStackTrace();
    		}
		} else {
			JOptionPane.showMessageDialog(null, 
			"The file either is in a wrong format or it had already been decrypted.",
			"", JOptionPane.ERROR_MESSAGE);
			rename(false);
		}
	}
}
