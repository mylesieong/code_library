<%@ page language="java" import="java.util.*"%>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page language="java" import="java.io.*"%>
<%@ page language="java" contentType="text/html;charset=utf-8" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	}

%>

<link rel="stylesheet" type="text/css" href="../css/style_en.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body topmargin="0" onload="document.getElementById('username').focus();">

<form name="input" action="/ImgRetrieval/BCM/verify/*" method="post" style="width: 250
		px; align="center" target="_top" onsubmit="return validateForm()" >

<table class="ContainerFrame" cellpadding=1 cellspacing=0 align="center" style="margin-top:20px">
	<TR>
		<td class=ContainerFrameHeader width=20>&nbsp;<img src="../images/square.gif" /></td>
		<TD class=ContainerFrameHeader width=130 align="left">
			<TABLE class=ContainerFrameHeader cellSpacing=0 cellPadding=0>
				<TBODY>
					<TR>
						<TD></TD>
						<TD class=ContainerFrameHeader width="100%"> <%
 
try{
	out.print(doc_para.getElementsByTagName("LoginFormTitle").item(0).getFirstChild().getNodeValue());
}catch(Exception e){
	out.print("");
}
%></TD>
           			</TR>
           		</TBODY>
           	</TABLE>
        </TD>
        
        <td class=ContainerFrameHeader width=200></td>
        <td class=ContainerFrameHeader width=50></td>
    </TR>
		
	<tr height=20px><td></td><td></td><td></td><td></td></tr>	
		
	<tr>
		<td width=20></td>
		<td class="Labels" width=180><%

try{
	out.print(doc_para.getElementsByTagName("LoginFormUserName").item(0).getFirstChild().getNodeValue());
}catch(Exception e){
	out.print("");
}
%></td>
		<td width=150><input onkeyup=capWords() class="inputbox" maxlength="10" type="text" id="username" name="username" autocomplete='off' ></td>
		<td width=50></td>
	</tr>
	
	<tr>
		<td></td>
		<td class="Labels"><%

try{
	out.print(doc_para.getElementsByTagName("LoginFormPassword").item(0).getFirstChild().getNodeValue());
}catch(Exception e){
	out.print("");
}
%></td>
		<td><input class="password" id="password" maxlength="10" type="password" name="password" autocomplete='off' ></td>
		<td></td>
	</tr>
				
	<tr>
		<td></td>
		<td></td>
		
		<td><input id="OKbtn" class="LinkButtonBackground" type="submit" value="<%
		 
		try{
			out.print(doc_para.getElementsByTagName("LoginFormOKBtn").item(0).getFirstChild().getNodeValue());
		}catch(Exception e){
			out.print("");
		}
		%>" /></td><td> </td>
	</tr>
	
	<tr height=7px><td></td><td></td><td></td><td></td></tr>
</table>
<input class="invisible" name="errormsg" value="<%=errormsg%>">
<input class="invisible" name="lang" value="<%=lang%>">
</form>

<div class="errormsg" align="center">
<p></p>
<%
if(errormsg.equals("null")){
	
}
else if(errormsg.equals("sessionfailed")){
	
	try{
		out.print(doc_para.getElementsByTagName("msg_sessionfail").item(0).getFirstChild().getNodeValue());
	}catch(Exception e){
		out.print("");
	}
}
else if(errormsg.equals("2")){
	
	try{
		out.print(doc_para.getElementsByTagName("msg_loginfail_2").item(0).getFirstChild().getNodeValue());
	}catch(Exception e){
		out.print("");
	}
}
else if(errormsg.equals("6")){
	
	try{
		out.print(doc_para.getElementsByTagName("msg_loginfail_6").item(0).getFirstChild().getNodeValue());
	}catch(Exception e){
		out.print("");
	}
}
else if(errormsg.equals("999")){
	
	try{
		out.print(doc_para.getElementsByTagName("msg_loginok_rsEmpty").item(0).getFirstChild().getNodeValue());
	}catch(Exception e){
		out.print("");
	}
}
else {
	
	try{
		out.print(doc_para.getElementsByTagName("msg_loginfail_others").item(0).getFirstChild().getNodeValue());
	}catch(Exception e){
		out.print("");
	}
}
%>
</div>

</body>

<script type="text/javascript">  
function capWords() {
	document.getElementById("username").value = document.getElementById("username").value.toUpperCase();
}
	
function validateForm() {
	if(document.getElementById("username").value==""||document.getElementById("password").value==""){
		return false;
	}else{
		document.getElementById("OKbtn").disabled=true;
	}
	
}
</script> 
</html>