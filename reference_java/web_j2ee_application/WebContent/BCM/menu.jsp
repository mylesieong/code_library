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
	String type_token = null;

	DocumentBuilderFactory dbf=DocumentBuilderFactory.newInstance();
	DocumentBuilder db =dbf.newDocumentBuilder();
	
	File jsp_para = new File(request.getRealPath(request.getServletPath())); 
	File dir_para = jsp_para.getParentFile().getParentFile();
	Document doc_para= db.parse(dir_para+ "/para_en.xml");
	Document doc_type= db.parse(dir_para+ "/type.xml");
	
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

	NodeList nlTypeValue=null;
	NodeList nlTypeName=null;
	
	nlTypeValue= doc_type.getElementsByTagName("value");
	nlTypeName= doc_type.getElementsByTagName("en");
	if(lang!=null&&lang.equals("zh")){
		nlTypeName= doc_type.getElementsByTagName("zh");
	}
	
%>

<meta http-equiv="Content-Language" content="zh-tw">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="../css/style_en.css" />
</head>
<body topmargin="0" onload="document.getElementById('txtfKey').focus();">

<%

String fileCab = null;
String fileKey = null;
boolean isPreviousUser = true;

//get type & key
if(errormsg.equals(new String("sessionfailed"))){
	Cookie ck[] = request.getCookies();
	for(int i=0;i<ck.length;i++) {
		if(ck[i].getName().equals("IRS_TypeCK")){
			fileCab = ck[i].getValue();
		}
		if(ck[i].getName().equals("IRS_KeyCK")){
			fileKey = ck[i].getValue();
		}
		if(ck[i].getName().equals("IRS_UserNameCK")){
			if(!ck[i].getValue().equals(session.getValue("IRS_UserName"))){
				isPreviousUser = false;
			}
		}
	}
}

//clear info if other user login
if(!isPreviousUser){
	fileCab = null;
	fileKey = null;
}

//modify cookies
Cookie ck[] = request.getCookies();
boolean cknameExist = false;
for(int i=0;i<ck.length;i++) {
	if(ck[i].getName().equals("IRS_UserNameCK")){
		ck[i].setValue(session.getValue("IRS_UserName").toString());
		ck[i].setMaxAge(65536);
		ck[i].setPath("/");
		response.addCookie(ck[i]);
		cknameExist = true;
	}
}
  
//add cookies when it's new
if(!cknameExist){
	Cookie ck_new = new Cookie("IRS_UserNameCK",session.getValue("IRS_UserName").toString());
	ck_new.setMaxAge(65536);
	ck_new.setPath("/");
	response.addCookie(ck_new);
}

%>

<form onsubmit="return validateForm()" id="ïrs_form" target="fMidRight" action="/ImgRetrieval/BCM/connect/*" method="post"> 
<table class="ContainerFrame" align="center" border="0" cellpadding="2" cellspacing="0">
	<TR>
		<td class=ContainerFrameHeader width=20>&nbsp;<img src="../images/square.gif" /></td>
		<TD class=ContainerFrameHeader width=130 align="left" colspan="2">
			<TABLE class=ContainerFrameHeader cellSpacing=0 cellPadding=0>
				<TBODY>
					<TR>
						<TD></TD>
						<TD class=ContainerFrameHeader width="100%"> <%
try{
	out.print(doc_para.getElementsByTagName("MainFormTitle").item(0).getFirstChild().getNodeValue());
}catch(Exception e){
	out.print("");
}
%></TD>
           			</TR>
           		</TBODY>
           	</TABLE>
        </TD>
        
        <td class=ContainerFrameHeader width=50></td>
    </TR>

	<tr height=10px><td></td><td></td><td></td><td></td></tr>

	<tr>
		<td width=20></td>
		<td class="Labels" width=230><%

