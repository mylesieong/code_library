<%response.setHeader("Cache-Control","no-cache");
try{out.print(session.getValue("ResultLoading"));}catch(Exception e){out.print("yes");}%>
