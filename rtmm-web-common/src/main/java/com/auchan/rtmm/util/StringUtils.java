package com.auchan.rtmm.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtils extends org.apache.commons.lang3.StringUtils {
	public static boolean isNumeric(String str) {
		Pattern pattern1 = Pattern.compile("-?[0-9]");
		Pattern pattern2 = Pattern.compile("-?[0-9]+.?[0-9]+");
		Matcher isNum = pattern1.matcher(str);
		Matcher isDigit = pattern2.matcher(str);
		if (!isNum.matches() && !isDigit.matches()) {
			return false;
		}
		return true;
	}
	
	public static void main(String[] args) {
		System.out.println(StringUtils.isNumeric("12240"));
	}
}
