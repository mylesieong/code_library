<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="java.io.*"%>
<%@ page language="java" contentType="text/html;charset=utf-8" %> 
<%@ page import="org.w3c.dom.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>

<html>
<head>
<% 
	String errormsg = request.getParameter("errormsg");
	String lang = request.getParameter("lang");

	DocumentBuilderFactory dbf=DocumentBuilderFactory.newInstance();
	DocumentBuilder db =dbf.newDocumentBuilder();
	
	File jsp_para = new File(request.getRealPath(request.getServletPath())); 
	File dir_para = jsp_para.getParentFile().getParentFile();
	Document doc_para= db.parse(dir_para+ "/para_en.xml");
	
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
	
	if(lang!=null&&lang.equals("zh")){
		doc_para= db.parse(dir_para+ "/para_zh.xml");;
	}else{
		lang="en";
	}

%>

<meta http-equiv="Content-Language" content="zh-tw">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%
try{
	out.print(doc_para.getElementsByTagName("BannerText").item(0).getFirstChild().getNodeValue());
}catch(Exception e){
	out.print("");
}
%></title>
</head>
<frameset rows="100,*" border="0">
<%
//for ContentImporter
String html_left = "";
String html_right = "";

File jsp = new File(request.getRealPath(request.getServletPath())); 
File dir = jsp.getParentFile().getParentFile();

File file_left = new File(dir+"/ContentImporter/"+lang+"/main/left.html");
File file_right = new File(dir+"/ContentImporter/"+lang+"/main/right.html");

if(file_left.exists()) {
	html_left="../ContentImporter/"+lang+"/main/left.html";
}
if(file_right.exists()) {
	html_right="../ContentImporter/"+lang+"/main/right.html";
}

if(session.getAttribute("login") != null) {
		if(session.getAttribute("login").toString().equals("pass")) {
%>

	<frame src="../BCM/top.jsp?lang=<%=lang%>" noresize="noresize" scrolling="no" />
    <frameset cols="100,*,100">
	    <frame src="<%=html_left%>" scrolling="no"/>

		    <frame src="mainform.jsp?errormsg=<%=errormsg%>&lang=<%=lang%>" scrolling="no"/>   

	    <frame src="<%=html_right%>" scrolling="no"/>
    </frameset>

<%	
		} else {
			out.println("<frame name=\"fBottom\" src=\"relogin.html\" noresize=\"noresize\" scrolling=\"no\" />");	
		}
	} else {
		out.println("<frame name=\"fBottom\" src=\"relogin.html\" noresize=\"noresize\" scrolling=\"no\" />");	
	}
%>
</frameset> 
</html>