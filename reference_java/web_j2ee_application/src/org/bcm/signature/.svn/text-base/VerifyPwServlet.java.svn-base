package org.bcm.signature;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
public class VerifyPwServlet extends HttpServlet{
	
	private static String SERVER_ADDRESS=null;
	private static String MaxInactiveInterval=null;
	private static String AS400Name=null;
	private static String AS400User=null;
	private static String AS400Password=null;
	private static String SQLServerName=null;
	private static String SQLServerUser=null;
	private static String SQLServerPassword=null;
	
	private Connection con_log;
	private Statement stmt_log;
	
	private String type_str = "";

	public void init( ServletConfig con ) throws ServletException{
		SERVER_ADDRESS = con.getInitParameter("SERVER_ADDRESS");
		MaxInactiveInterval = con.getInitParameter("MaxInactiveInterval");
		AS400Name = con.getInitParameter("AS400name");
		AS400User = con.getInitParameter("AS400user");
		AS400Password = con.getInitParameter("AS400password");
		SQLServerName = con.getInitParameter("SQLServerName");
		SQLServerUser = con.getInitParameter("SQLServerUser");
		SQLServerPassword = con.getInitParameter("SQLServerPassword");
	}

	public synchronized void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		String errormsg = req.getParameter("errormsg");
		String lang = req.getParameter("lang");
		
		/**************** To prevent url attack ***********************/
		if(lang!=null&&(!(lang.equals("en")||lang.equals("zh")||lang.equals("")||lang.equals("null")))){
			resp.sendError(400, "Value Invalid!!!" );
		}
		
		if(errormsg!=null&&(!errormsg.equals("sessionfailed"))){
			if(errormsg!=null&&(!errormsg.equals("null"))){
				try{
					Integer.parseInt(errormsg);
				}catch(Exception e){
					resp.sendError(400, "Value Invalid!!!" );
				}
			}
		}
		/**************** To prevent url attack ***********************/
		
		HttpSession session = req.getSession();

		session.invalidate();
		session = req.getSession(true);
		
		Cookie c = new Cookie("sessionid", session.getId());
		c.setPath("/");
        resp.addCookie(c);
        
		//session.invalidate();
		//session = req.getSession(true);

		//if(session.isNew()&&session.getAttribute("IRS_UserName")!=null){
			//resp.sendError(400, "Value Invalid!!!" );
			//out.println("isnew");
			//session.invalidate();
			//session = req.getSession(true);
		//}
		session.removeAttribute("IRS_Types");
		type_str="";
		int result = verifyPassword(username, password);
		
		resp.setContentType("text/html;charset=big5");
		PrintWriter out = resp.getWriter();
		
