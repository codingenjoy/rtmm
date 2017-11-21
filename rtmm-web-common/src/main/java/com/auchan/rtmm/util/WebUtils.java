package com.auchan.rtmm.util;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.staff.service.StaffSessionFacade;

public class WebUtils {

	public static String getRuntimeStaffLang() {
		StaffSessionFacade saf = ServiceUtil.getService("staffSessionFacade", StaffSessionFacade.class);
		return saf.getRuntimeStaffLang();
	}
}
