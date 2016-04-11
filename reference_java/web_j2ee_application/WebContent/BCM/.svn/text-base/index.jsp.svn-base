<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="java.io.*"%>
<%@ page language="java" contentType="text/html;charset=utf-8" %> 
<%@ page import="org.w3c.dom.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>

<html>
<head>

<% 
if(session.getAttribute("login") != null) {
	if(session.getAttribute("login").toString().equals("pass")) {
		response.sendRedirect("/ImgRetrieval/BCM/main.jsp?errormsg=null");
	}
}

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
} %></title>
</head>

<%
//for ContentImporter
String html_left = "";
String html_right = "";
String html_bottom = "";

File jsp = new File(request.getRealPath(request.getServletPath())); 
File dir = jsp.getParentFile().getParentFile();

File file_left = new File(dir+"/ContentImporter/"+lang+"/login/left.html" );
File file_right = new File(dir+"/ContentImporter/"+lang+"/login/right.html" );
File file_bottom = new File(dir+"/ContentImporter/"+lang+"/login/bottom.html" );

if(file_left.exists()) {
	html_left="../ContentImporter/"+lang+"/login/left.html";
}
if(file_right.exists()) {
	html_right="../ContentImporter/"+lang+"/login/right.html";
}
if(file_bottom.exists()) {
	html_bottom="../ContentImporter/"+lang+"/login/bottom.html";
}

%>

<frameset rows="100,*" border="0">
	<frame src="../BCM/top.jsp?errormsg=<%=errormsg%>&lang=<%=lang%>" noresize="noresize" scrolling="no" />
    <frameset cols="120,*,120">
	    <frame src="<%=html_left%>" scrolling="no" />
	    <frameset rows="*,120">
	    
		    <frame src="loginform.jsp?errormsg=<%=errormsg%>&lang=<%=lang%>" scrolling="no" />   
			
			<frame src= "<%=html_bottom%>" scrolling="no" />   
			
   		</frameset>
	    <frame src="<%=html_right%>" scrolling="no"/>
    </frameset>
</frameset>


</html>
