package com.auchan.rtmm.util;

import java.awt.image.BufferedImage;  
import java.io.FileOutputStream;  
import org.jbarcode.JBarcode;  
import org.jbarcode.encode.Code39Encoder;  
import org.jbarcode.encode.EAN13Encoder;  
import org.jbarcode.paint.BaseLineTextPainter;  
import org.jbarcode.paint.EAN13TextPainter;  
import org.jbarcode.paint.WideRatioCodedPainter;  
import org.jbarcode.paint.WidthCodedPainter;  
import org.jbarcode.util.ImageUtil;  
 
public class OneBarcodeUtil {  
  
    public static void main1(String[] paramArrayOfString)  
  {  
    try  
    {  
      JBarcode localJBarcode = new JBarcode(EAN13Encoder.getInstance(), WidthCodedPainter.getInstance(), EAN13TextPainter.getInstance());  
      //生成. 欧洲商品条码(=European Article Number)  
      //这里我们用作图书条码  
      String str = "788515004012";  
      BufferedImage localBufferedImage = localJBarcode.createBarcode(str);  
      saveToGIF(localBufferedImage, "EAN13.gif");  
      localJBarcode.setEncoder(Code39Encoder.getInstance());  
      localJBarcode.setPainter(WideRatioCodedPainter.getInstance());  
      localJBarcode.setTextPainter(BaseLineTextPainter.getInstance());  
      localJBarcode.setShowCheckDigit(false);  
      //xx  
      str = "JBARCODE-39";  
      localBufferedImage = localJBarcode.createBarcode(str);  
      saveToPNG(localBufferedImage, "Code39.png");  
  
    }  
    catch (Exception localException)  
    {  
      localException.printStackTrace();  
    }  
  }  
  
  static void saveToJPEG(BufferedImage paramBufferedImage, String paramString)  
  {  
    saveToFile(paramBufferedImage, paramString, "jpeg");  
  }  
  
  static void saveToPNG(BufferedImage paramBufferedImage, String paramString)  
  {  
    saveToFile(paramBufferedImage, paramString, "png");  
  }  
  
  static void saveToGIF(BufferedImage paramBufferedImage, String paramString)  
  {  
    saveToFile(paramBufferedImage, paramString, "gif");  
  }  
  
  static void saveToFile(BufferedImage paramBufferedImage, String paramString1, String paramString2)  
  {  
    try  
    {  
      FileOutputStream localFileOutputStream = new FileOutputStream("d:/barcode/" + paramString1);  
      ImageUtil.encodeAndWrite(paramBufferedImage, paramString2, localFileOutputStream, 96, 96);  
      localFileOutputStream.close();  
    }  
    catch (Exception localException)  
    {  
      localException.printStackTrace();  
    }  
  }  
  
  public static void createEan13Barcode(String barcode,String name){
	  try  
	    {  
	      JBarcode localJBarcode = new JBarcode(EAN13Encoder.getInstance(), WidthCodedPainter.getInstance(), EAN13TextPainter.getInstance());  
	      //生成. 欧洲商品条码(=European Article Number)  
	      BufferedImage localBufferedImage = localJBarcode.createBarcode(barcode);  
	      saveToGIF(localBufferedImage, name+".gif");  
	    }  
	    catch (Exception localException)  
	    {  
	      localException.printStackTrace();  
	    } 
  }
  
  private static String bc[] = {"2000001018064",
"2000001017838",
"2000001019429",
"2000001016930",
"2000001018606",
"2000001017296",
"2000001018453",
"2000001019610",
"2000001017067",
"2000001019504",
"2000001020012",
"2000001020555",
"2000001016862",
"2000001018736",
"2000001019382",
"2000001020562",
"2000001018682",
"2000001019672",
"2000001018071",
"2000001016954",
"2000001017845",
"2000001019795",
"2000001018569",
"2000001017814",
"2000001017036",
"2000001017135",
"2000001017272",
"2000001017265",
"2000001018835",
"2000001016879",
"2000001017739",
"2000001018446",
"2000001025215",
"2000001018385",
"2000001017678",
"2000001017456",
"2000001017210"};
  
  public static void main(String[] args) {
//	  String barcode = "2000001017210";
	  for(String barcode : bc)
	  {
		  OneBarcodeUtil.createEan13Barcode(barcode.substring(0, barcode.length()-1),barcode);
		  System.out.println("生成 "+ barcode +" 完成");
	  }
}
  
}  
