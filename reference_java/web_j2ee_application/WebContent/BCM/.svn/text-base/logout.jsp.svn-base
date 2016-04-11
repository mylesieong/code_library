<%@ page language="java" import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/login.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>

<%
String SQLServerName =(String)getServletContext().getInitParameter("SQLServerName");
String SQLServerUser =(String)getServletContext().getInitParameter("SQLServerUser");
String SQLServerPassword =(String)getServletContext().getInitParameter("SQLServerPassword");

java.util.Date dateCreated = new java.util.Date();
java.text.SimpleDateFormat s= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String currentTime = s.format(dateCreated);
String LImgUser = request.getParameter("user");

Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
Connection con = DriverManager.getConnection(SQLServerName, SQLServerUser, SQLServerPassword);
Statement smt =  con.createStatement();
String sql;
sql="insert into ImageLog(LImgUser, LImgAction, LImgDateTime, LImgStatus) values ('"+LImgUser+"','Logout','"+currentTime+"','ok')";

smt.execute(sql);
con.close();

session.removeValue("IRS_UserName");
session.removeValue("login");

response.sendRedirect("../BCM/index.jsp");
%>

</body>