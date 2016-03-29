package autopay.util;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Component;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.font.TextAttribute;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.text.DecimalFormat;
import java.util.Vector;
import java.lang.ArrayIndexOutOfBoundsException;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.ServiceUI;
import javax.print.SimpleDoc;
import javax.print.attribute.HashDocAttributeSet;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;

import autopay.Employee;
import autopay.Party;

/**
 * @author Alvin Lei  BB16PGM
 * 
 * Class to provide function to print Auto Payroll Report
 */

public class Printer implements Printable{
	
	private Party printParty;
	private Vector<Employee> printEmployee;
	private int PAGES;
	private DecimalFormat dfAmount = new DecimalFormat("#,###.00");
	private DecimalFormat dfTotalEmployee = new DecimalFormat("#,###");
	
	public Printer(Party par, Vector<Employee> vecEmp) throws PrintException{
	    
		printParty = par;
		printEmployee = vecEmp;
		
		//calculate how many pages of the report
		if((par.getTotalEmployees()-32)%45 > 0){
			PAGES = (int)((par.getTotalEmployees()-32)/45) + 2;
		}else{
			PAGES = (int)((par.getTotalEmployees()-32)/45) + 1;
		}		
	    
        DocFlavor flavor = DocFlavor.SERVICE_FORMATTED.PRINTABLE; 
        PrintService[] services = PrintServiceLookup.lookupPrintServices(flavor, null);
        PrintService defaultService = PrintServiceLookup.lookupDefaultPrintService(); 
        PrintRequestAttributeSet attr = new HashPrintRequestAttributeSet();
//        DocPrintJob job = ps.createPrintJob(); 
//        DocAttributeSet das = ; 

        PrintService service =  ServiceUI.printDialog(null, 50, 50, services, defaultService, flavor, attr);
        if (service != null) {
            Doc doc = new SimpleDoc(this, flavor, new HashDocAttributeSet()); 
            DocPrintJob job = service.createPrintJob();
            job.print(doc, attr);							//print the report
        }

	}
	
	
	public int print(Graphics gra, PageFormat pf, int pageIndex) throws PrinterException {		
	
	    Font fontHeader = new Font("Arial",Font.BOLD,18);
	   	Font fontColumnHeader = new Font ("Arial",Font.BOLD,10);
	    Font fontDetail = new Font("Courier New",0,10);
//	    Font fontDetail = new Font("Arial",0,10);
	    Employee emp;
	    Component c = null;
	    int line = 1;
	    int firstEmployeePerPage;
	    int lastEmployeePerPage;
	    double pageCorner_x = pf.getImageableX();			//get the page left-top corner x
	    double pageCorner_y = pf.getImageableY();			//get the page left-top corner y
	    float fontHeader_height = fontHeader.getSize2D();
	    float fontDetail_height = fontDetail.getSize2D() + 4;		//set each line height
	    float[] dash = {2.0f};
        String strPDate = Integer.toString(printParty.getPaymentDate());
   
	    Graphics2D g2 = (Graphics2D) gra;
	    g2.setColor(Color.black);
	    g2.setStroke(new BasicStroke(0.5f, BasicStroke.CAP_BUTT, BasicStroke.JOIN_MITER, 2.0f, dash, 0.0f)); 
	    
	    //stop printing if current page is the last page
	    if(pageIndex >= PAGES){
	    	return NO_SUCH_PAGE;		
	    }

	    //printing for first page
	    if(pageIndex == 0){	           
	        Image src = Toolkit.getDefaultToolkit().getImage("bcmNlogoC.JPG");
	        int img_width = (int)(src.getWidth(c)/1.5);
	        int img_height = (int)(src.getHeight(c)/1.5);
	        g2.drawImage(src,(int)pageCorner_x,(int)pageCorner_y,img_width,img_height,c);  
	        line += 1;
	        
	        //print the report header
	        g2.setFont(fontHeader);
	        g2.drawString("Auto Payroll Input Report",(float)pageCorner_x + 233, (float)pageCorner_y + line*fontHeader_height);
	        line += 4;
	        
	        //print the party details
	        g2.setFont(fontDetail);
//	        g2.drawString("Input Date:",(float)pageCorner_x + 300, (float)pageCorner_y + line*fontDetail_height);
//	        line += 1;
//	        g2.drawString("Reference:",(float)pageCorner_x + 300, (float)pageCorner_y + line*fontDetail_height);
	        line += 1;
	        g2.drawString("Party Code:",(float)pageCorner_x, (float)pageCorner_y + line*fontDetail_height);
	        g2.drawString(printParty.getCode(), (float)pageCorner_x + 95, (float)pageCorner_y + line*fontDetail_height);
	        g2.drawString("Payment ID:    ", (float)pageCorner_x + 295, (float)pageCorner_y + line*fontDetail_height);
	        g2.drawString(printParty.getPaymentID(), (float)pageCorner_x + 365, (float)pageCorner_y + line*fontDetail_height);
	        line += 1;
	        g2.drawString("Party Name:",(float)pageCorner_x, (float)pageCorner_y + line*fontDetail_height);
	        g2.drawString(printParty.getName(), (float)pageCorner_x + 95, (float)pageCorner_y + line*fontDetail_height);
	        g2.drawString("Payment Date:    ", (float)pageCorner_x + 284, (float)pageCorner_y + line*fontDetail_height);
	        strPDate = strPDate.substring(0,4) + "-" + strPDate.substring(4,6) + "-" + strPDate.substring(6,8);
	        g2.drawString(strPDate, (float)pageCorner_x + 365, (float)pageCorner_y + line*fontDetail_height);
	        line += 2;
	        g2.drawString("Total No. of Transaction:", (float)pageCorner_x, (float)pageCorner_y + line*fontDetail_height);
	        g2.drawString(dfTotalEmployee.format(printParty.getTotalEmployees()), (float)pageCorner_x + 153, (float)pageCorner_y + line*fontDetail_height);
	        g2.drawString("Seq:    ", (float)pageCorner_x + 337, (float)pageCorner_y + line*fontDetail_height);
	        g2.drawString(String.valueOf(printParty.getWholeModifySeq()), (float)pageCorner_x + 365, (float)pageCorner_y + line*fontDetail_height);
	        line += 1;
	        g2.drawString("Total Amount:", (float)pageCorner_x, (float)pageCorner_y + line*fontDetail_height);
	        g2.drawString(dfAmount.format(printParty.getTotalAmount()), (float)pageCorner_x + 95, (float)pageCorner_y + line*fontDetail_height);
	        line += 3;
	      
	    	firstEmployeePerPage = 0;			//set the maximum of first page can print 32 employee records  
	    	lastEmployeePerPage = 32;
	    }  
	    else{
	    	line += 1;
	    	firstEmployeePerPage = 45*(pageIndex - 1) + 32;		//set the maximum of following each page can print 45 employee records
	    	lastEmployeePerPage = 45*pageIndex + 32;
	    }
	    
	    //print column header
        g2.setFont(fontColumnHeader);
        g2.drawString("Name", (float)pageCorner_x, (float)pageCorner_y + line*fontDetail_height +3);
        g2.drawString("Account No.", (float)pageCorner_x + 182, (float)pageCorner_y + line*fontDetail_height +3);
        g2.drawString("Amount", (float)pageCorner_x + 295, (float)pageCorner_y + line*fontDetail_height +3);
        g2.drawString("Reference", (float)pageCorner_x + 355, (float)pageCorner_y + line*fontDetail_height +3);
        line += 1;
        g2.drawLine((int)pageCorner_x,(int)pageCorner_y + line*(int)fontDetail_height, (int)pageCorner_x + 545, (int)pageCorner_y + line*(int)fontDetail_height - 4);
        line += 1;
	    
	    g2.setFont(fontDetail);
	    
	    //print employee records  
	    for(int i = firstEmployeePerPage; i < lastEmployeePerPage; i++){
	    	try{
	    	  	emp = printEmployee.get(i);
	        	g2.drawString(emp.getName(), (float)pageCorner_x, (float)pageCorner_y + line*fontDetail_height);
	        	g2.drawString(emp.getACNumber(), (float)pageCorner_x + 182 + adjustAcctNo_x(emp.getACNumber(), g2), (float)pageCorner_y + line*fontDetail_height);
	        	g2.drawString(dfAmount.format(emp.getAmount()), (float)pageCorner_x + 272 + adjustAmount_x(emp.getAmount(), g2), (float)pageCorner_y + line*fontDetail_height);
	        	g2.drawString(emp.getReference(), (float)pageCorner_x + 355, (float)pageCorner_y + line*fontDetail_height);
	        	line += 1;
	    	}catch(ArrayIndexOutOfBoundsException e){		//stop printing employee records if all records were printed
		        g2.drawLine((int)pageCorner_x,(int)pageCorner_y + line*(int)fontDetail_height, (int)pageCorner_x + 545, (int)pageCorner_y + line*(int)fontDetail_height - 4);	    		  
	    	    break;
	    	}
	    }     	           
	           	           
	    return PAGE_EXISTS;			//continue printing if current page is not the last page
	}

	
	//adjust account no. to be right alignment for print
	private int adjustAcctNo_x(String acctno, Graphics2D g){
		int fontWidth = g.getFontMetrics().stringWidth(acctno) / acctno.length();
		int adjustLen = FileConnector.Detail.PART2.length() - acctno.length();			
		
//		if(len == 0)
//			return 0;

		return fontWidth*adjustLen;
//		return fontWidth*len - len/2;
	}
	
	//adjust amount to be right alignment for print
	private int adjustAmount_x(double amt, Graphics2D g){
		String sAmt = dfAmount.format(amt);
		int fontWidth = g.getFontMetrics().stringWidth(sAmt) / sAmt.length();
		int adjustLen = FileConnector.Detail.PART3.length()+2 - sAmt.length();	//+1decimal point and +1thousand separator
		
//		int len = 6 - Integer.toString((int)amt).length();
//		
//		if(len == 0)
//			return 0;
//		
//		if (len < 3)
//			return 6*len - len/2; 
//		else
//			return 6*len - len + 4;

		return fontWidth*adjustLen;
	}
	
	
}
