<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="java.io.*"%>
<%@ page language="java" contentType="text/html;charset=utf-8" %> 
<%@ page import="org.w3c.dom.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>

<html>
<head>

<%
	String lang = request.getParameter("lang");
	String errormsg = request.getParameter("errormsg");

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
	}

	if(lang!=null&&lang.equals("zh")){
		out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/style_zh.css\" />");
	}else{
		out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/style_en.css\" />");
	}

%>
<meta http-equiv="Content-Language" content="zh-tw">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body topmargin="0">
<table>
<tr>
<td><img src="../images/bcmNlogoC.JPG"/> </td>
<td>
<div class=SystemName>
<%
try{
	out.print(doc_para.getElementsByTagName("BannerText").item(0).getFirstChild().getNodeValue());
}catch(Exception e){
	out.print("");
} %></div></td>
</tr>
</table>
<div class="text" style="z-index: 2; position: absolute; right: 15px; top: 5px; padding: 0px; ">
<% if(session.getAttribute("login") == null || !session.getAttribute("login").equals("pass")) {
%>
<div align = "right">
	<!--<a href="/ImgRetrieval/BCM/index.jsp?lang=zh" target="_top"><img src="../images/lang_zh.gif" /></a>-->
	<!--<<a href="/ImgRetrieval/BCM/index.jsp" target="_top"><img src="../images/lang_en.gif" /></a>-->
</div>
<%}%>
<% if(session.getAttribute("login") != null) {
		if(session.getAttribute("login").toString().equals("pass")) {
%>
<strong><%=session.getValue("IRS_UserName")%></strong>  [ <a href="../BCM/logout.jsp?user=<%=session.getValue("IRS_UserName")%>" target="_top" ><%
try{
	out.print(doc_para.getElementsByTagName("LogoutText").item(0).getFirstChild().getNodeValue());
}catch(Exception e){
	out.print("");
}
%></a> ]

<%		
		}
	}
%>
</div>
</body>


</html>