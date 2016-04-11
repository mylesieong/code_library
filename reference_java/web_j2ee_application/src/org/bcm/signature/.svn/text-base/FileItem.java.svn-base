package org.bcm.signature;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

public class FileItem {
	
	private static String docAddress=null;

	public void init(ServletConfig con ) throws ServletException{
		docAddress = con.getInitParameter("DOCAddress");
		System.out.println(docAddress);
	}
	
	public static final int DISK = 0;
	public static final int OPTICAL = 1;
	
	//private static final String HOME_PATH = "\\\\svr-09-001\\"+"\\"+"BCMBackup\\";
	//private static final String HOME_PATH = "\\\\svr-03-014:8888\\"+"\\"+"image\\";
	private static final String OPTICAL_PATH = "DVDPDF\\";
	private static final String DISK_PATH = "DiskPDF\\";
	
	private StringBuilder document_id;
	private StringBuilder volumn_id;
	private StringBuilder folder;
	private StringBuilder directory;
	private StringBuilder key1, key2, key3, key4, key5;
	private StringBuilder path;
	private int diskOrOptical;
	
	public FileItem(String document_id, String d_folder, String d_directory,
			String o_volumn_id, String o_folder, String o_directory, 
			String key1, String key2, String key3, String key4, String key5) {
		this.document_id = new StringBuilder(document_id);
		this.key1 = new StringBuilder(key1);
		this.key2 = new StringBuilder(key2);
		this.key3 = new StringBuilder(key3);
		this.key4 = new StringBuilder(key4);
		this.key5 = new StringBuilder(key5);
		if(!o_volumn_id.substring(0,1).equals(" ")) {
			volumn_id = new StringBuilder(o_volumn_id.trim());
			folder = new StringBuilder(o_folder.trim());
			directory = new StringBuilder(o_directory.trim());
			diskOrOptical = OPTICAL;
			path = new StringBuilder(OPTICAL_PATH);
		} else {
			folder = new StringBuilder(d_folder.trim());
			directory = new StringBuilder(d_directory.trim());
			diskOrOptical = DISK;
			path = new StringBuilder(DISK_PATH);
		}
	}

	public String getDocument_id() {
		return document_id.toString();
	}

	public void setDocument_id(String document_id) {
		this.document_id.replace(0, this.document_id.length(), document_id);
	}

	public String getKey1() {
		return key1.toString();
	}

	public void setKey1(String key1) {
		this.key1.replace(0, this.key1.length(), key1);
	}

	public String getKey2() {
		return key2.toString();
	}

	public void setKey2(String key2) {
		this.key2.replace(0, this.key2.length(), key2);
	}

	public String getKey3() {
		return key3.toString();
	}

	public void setKey3(String key3) {
		this.key3.replace(0, this.key3.length(), key3);
	}
	
	public String getKey4() {
		return key4.toString();
	}

	public void setKey4(String key4) {
		this.key4.replace(0, this.key4.length(), key4);
	}
	
	public String getKey5() {
		return key5.toString();
	}

	public void setKey5(String key5) {
		this.key5.replace(0, this.key5.length(), key5);
	}

	public String getVolumn_id() {
		return volumn_id.toString();
	}

	public void setVolumn_id(String volumn_id) {
		this.volumn_id.replace(0, this.volumn_id.length(), volumn_id.trim());
		if(volumn_id.length() == 0) {
			diskOrOptical = DISK;
			path.replace(0, path.length(), DISK_PATH);
		}
		else {
			diskOrOptical = OPTICAL;
			path.replace(0, path.length(), OPTICAL_PATH);
		}
	}

	public String getFolder() {
		return folder.toString();
	}

	public void setFolder(String folder) {
		this.folder.replace(0, this.folder.length(), folder.trim());
	}

	public String getDirectory() {
		return directory.toString();
	}

	public void setDirectory(String directory) {
		this.directory.replace(0, this.directory.length(), directory.trim());
	}

	public int getDiskOrOptical() {
		return diskOrOptical;
	}

	public void setDiskOrOptical(int diskOrOptical) {
		this.diskOrOptical = diskOrOptical;
	}
	
	public boolean isDisk() {
		if(diskOrOptical == DISK) return true;
		else return false;
	}
	
	public boolean isOptical() {
		if(diskOrOptical == OPTICAL) return true;
		else return false;
	}
	
	public String getFullPath() {
		if(isOptical()) {
			//return "\\"+"\\"+HOME_PATH +"\\"+"\\"+ path.toString()+"\\"+"\\" + volumn_id.toString() + "\\" +"\\" + folder.toString() +"\\" + "\\" + directory.toString() + "\\"+ "\\";
			//return "http:\\"+"\\"+HOME_PATH +"\\"+"\\"+ path.toString()+"\\"+"\\" + volumn_id.toString() + "\\" +"\\" + folder.toString() +"\\" + "\\" + directory.toString() + "\\"+ "\\";
			return "\\"+ path.toString()+"\\"+"\\" + volumn_id.toString() + "\\" +"\\" + folder.toString() +"\\" + "\\" + directory.toString() + "\\"+ "\\";
		} else {
			//return "\\"+"\\"+HOME_PATH +"\\"+"\\"+ path.toString() +"\\"+"\\"+ folder.toString() + "\\" + "\\" +directory.toString() + "\\" +"\\";
			//return "http:\\"+"\\"+HOME_PATH +"\\"+"\\"+ path.toString() +"\\"+"\\"+ folder.toString() + "\\" + "\\" +directory.toString() + "\\" +"\\";
			return "\\"+ path.toString() +"\\"+"\\"+ folder.toString() + "\\" + "\\" +directory.toString() + "\\" +"\\";
		}
	}
	
	
}
