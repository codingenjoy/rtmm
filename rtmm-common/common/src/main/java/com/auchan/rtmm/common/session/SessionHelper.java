package com.auchan.rtmm.common.session;

import com.auchan.common.logging.AuchanLogger;
import com.auchan.common.security.SessionCache;
import com.auchan.common.security.SessionKeyStore;
import com.auchan.common.security.enums.SESSION_NAMED_FILEDS;
import com.auchan.common.security.session.SessionAccessFacade;

public class SessionHelper {

	private static final AuchanLogger log = AuchanLogger.getLogger(SessionHelper.class);

	static final String AUTH_JOB_FUNCTION_ID = "/staff/jobfunctionId/accessjobfunction";
	static final String USER_STORE_SESSION_KEY = "/staff/jobfunction/accessstore";

	public static String getCurrentStaffId() {
		String token = SessionKeyStore.get();
		return (String) SessionAccessFacade.getInstance().getValue(token, SESSION_NAMED_FILEDS.STAFF_ID.getValue());
	}

	public static String getCurrentStaffNo() {
		String token = SessionKeyStore.get();
		try {
			return (String) SessionAccessFacade.getInstance().getValue(token, SESSION_NAMED_FILEDS.STAFF_NO.getValue());
		} catch (Exception e) {
			log.error(e.getMessage());
			return null;
		}

	}

	public static Long getCurrentJobFunctionId() {
		try {
			return (Long) SessionCache.get(AUTH_JOB_FUNCTION_ID);
		} catch (Exception e) {
			log.error(e.getMessage());
			return -1l;
		}
	}

	public static Integer getCurrentStoreNo() {
		try {
			return (Integer) SessionCache.get(USER_STORE_SESSION_KEY);
		} catch (Exception e) {
			log.error(e.getMessage());
			return -1;
		}
	}
}