try{
	out.print(doc_para.getElementsByTagName("MainFormTypeLabel").item(0).getFirstChild().getNodeValue());
}catch(Exception e){
	out.print("");
}
%></td>
		<td width=20>
			<select id="type" name="cboType" class="option" onChange="autoFocus()">
				<% 
				if(fileCab!=null){
					out.print("<option value="+fileCab+">");
					
					for (int i=0; i<nlTypeValue.getLength(); i++){
						Element eTypeValue=(Element)nlTypeValue.item(i);
						Element eTypeName=(Element)nlTypeName.item(i);
						if(fileCab!=null && fileCab.equals(eTypeValue.getChildNodes().item(0).getNodeValue())){
							out.print(eTypeName.getChildNodes().item(0).getNodeValue());
						}						
					}

					out.print("</option>"); 
				}

		%>		
				<%
				
				StringTokenizer st = new StringTokenizer(session.getValue("IRS_Types").toString());
				while (st.hasMoreTokens()) {
					type_token = st.nextToken();
				    for (int i=0; i<nlTypeValue.getLength(); i++){
						Element eTypeValue=(Element)nlTypeValue.item(i);
						Element eTypeName=(Element)nlTypeName.item(i);
						if(type_token!=null&&type_token.equals(eTypeValue.getChildNodes().item(0).getNodeValue())){
							out.println("<option value="+eTypeValue.getChildNodes().item(0).getNodeValue()+">"+eTypeName.getChildNodes().item(0).getNodeValue()+"</option>");
							break;
						}
					}
				}
				
					
				%>

			</select>
		</td>
		<td width=20></td>
	</tr>
	
	<tr>
		<td width=20></td>
		<td class="Labels" width=180><%
			 
			try{
				out.print(doc_para.getElementsByTagName("MainFormKeyLabel").item(0).getFirstChild().getNodeValue());
			}catch(Exception e){
				out.print("");
			}%></td>
		<td><input maxlength="10" class="key" type="text" autocomplete='off' name="txtfKey" id="txtfKey" size="12" value=
<%
if (fileKey==null){
	out.print("");
}else{
	out.print(fileKey);
}
%>
></td>
		<td width=20></td>
	</tr>
	
	<tr>
		<td></td>
		<td></td>
		<td style="right:30px"><input class="LinkButtonBackground" type="reset" value="<%

try{
	out.print(doc_para.getElementsByTagName("MainFormClearBtn").item(0).getFirstChild().getNodeValue());
}catch(Exception e){
	out.print("");
}
%>"><input id="RetrieveBtn" class="LinkButtonBackground" type="submit" value="<%
try{
	out.print(doc_para.getElementsByTagName("MainFormRetrieveBtn").item(0).getFirstChild().getNodeValue());
}catch(Exception e){
	out.print("");
}
%>"></td>
		<td></td>
	</tr>
	
	<tr height=7px><td></td><td></td><td></td><td></td></tr>
	
</table>
<br>
<input class="invisible" name="lang" value="<%=lang%>">
</form>

<iframe class="invisible" 
<%
if (errormsg.equals(new String("sessionfailed"))&&isPreviousUser){
	out.print("onload=submitform()");
}
%>
></iframe>
<iframe class="invisible" onload="RemoveItem()"></iframe>

<script type="text/javascript">  

function submitform(){
	document.forms["ïrs_form"].submit();
}  

function validateForm(){
	document.getElementById('txtfKey').focus();
	document.getElementById('txtfKey').select();
	
	if(document.getElementById("txtfKey").value==""){
		return false;
	}
	
	var xmlHttp;
	var isLoading;
	
	try{
	  xmlHttp=new XMLHttpRequest();
	}catch (e){
	  try{
	    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	  }catch (e){
	    try{
	      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	    }catch (e){
	      return false;
	    }
	  }
	}

	xmlHttp.onreadystatechange=function(){
	  if(xmlHttp.readyState==4){
		  isLoading=xmlHttp.responseText;
		  //alert(isLoading.substring(0,1));
		  if(isLoading.substring(0,3)=="yes"){  
			  document.getElementById("txtfKey").value="";
			  document.getElementById('txtfKey').focus();
			  document.getElementById('txtfKey').select();
			  return false;
		  }
	  }
	}
	xmlHttp.open("GET","resultloading.jsp",true);
	xmlHttp.send(null);
}  

function RemoveItem() {
	var objSelect = document.getElementById("type");
	for (var i = objSelect.options.length-1; i >= 0 ; i--) {
		if (objSelect.options[i].value == '<%=fileCab%>') {
			objSelect.options.remove(i);
			break;
		}
	}
}

function autoFocus(){
	document.getElementById('txtfKey').focus();
	document.getElementById('txtfKey').select();
}
</script> 

</body>
</html>