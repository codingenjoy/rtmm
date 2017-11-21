package com.auchan.rtmm.common.utils;

import org.springframework.beans.BeansException;

public class BeanUtils {

	public static void copyProperties(Object source, Object target) throws BeansException {
		if (null == source)
			return;
		org.springframework.beans.BeanUtils.copyProperties(source, target);
	}

	public static void copyProperties(Object source, Object target, String[] ignoreProperties) {
		if (null == source)
			return;
		org.springframework.beans.BeanUtils.copyProperties(source, target, ignoreProperties);
	}
}
