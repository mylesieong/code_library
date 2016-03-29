package autopay.utility;

import autopay.util.Cryptography;

import java.io.*;
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
 * @since 20/04/2012
 * 
 * Class to encrypt BCMCRP1.DAT file which generated from Host.
 */

public class EncryptExe {

	static final String FILENAME_INI = "encryptExe.ini";
	static String filePath;
	static String fileName;
	static String fileName_temp;
	
	static Properties pro;
	static FileReader reader;
	static BufferedReader in;
	
	public static void main(String[] args) {
		pro = new Properties();
		try {
			String path = EncryptExe.class.getProtectionDomain().getCodeSource().getLocation().getPath(); 
			path = URLDecoder.decode(path, "UTF-8"); 
			path = path.replaceAll("%20", " ").substring(0, path.lastIndexOf('/')+1);
//			String path = "C:\\ZAUTOPAY\\decrypt\\";				//for testing only
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
			filePath = pro.getProperty("FilePath", "");
			fileName = pro.getProperty("FileName", "BCMCRP1.DAT");
			fileName_temp = "temp_" + fileName;
			
			//rename from fileName to temp_fileName
			if(rename(true)) {
				File inFile = new File(filePath + fileName_temp);
				reader = new FileReader(inFile);
				in = new BufferedReader(reader);
				
				FileWriter writer = new FileWriter(new File(filePath + fileName));
        		BufferedWriter out = new BufferedWriter(writer);
		        
				String lineRead = in.readLine();
				String key = lineRead.substring(0, 4);
				
		        Cryptography encryptor = new Cryptography();
		        out.write(encryptor.encrypt(key));
		        
		        encryptor = new Cryptography(key);
		        out.write(encryptor.encrypt(lineRead));
        		
        		while((lineRead = in.readLine()) != null) {
        			out.write(encryptor.encrypt(lineRead));
        		}
        		
        		out.close();
        		writer.close();
        		in.close();
        		reader.close();
        		key = null;
        		encryptor = null;
        		inFile.delete();	//delete the temp file
        		
        		//Prompt user the process is finish
        		JOptionPane.showMessageDialog(null, 
    					"Encryption finish",
    					"", JOptionPane.INFORMATION_MESSAGE);
			}
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, 
					"Error occurs while trying to read and write the file - \"" + filePath+ fileName + "\" ",
					"", JOptionPane.ERROR_MESSAGE);
			e.printStackTrace();
	        rename(false);
		} catch (InvalidKeyException e) {
			closeInput();
		} catch (NoSuchAlgorithmException e) {
			closeInput();
		} catch (NoSuchPaddingException e) {
			closeInput();
		} catch (InvalidAlgorithmParameterException e) {
			closeInput();
		} catch (IllegalBlockSizeException e) {
			closeInput();
		} catch (BadPaddingException e) {
			closeInput();
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
}
