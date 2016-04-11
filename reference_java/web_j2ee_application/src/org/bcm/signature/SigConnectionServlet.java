package org.bcm.signature;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SigConnectionServlet extends HttpServlet{
	
	private Statement stmt_log;
	private Connection con;
	private Statement stmt;
	private Vector<FileItem> files;
	private static String SQLServerName=null;
	private static String SQLServerUser=null;
	private static String SQLServerPassword=null;
	
	public void init(ServletConfig con) throws ServletException {
		super.init(con);
		SQLServerName = con.getInitParameter("SQLServerName");
		SQLServerUser = con.getInitParameter("SQLServerUser");
		SQLServerPassword = con.getInitParameter("SQLServerPassword");
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		session.setAttribute("ResultLoading", "yes");
		
		String sessionid = null;
	    Cookie[] cookies = req.getCookies();
	    if (cookies != null) {
	    	for (int i = 0; i < cookies.length; i++) {
	    		if (cookies[i].getName().equals("sessionid")) {
	    			sessionid = cookies[i].getValue();
	    			break;
	    		}
	    	}
	    }
	    
	    if (sessionid == null || !sessionid.equals(session.getId())) {
	        resp.sendError(400, "Value Invalid!!!" );
	    }
		
		//declare for writing log=====================|
		java.util.Date dateCreated = new java.util.Date();
		java.text.SimpleDateFormat s= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime = s.format(dateCreated);
		String LImgUser = (String) req.getSession().getAttribute("IRS_UserName");
		String fileCab = req.getParameter("cboType");
		String fileKey = req.getParameter("txtfKey");
		String lang = req.getParameter("lang");
		
		/**************** To prevent url attack ***********************/
		if(lang!=null&&(!(lang.equals("en")||lang.equals("zh")||lang.equals("")||lang.equals("null")))){
			resp.sendError(400, "Value Invalid!!!" );
		}
		/**************** To prevent url attack ***********************/
	
		if(!(session.getAttribute("login") != null && session.getAttribute("login").toString().equals("pass"))) {
		     PrintWriter out = resp.getWriter();
	     	 out.println("<script language=javascript>");  

	     	if(lang!=null&&lang.equals("zh")){
	     		out.println("window.open('../../BCM/index.jsp?errormsg=sessionfailed&lang=zh','_top')");
			}else{
				out.println("window.open('../../BCM/index.jsp?errormsg=sessionfailed','_top')");
			}
			 
			 out.println("</script>"); 
		}
		
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		    con = DriverManager.getConnection(SQLServerName, SQLServerUser, SQLServerPassword); 
	        stmt = con.createStatement();	 

	        stmt_log = con.createStatement();	
	        
	        System.out.println("Connected to the server!!");
	        
	        files = new Vector<FileItem>();
		} catch (Exception e) {
			System.out.println("Server is not started probably...");
			e.printStackTrace();
			
			//write log for database connection fail
			String sql_log="insert into ImageLog(LImgUser, LImgAction, LImgDateTime, LImgType, LImgValue, LImgStatus) values ('"+LImgUser+"','Inquiry','"+currentTime+"','"+fileCab+"','"+fileKey+"','fail:database connection')";
			try {
				stmt_log.execute(sql_log);
				con.close();
			} catch (SQLException e_log) {
				e_log.printStackTrace();
			}
			
		}
		try {   

	         //create cookies*******************************
	         boolean cktypeExist = false;
	         boolean ckkeyExist = false;
	         
	         Cookie ck[] = req.getCookies();
	         
	         for(int i=0;i<ck.length;i++) {
	         	 if(ck[i].getName().equals("IRS_TypeCK")){
	         		 ck[i].setValue(fileCab);
	         		 ck[i].setMaxAge(65536);
	         		 ck[i].setPath("/");
	         		 resp.addCookie(ck[i]);
	         		 cktypeExist = true;
	         	 }
	         	if(ck[i].getName().equals("IRS_KeyCK")){
	         		 ck[i].setValue(fileKey);
	         		 ck[i].setMaxAge(65536);
	         		 ck[i].setPath("/");
	         		 resp.addCookie(ck[i]);
	         		 ckkeyExist = true;
	         	 }
	         }

	         if(!(cktypeExist&&ckkeyExist)){
	         	Cookie ck_type = new Cookie("IRS_TypeCK",fileCab);
	         	ck_type.setMaxAge(65536);
	         	ck_type.setPath("/");
	         	resp.addCookie(ck_type);
	         	
	         	Cookie ck_key = new Cookie("IRS_KeyCK",fileKey);
	         	ck_key.setMaxAge(65536);
	         	ck_key.setPath("/");
	         	resp.addCookie(ck_key);
	         }
	         //create cookies*******************************
	         
	         String sql = "SELECT c.*, key1, key2, key3, key4, key5 " +
	         		"FROM (item_file a INNER JOIN item_doc_rel b " +
	         		"ON a.item_id = b.item_id) INNER JOIN doc_location c " +
	         		"ON b.document_id = c.document_id " +
	         		"WHERE file_code='" + fileCab + "' AND key4='" + fileKey + "' ORDER BY c.document_id;";
	         ResultSet rs = stmt.executeQuery(sql);
	         
	         files.removeAllElements();
	         FileItem item;
	         while(rs.next()) {
	        	 item = new FileItem(
	        			 rs.getString("document_id"),
	        			 rs.getString("d_folder"),
	        			 rs.getString("d_directory"),
	        			 rs.getString("o_volumn_id"),
	        			 rs.getString("o_folder"),
	        			 rs.getString("o_directory"),
	        			 rs.getString("key1"),
	        			 rs.getString("key2"),
	        			 rs.getString("key3"),
	        			 rs.getString("key4"),
	        			 rs.getString("key5"));
	        	 		//System.out.println(rs.getString("key4")+"aaa"+rs.getString("key5"));
	        	 files.add(item);
	         }
	         rs.close();
	         
	         if(session.getAttribute("login") != null && session.getAttribute("login").toString().equals("pass")) {
	        	 //clean up
		         stmt_log.close();
			     con.close();
		         stmt.close();
			     con.close();
	        	 
	        	 //set results and pass it to the JSP
	        	 req.setAttribute("ir.files", files);
		         req.getRequestDispatcher("/BCM/result.jsp").forward(req,resp);
		      	 
	     	 }else{

			     //clean up
		         stmt_log.close();
			     con.close();
		         stmt.close();
			     con.close();
	     		 
			     PrintWriter out = resp.getWriter();
		     	 out.println("<script language=javascript>");  

		     	if(lang!=null&&lang.equals("zh")){
		     		out.println("window.open('../../BCM/index.jsp?errormsg=sessionfailed&lang=zh','_top')");
				}else{
					out.println("window.open('../../BCM/index.jsp?errormsg=sessionfailed','_top')");
				}
				 
				 out.println("</script>"); 
	      	}

	      } catch (Exception e) {
	    	  e.printStackTrace();
	    	  
	    	  //write log for query fail
				String sql_log="insert into ImageLog(LImgUser, LImgAction, LImgDateTime, LImgType, LImgKey, LImgStatus) values ('"+LImgUser+"','Inquiry','"+currentTime+"','"+fileCab+"','"+fileKey+"','fail:query')";
				try {
					stmt_log.execute(sql_log);
					con.close();
				} catch (SQLException e_log) {
					e_log.printStackTrace();
				}
	      }
	}
	
}
