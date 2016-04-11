<%@ page language="java" import="java.util.*"%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-tw">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
String errormsg = request.getParameter("errormsg");
String lang = request.getParameter("lang");

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
	out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/style_zh.css\" />");
}else{
	out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/style_en.css\" />");
}
%>
<title></title>
</head>
<body>

<table border="0" align=center>
		  <tr align="center">
		    <td width="100%">
		    	<iframe name="fMidLeft" height="135px" width="100%" src="menu.jsp?errormsg=<%=errormsg%>&lang=<%=lang%>" frameborder=0 scrolling="no"></iframe>
		    </td>
		  </tr>
		  <tr align="center"> 
		    <td width="100%" align="center">
		   		<iframe width="600px" height="160px" name="fMidRight" src="result.jsp?lang=<%=lang%>" frameborder=0 scrolling="auto"></iframe>
		    </td>
		  </tr>
</table>
</body>
</html>