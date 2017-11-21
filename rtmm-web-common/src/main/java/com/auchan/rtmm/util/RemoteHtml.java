package com.auchan.rtmm.util;


import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

public class RemoteHtml {
	public static  String  getRemoteHtml(String sedasUrl) throws IOException{  
		String remoteFile = sedasUrl;
        URL url = null;  
        HttpURLConnection urlc = null;  
        String sCurrentLine="";    
                java.io.BufferedReader l_reader=null;  
        StringBuffer sTotalString = new StringBuffer("");    
        try {  
        			remoteFile=remoteFile.replaceAll("\\s", "%20");
		            url = new URL(remoteFile); 
		            urlc = (HttpURLConnection) url.openConnection();  
		            urlc.setRequestProperty("Accept-Language", "zh-cn");  
		            urlc.setRequestProperty("User-Agent","Mozilla/6.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
		            l_reader = new java.io.BufferedReader(new java.io.InputStreamReader(urlc.getInputStream(),"UTF-8"));    
		  
		             while ((sCurrentLine = l_reader.readLine()) != null) {    
		            	 sTotalString.append(sCurrentLine);   
		              //sTotalString.append("\n");  
		             }  
		      }finally{  
		        	if(l_reader!=null)  
		            l_reader.close();  
		            if(urlc!=null)  
		            urlc.disconnect();  
		      }  
		      return sTotalString.toString();  
	 }
}
