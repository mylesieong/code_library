<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="java.io.*"%>
<%@ page language="java" contentType="text/html;charset=utf-8" %> 
<%@ page import="org.w3c.dom.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.bcm.signature.*" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.*"%>
<%! Vector<FileItem> files; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<% 
	String cssServerName =(String)getServletContext().getInitParameter("SERVER_ADDRESS_css");
	String SQLServerName =(String)getServletContext().getInitParameter("SQLServerName");
	String SQLServerUser =(String)getServletContext().getInitParameter("SQLServerUser");
	String SQLServerPassword =(String)getServletContext().getInitParameter("SQLServerPassword");
	String DOCAddress =(String)getServletContext().getInitParameter("DOCAddress");

	String errormsg = request.getParameter("errormsg");
	String lang = request.getParameter("lang");
	String css_addr = null;

	/* *************** To prevent url attack ***********************/
	if(lang!=null&&(!(lang.equals("en")||lang.equals("zh")||lang.equals("")||lang.equals("null")))){
		response.sendError(400, "Value Invalid!!!" );
	}
	
	if(errormsg!=null&&(!errormsg.equals("sessionfailed"))){
		if(errormsg!=null&&(!errormsg.equals("null"))){
			try{
				Integer.parseInt(errormsg);
			}catch(Exception e){
				response.sendError(400, "Value Invalid!!!" );
			}
		}
	}
	/* *************** To prevent url attack ***********************/

	DocumentBuilderFactory dbf=DocumentBuilderFactory.newInstance();
	DocumentBuilder db =dbf.newDocumentBuilder();
	
	File jsp_para = new File(request.getRealPath(request.getServletPath())); 
	File dir_para = jsp_para.getParentFile().getParentFile();
	Document doc_para= db.parse(dir_para+ "/para_en.xml");

	css_addr = "http://"+cssServerName+"/ImgRetrieval/css/style_en.css";
	if(lang!=null&&lang.equals("zh")){
		doc_para= db.parse(dir_para+ "/para_zh.xml");;
		css_addr = "http://"+cssServerName+"/ImgRetrieval/css/style_zh.css";
	}

%>
<link rel="stylesheet" type="text/css" href="<%=css_addr %>" />
<meta http-equiv="Content-Language" content="zh-tw">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script type="text/javascript">
function openPDF(url){
	w = screen.width;
	h = screen.height;
	
	childWindow = window.open( "", "", "resizable = yes ,toolbar = no ,menubar = no, status =no ,location = " + url +",scrollbars = no, width=" +w*0.8 +", height=" +h*0.8 +", left=" +w*0.1 +", top="+h*0.06+"\"" );
	childWindow.document.write("<html><head><title>File Viewer</title>" );
	childWindow.document.write("</head><body onkeydown=onKeyDown() topmargin=0 leftmargin=0 rightmargin=0 bottommargin=0>");
	childWindow.document.write("<iframe src='<%=DOCAddress%>"+url+"#toolbar=0&scrollbar=1' width=100% height=100%></iframe></body></html>");
}
</script>

</head>
<body topmargin="0" leftmargin="0" rightmargin="0">
<% 
String fileCab = request.getParameter("cboType");
String fileKey = request.getParameter("txtfKey");

java.util.Date dateCreated = new java.util.Date();
java.text.SimpleDateFormat s= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String currentTime = s.format(dateCreated);
String LImgUser = (String)session.getValue("IRS_UserName");

Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
Connection con = DriverManager.getConnection(SQLServerName, SQLServerUser, SQLServerPassword);
Statement smt =  con.createStatement();

String sql;

if(session.getAttribute("login") != null) {
		if(session.getAttribute("login").toString().equals("pass")) {
%>
<table border="0" cellpadding="0" class=result align=center width="510px">
	<% 
	files = (Vector<FileItem>)request.getAttribute("ir.files");
	if(files != null) {
		if (files.size() > 0){
			try{
				out.print("<tr class=result><TH class=result>"+doc_para.getElementsByTagName("ResultHeader0").item(0).getFirstChild().getNodeValue()+
						"</TH><TH class=result>"+doc_para.getElementsByTagName("ResultHeader1").item(0).getFirstChild().getNodeValue()
						+"</TH><TH class=result>"+doc_para.getElementsByTagName("ResultHeader2").item(0).getFirstChild().getNodeValue()
						+"</TH><TH class=result>"+doc_para.getElementsByTagName("ResultHeader3").item(0).getFirstChild().getNodeValue()
						+"</TH><TH class=result>"+doc_para.getElementsByTagName("ResultHeader4").item(0).getFirstChild().getNodeValue()
						+"</TH><TH class=result>"+doc_para.getElementsByTagName("ResultHeader5").item(0).getFirstChild().getNodeValue());
						
				out.print("</TH></tr>");
			}catch(Exception e){
				out.print("<tr class=result><TH class=result></TH><TH class=result></TH><TH class=result></TH><TH class=result></TH></tr>");
			}
			
			for(FileItem item : files) {
		        out.print("<tr class=result><td class=result>");
		        out.print(item.getKey4());
		        out.print("</td><td class=result>");
		        out.print("<a href='#' onClick=openPDF(\""+item.getFullPath() + item.getDocument_id() + ".pdf"+"\")>");
		        out.print(item.getDocument_id());
		        out.print("</a></td><td class=result>");
				out.print(item.getKey1());
				out.print("</td><td class=result>");
				out.print(item.getKey2());
				out.print("</td><td class=result>");
				out.print(item.getKey3());
				out.print("</td><td class=result>");
				out.print(item.getKey5());	

				out.print("</td></tr>");
			}
			
			//write log for successful inquery
			
			String sql_log="insert into ImageLog(LImgUser, LImgAction, LImgDateTime, LImgType, LImgKey, LImgStatus) values ('"+LImgUser+"','Inquiry','"+currentTime+"','"+fileCab+"','"+fileKey+"','ok')";
			smt.execute(sql_log);
			con.close();
			session.setAttribute("ResultLoading", "no");
			request.getRequestDispatcher("/BCM/menu.jsp");
	    }else{
	    	%>
	    	<table align=center class="msgError">
	    	<tr>
	    	<td align="center">
	    	<div align="center"  class="msgErrorDiv">
			<%
			try{
				out.print(doc_para.getElementsByTagName("ResultEmpty").item(0).getFirstChild().getNodeValue());
	    	}catch(Exception e){
	    		out.print("error!");
	    	}
			
			//write log for fail inquery
			String sql_log="insert into ImageLog(LImgUser, LImgAction, LImgDateTime, LImgType, LImgKey, LImgStatus) values ('"+LImgUser+"','Inquiry','"+currentTime+"','"+fileCab+"','"+fileKey+"','fail: data not found')";
			smt.execute(sql_log);
			con.close();
			session.setAttribute("ResultLoading", "no");
		}
	}
	%>
	</div>
	</td>
	</tr>
	</table>
</table>

<%	
		} else {
			out.println("<script language=javascript>");   
			out.println("window.open('../BCM/index.jsp?msg=sessionfailed','_top')");
		    out.println("</script>"); 
		}
	} else {
		out.println("<script language=javascript>");   
		out.println("window.open('../BCM/index.jsp?msg=sessionfailed','_top')");
	    out.println("</script>"); 
	}
%>
</body>
</html>