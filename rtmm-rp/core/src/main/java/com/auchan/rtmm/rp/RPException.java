package com.auchan.rtmm.rp;

import com.auchan.common.core.BasicException;

public class RPException extends BasicException {
	private static final long serialVersionUID = 3517180188838640222L;

	/**
	 * Constructor method.
	 */
	public RPException(String systemCode4AuchanSC) {
		this(systemCode4AuchanSC, (Throwable) null);
	}

	public RPException(String systemCode4AuchanSC, Throwable t) {
		super(systemCode4AuchanSC, t);
		this.PREFIX = "rp";
	}

}
