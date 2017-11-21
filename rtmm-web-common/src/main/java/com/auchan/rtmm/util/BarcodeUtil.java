package com.auchan.rtmm.util;

import java.text.DecimalFormat;

public class BarcodeUtil {
	/**
	 * 生成条码 C1 = N1+ N3+N5+N7+N9+N11 C2 = (N2+N4+N6+N8+N10+N12)× 3 CC =
	 * (C1+C2)　取个位数 C (检查码) = 10 - CC　(若值为10，则取0)
	 * 
	 * @param item_no
	 * @return
	 */
	public static String getCustBarCode(Integer item_no) {
		String no = new DecimalFormat("000000").format(item_no);
		String code = "200000" + no;
		byte[] bt = code.getBytes();
		int C1 = ((int) bt[0] + (int) bt[2] + (int) bt[4] + (int) bt[6]
				+ (int) bt[8] + (int) bt[10]) - 6 * 48;
		int C2 = (((int) bt[1] + (int) bt[3] + (int) bt[5] + (int) bt[7]
				+ (int) bt[9] + (int) bt[11]) - 6 * 48) * 3;
		int CC = (C1 + C2) % 10;
		int c = (10 - CC) % 10;
		return code + c;
	}
	
	public static boolean checkBarcodeValid(String barcode){
		int evens = 0;
		int odds = 0;
		for (int i = 0, j = 1; i <= 11; i ++, j++){
			if (i%2 == 0){
				evens = evens + Integer.valueOf(barcode.substring(i, j));;
			}
			else{
				odds = odds + Integer.valueOf(barcode.substring(i, j));;
			}
		}
		int total = evens + odds * 3;
		int checkDigit = 10 - (total % 10);
		if (checkDigit == 10){
			checkDigit = 0;
		}
		if (checkDigit == Integer.valueOf(barcode.substring(12, 13))){
			return true;
		}
		else{
			return false;
		}
	}
}
