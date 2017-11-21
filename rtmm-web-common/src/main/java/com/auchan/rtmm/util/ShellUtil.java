package com.auchan.rtmm.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.Session;
import ch.ethz.ssh2.StreamGobbler;

public class ShellUtil {

	private static String NET_HOST_USERNAME = "";
	private static String NET_HOST_IP = "";
	private static String NET_HOST_PASSWORD = "";
	private static String SHELL_NET_PING = "";
	
	
	/**
	 * 在Cmd下执行脚本,返回执行结果
	 * @param command
	 * @return
	 * @throws InterruptedException
	 */
	public static String execueteCommand(String command,String lineBreak) throws InterruptedException {
		StringBuffer rs = new StringBuffer();
		Process pro = null;
		Runtime runTime = null;
		runTime = Runtime.getRuntime();
		if (runTime == null) {
			rs.append("exerror");
			System.out.println("Create runtime false!");
			System.exit(1);
		}
		try {
			pro = runTime.exec(command);
			BufferedReader input = new BufferedReader(new InputStreamReader(pro.getInputStream()));//这个输入流是获取shell输出的
			PrintWriter output= new PrintWriter(new OutputStreamWriter(pro.getOutputStream()));//这个输出流主要是对Process进行输入控制用的
			String line;
			while ((line = input.readLine()) != null) {
				rs.append(line+lineBreak);//保存输出,并添加换号标记
				//这里是输入数据,目前用不到
				if(-1 != line.indexOf("your input")){//当检测到提示输入时，则执行输入操作
					output.print("zhangsan\r\n");// \r\n 不可少，否则相当于没有Enter操作
					output.flush();//输入完成之后一定要flush。否则一直处在等待输入的地方
				}
			}
			input.close();
			output.close();
			pro.destroy();
		} catch (IOException ex) {
			rs.append("exerror");
			Logger.getLogger(ShellUtil.class.getName()).log(Level.SEVERE, null, ex);
		}
		return rs.toString();
	}
	/**
	 * 执行Shell并将执行结果写入文本文件
	 * @param lineBreak 换行符
	 * @param logFilePath 日志文件路径
	 * @param command 命令集合
	 * @return
	 * @throws InterruptedException
	 * @throws IOException
	 */
	public static String execueteShellAndWriteLog(String lineBreak,String logFilePath,String command) throws InterruptedException, IOException {
		StringBuffer rs = new StringBuffer();
		Runtime rt=Runtime.getRuntime();
		Process pcs=rt.exec(command);
		PrintWriter outWriter=new PrintWriter(new File(logFilePath));
		BufferedReader br = new BufferedReader(new InputStreamReader(pcs.getInputStream()));
		String line=new String();
		while((line = br.readLine()) != null)
		{
			rs.append(line+lineBreak);//保存输出,并添加换号标记
//			System.out.println(line);
			outWriter.write(line);
		}
		try{
			pcs.waitFor();
		}
		catch(InterruptedException e){
			rs.append("exerror");//保存输出,并添加换号标记
			System.err.println("processes was interrupted");
		}
		br.close();
		outWriter.flush();
		outWriter.close();
		int ret=pcs.exitValue();
		System.out.println(ret);
		System.out.println("执行完毕!");
		return rs.toString();
	}

	/**
	 * 执行Shell脚本
	 * @param lineBreak 换行符
	 * @param command 命令集合
	 * @return
	 * @throws InterruptedException
	 * @throws IOException
	 */
	public static String execueteShell(String lineBreak,String... command) throws InterruptedException, IOException {
		StringBuffer rs = new StringBuffer();
		Runtime rt=Runtime.getRuntime();
		Process pcs = rt.exec(command);
		BufferedReader br = new BufferedReader(new InputStreamReader(pcs.getInputStream(),"GBK"));
		String line=new String();
		while((line = br.readLine()) != null)
		{
			rs.append(line);
			rs.append(lineBreak);
		}
		try{
			pcs.waitFor();
		}
		catch(InterruptedException e){
			rs.append("exerror");
			System.err.println("processes was interrupted");
		}
		br.close();
		int ret=pcs.exitValue();
		System.out.println(ret);
		System.out.println("执行完毕!");
		return rs.toString();
		
	}
	/**
	 * 执行Shell脚本
	 * @param IP 换行符
	 * @param lineBreak 换行符
	 * @param command 命令集合
	 * @return
	 * @throws InterruptedException
	 * @throws IOException
	 */
	public static String execueteRASShell(String ip,String userName,String passWord,String lineBreak,String command) throws InterruptedException, IOException {
		StringBuffer rs = new StringBuffer();
		
		Connection conn = new Connection(ip); 
		conn.connect();
		boolean isAuthenticated = conn.authenticateWithPassword(userName, passWord);  
		if (isAuthenticated == false)
			throw new IOException("Authentication failed.");
		Session sess = conn.openSession();  
		sess.execCommand(command);  
		InputStream stdout = new StreamGobbler(sess.getStdout());  
		BufferedReader br = new BufferedReader(new InputStreamReader(stdout,"GBK"));  
		
		String line=new String();
		while((line = br.readLine()) != null)
		{
			rs.append(line);
			rs.append(lineBreak);
		} 
		sess.close();  
		conn.close();   
		br.close();
		System.out.println("execuete over !");
		return rs.toString();
		
	}

	public static void main(String[] args) {
		try {
			String s = ShellUtil.execueteRASShell(NET_HOST_IP, 
					NET_HOST_USERNAME, NET_HOST_PASSWORD, "\r\n", 
					SHELL_NET_PING+" pos001");
			
//			"ls -l /u1/errlog");
			System.out.println(s);
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
