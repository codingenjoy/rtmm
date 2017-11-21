package auchan.rtmm.rtmm_websocket;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/websocket/helloName")
public class HelloName {
	private List<Session> peers = new ArrayList<Session>();
	private Timer timer = new Timer(true);
	
	ServerPushMsgTask spmTask = new ServerPushMsgTask();
	public HelloName(){
		timer.schedule(spmTask, 0, 10 * 1000);
	}
    @OnMessage
    public String sayHello(String name) {
        System.out.println("Say hello to '" + name + "'");
        return ("Hello" + name);    
    }
   @OnOpen
    public void helloOnOpen(Session session) {
	   peers.add(session);
        System.out.println("WebSocket opened: " + session.getId());
    }
    
    @OnClose
    public void helloOnClose(Session session, CloseReason reason) {
    	peers.remove(session);
        System.out.println("Closing a WebSocket due to " + reason.getReasonPhrase());
    }
	/**
	 * A timer task to check whether session timeout
	 */
	private class ServerPushMsgTask extends TimerTask {
		public void run() {
			System.out.println("polling...");
			try {
				Iterator<Session> iter0 = peers.iterator();
				Date d0 = new Date();
				while (iter0.hasNext()){
					Session onePeer = iter0.next();
					if (!onePeer.isOpen()) continue;
					StringBuffer bufTxt = new StringBuffer();
					bufTxt.append("Session:" + onePeer.getId()).append("\r\n");
					bufTxt.append("Msg:" + d0.toString()).append("\r\n");
					onePeer.getAsyncRemote().sendText(bufTxt.toString());
				}
			} catch (Exception e) {
				System.err.print(e);
			}
		}
	}    
}