		//declare for writing log=====================|
		java.util.Date dateCreated = new java.util.Date();
		java.text.SimpleDateFormat s= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime = s.format(dateCreated);
		String LImgUser = username;
		
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		    con_log = DriverManager.getConnection(SQLServerName, SQLServerUser, SQLServerPassword); 
	        stmt_log = con_log.createStatement();	 
	        
		} catch (Exception e) {
			System.out.println("Server is not started probably...");
			e.printStackTrace();
		}

		//declare for writing log=====================|
		if(result <= 0) {

			StringTokenizer st = new StringTokenizer(type_str);
			String[] sarr = new String[st.countTokens()];
			int stLength = st.countTokens();
			
			for(int i=0; i<stLength; i++) {
				sarr[i] = st.nextToken();
			}
			
			for(int i=0; i<stLength; i++){
				for(int j=i+1; j<stLength; j++){
					if(sarr[i].compareTo(sarr[j]) < 0) {
						String tmp = sarr[i];
						sarr[i] = sarr[j];
						sarr[j] = tmp;
					}
				}
			}
			
			type_str="";
			for(int i=0; i<stLength; i++) {
				type_str = type_str + sarr[i] + " ";
			}

			//Create session
			session.setMaxInactiveInterval(Integer.parseInt(MaxInactiveInterval));
			session.setAttribute("login", "pass");
			session.setAttribute("IRS_UserName", username);
			session.setAttribute("IRS_Password", password);
			session.setAttribute("IRS_Types", type_str);
			session.setAttribute("ResultLoading", "no");

			displayNext(out, errormsg, lang);
			
			//write log for successful login
			String sql_log="insert into ImageLog(LImgUser, LImgAction, LImgDateTime, LImgStatus) values ('"+LImgUser+"','Login','"+currentTime+"','ok')";
			try {
				stmt_log.execute(sql_log);
				con_log.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		} else {
			//write log for fail login
			String sql_log="insert into ImageLog(LImgUser, LImgAction, LImgDateTime, LImgStatus) values ('"+LImgUser+"','Login','"+currentTime+"','fail:"+result+"')";
				
			try {
				stmt_log.execute(sql_log);
				con_log.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			displayLogin(out, result, lang);
		}
		out.close();
	}
	
	private int verifyPassword(String username, String password) {
		int response = 99;
		try {
			//Establish Connection
			Class.forName("com.ibm.as400.access.AS400JDBCDriver");
			Properties prop = new Properties();
			prop.put("user", AS400User);
			prop.put("password", AS400Password);
			prop.put("prompt", "false");
			prop.put("errors", "full");
			Connection as400 = DriverManager.getConnection(AS400Name, prop);
			as400.setAutoCommit(true);
			
			//Call the Stored Procedure
			CallableStatement cstmt = as400.prepareCall("CALL IMODULE.CHKIMGRETRIEVALAUT(?,?,?,?,?,?,?)");
			cstmt.setString(1, username);
			cstmt.setString(2, password);
			cstmt.setString(3, "");
			cstmt.setString(4, "0");
			cstmt.setString(5, "1");
			cstmt.setString(6, "0");
			cstmt.registerOutParameter(7, Types.CHAR);
			cstmt.execute();
			
			response = Integer.parseInt(cstmt.getString(7));

			if(response == 0 || response == 5) {
				ResultSet rs = cstmt.getResultSet();
				
				boolean rsIsNull = true;
				while(rs.next()) {
					rsIsNull = false;
					irsTypes(rs.getString(1));
				}
				
				if(rsIsNull){
					response = 999;
				}
					
				rs.close();
			}
			
			//clean up
			cstmt.close();
			as400.close();
		} 
		catch (Exception e) {
			e.printStackTrace();
		}

		return response;
	}
	
	private String irsTypes(String type){
		if(type.substring(0,5).equals("AINTF")){
			type="ICINTFM";
		}
		type_str = type_str + " I" + type.substring(1);
		return type_str;
	}
	
	private void displayNext(PrintWriter out, String errormsg, String lang) {
		out.println("<html><head><title>Response</title>");
		if(lang!=null&&lang.equals(new String("zh"))){
			out.println("<meta http-equiv=\"refresh\" content=\"0;URL=http://" + SERVER_ADDRESS + "/ImgRetrieval/BCM/main.jsp?errormsg="+errormsg+"&lang="+lang+"\">");
		}else{
			out.println("<meta http-equiv=\"refresh\" content=\"0;URL=http://" + SERVER_ADDRESS + "/ImgRetrieval/BCM/main.jsp?errormsg="+errormsg+"\">");
		}
		out.println("</head><body>");
		out.println("</body></html>");
	}
	
	private void displayLogin(PrintWriter out, int response, String lang) {
		out.println("<html><head><title>Response</title>");
		if(lang!=null&&lang.equals(new String("zh"))){
			out.println("<meta http-equiv=\"refresh\" content=\"0;URL=http://" + SERVER_ADDRESS + "/ImgRetrieval/BCM/index.jsp?errormsg="+response+"&lang="+lang+"\">");
		}else{
			out.println("<meta http-equiv=\"refresh\" content=\"0;URL=http://" + SERVER_ADDRESS + "/ImgRetrieval/BCM/index.jsp?errormsg="+response+"\">");
		}
		out.println("</head><body>");
		out.println("</body></html>");
	}
	
}
