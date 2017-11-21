package com.auchan.rtmm.common.utils;

import java.awt.image.BufferedImage;  
import java.io.FileOutputStream;  
import java.text.DecimalFormat;

import org.jbarcode.JBarcode;  
import org.jbarcode.encode.Code39Encoder;  
import org.jbarcode.encode.EAN13Encoder;  
import org.jbarcode.paint.BaseLineTextPainter;  
import org.jbarcode.paint.EAN13TextPainter;  
import org.jbarcode.paint.WideRatioCodedPainter;  
import org.jbarcode.paint.WidthCodedPainter;  
import org.jbarcode.util.ImageUtil;  
 
public class BarcodeUtil {  
  
    public static void main1(String[] paramArrayOfString)  
  {  
    try  
    {  
      JBarcode localJBarcode = new JBarcode(EAN13Encoder.getInstance(), WidthCodedPainter.getInstance(), EAN13TextPainter.getInstance());  
      //生成. 欧洲商品条码(=European Article Number)  
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
  
  /**
   * 生成条码
   * 	C1 = N1+ N3+N5+N7+N9+N11
   * 	C2 = (N2+N4+N6+N8+N10+N12)× 3
   * 	CC = (C1+C2)　取个位数
   * 	C (检查码) = 10 - CC　(若值为10，则取0)
   * @param item_no
   * @return
   */
  public static String getCustBarCode(Integer item_no) {
	  String no = new DecimalFormat("000000").format(item_no);
	  String code = "200000"+no;
	  byte[] bt = code.getBytes();
	  int C1 = ((int)bt[0]+(int)bt[2]+(int)bt[4]+(int)bt[6]+(int)bt[8]+(int)bt[10] )-6*48;
	  int C2 = (((int)bt[1]+(int)bt[3]+(int)bt[5]+(int)bt[7]+(int)bt[9]+(int)bt[11] )-6*48)*3;
	  int CC = (C1+C2)%10;
	  int c = (10-CC)%10;
	  return code+c;
  }
  
  
  private static String bc[] = {"2000001008287"};
  
  public static void main(String[] args) {
//	  String barcode = "2000001017210";
	  for(String barcode : bc)
	  {
		  BarcodeUtil.createEan13Barcode(barcode.substring(0, barcode.length()-1),barcode);
		  System.out.println("生成 "+ barcode +" 完成");
	  }
}
  
}  
