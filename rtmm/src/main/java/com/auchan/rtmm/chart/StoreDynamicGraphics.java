package com.auchan.rtmm.chart;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import com.sun.image.codec.jpeg.*;
import com.auchan.common.logging.AuchanLogger;

public class StoreDynamicGraphics {

	 private final static AuchanLogger log = AuchanLogger
			.getLogger(StoreDynamicGraphics.class);
	 private BufferedImage image;
      
	 private static final int imageWidth=434;//the width of image
	 private static final int imageHeight=381;//the height of image
	 private static final int seperationFromRightEdge=5;//the seperation of columns from Right edge
	 private static final int seperationFromTopEdge=30;//the seperation of the first column from Top edge
	 private static final int columnWidth=20;//the width of column
	 private static final int columnHeight=400;//the max data height of column
	 private static final int seperationAdjacentColumn=33;//the seperation of adjacent column 
	 private static final int seperationColumnNum=10;//the seperation of store num from column
	 private static final int fontSize=12;//the size of font 
	 private static final String fontFamily="Microsoft YaHei";//the font family
	 private static final Color fontColor=new Color(Integer.parseInt("99",16),Integer.parseInt("99",16),Integer.parseInt("99",16));
	 private static final Color columnColor=new Color(Integer.parseInt("80",16),Integer.parseInt("CC",16),Integer.parseInt("B2",16));
	 private static final Color lineColor=new Color(Integer.parseInt("CC",16),Integer.parseInt("CC",16),Integer.parseInt("CC",16));
	 private List<Integer> storeDataList;
	 private String url;
	 
	 
	 private int maxGraphicsData;//the max graphics data
	 
	 
	 
	public void createImage(String fileLocation) {

		try {        
			FileOutputStream fos = new FileOutputStream(fileLocation);
			BufferedOutputStream bos = new BufferedOutputStream(fos);
            String formatName = fileLocation.substring(fileLocation.lastIndexOf(".") + 1); 
            try {
				ImageIO.write(image,  formatName , new File(fileLocation) );
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				bos.close();
				fos.close();
			} catch (IOException e) {

				log.error("Create Graphics Image Close Error", e);
			}

		} catch (FileNotFoundException e) {
			log.error("Create Graphics OutputStream Error:", e);
		}

	}

	public void graphicsGeneration(List<Integer> graphicsDataHeightList){
		
		  

		   StoreDynamicGraphics storeDynamicGraphics=new StoreDynamicGraphics();
		   storeDynamicGraphics.image=new BufferedImage(imageWidth, imageHeight, BufferedImage.TYPE_INT_BGR);
		   Graphics graphics=storeDynamicGraphics.image.getGraphics();
		  
//		   set the background of image
		   graphics.setColor(Color.white);
		   graphics.fillRect(0, 0, imageWidth, imageHeight);
		   
//		   set the current time

		   graphics.setColor(fontColor);
		   SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		   String currentTime="*数据截止 "+simpleDateFormat.format(new Date());
		   graphics.setFont(new java.awt.Font(fontFamily, 0, fontSize));
		   graphics.drawString(currentTime, 310, 10);
		   
//		   set the left line and the bottom line
		   graphics.setColor(lineColor);
		   graphics.fillRect(2, 15, 1, 364);
		   graphics.fillRect(2, 379, 432, 1);
		   
//		   set the column of image  
		   
		   int graphicsDataHeight;
		   for(int i=0;i<graphicsDataHeightList.size();i++){
			  
			  graphics.setColor(columnColor);
			  graphicsDataHeight= graphicsDataHeightList.get(i);
              graphics.fillRect(seperationFromRightEdge, seperationFromTopEdge+i*(columnWidth+seperationAdjacentColumn), graphicsDataHeight, columnWidth);     
		   }
//           set the number of store after column
		   for(int i=0;i<storeDataList.size();i++){
			  graphics.setColor(fontColor);
			  graphics.setFont(new java.awt.Font(fontFamily, 0, fontSize));
			  graphicsDataHeight= graphicsDataHeightList.get(i);
			  graphics.drawString(String.valueOf(storeDataList.get(i)),graphicsDataHeight+seperationColumnNum,seperationFromTopEdge+i*(columnWidth+seperationAdjacentColumn)+columnWidth/2+5);
		   }
		   if(null!=this.url&&this.url!=""){
		   storeDynamicGraphics.createImage(this.url);
		   }
	}
	
	public List<Integer> getGraphicsData(Map<String,Integer>  graphicsDataMap){

		storeDataList=new ArrayList<Integer>();
		storeDataList.add(graphicsDataMap.get("NE"));
		storeDataList.add(graphicsDataMap.get("NC"));
		storeDataList.add(graphicsDataMap.get("NW"));
		storeDataList.add(graphicsDataMap.get("SW"));
		storeDataList.add(graphicsDataMap.get("SC"));
		storeDataList.add(graphicsDataMap.get("EC"));
		storeDataList.add(graphicsDataMap.get("CC"));
		
//		circulate the dataMap and get the max value
		maxGraphicsData=storeDataList.get(0);
		for(int i=0;i<storeDataList.size();i++){
			
			 
             if(storeDataList.get(i)>maxGraphicsData){
            	 
            	 maxGraphicsData=storeDataList.get(i);
             }
			
		}
//		circulate get the graphics data height in ArrayList
		List<Integer> graphicsDataList=new ArrayList<Integer>();
		int graphicsDataHeight;
		for(int i=0;i<storeDataList.size();i++){
			
			graphicsDataHeight=storeDataList.get(i)*columnHeight/maxGraphicsData;	
			graphicsDataList.add(graphicsDataHeight);	
		}
		
		return graphicsDataList;
		
	}
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

/*	public static void main(String[] args) {
		
		StoreDynamicGraphics storeDynamicGraphics=new StoreDynamicGraphics();
		List<Integer> graphicsDataHeightList=storeDynamicGraphics.getGraphicsData();
		storeDynamicGraphics.graphicsGeneration(graphicsDataHeightList);
        
	}*/
}
