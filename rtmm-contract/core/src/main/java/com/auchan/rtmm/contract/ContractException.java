package com.auchan.rtmm.contract;

import com.auchan.common.core.BasicException;

public class ContractException extends BasicException {
	private static final long serialVersionUID = 3517180188838640222L;

	/**
	 * Constructor method.
	 */
	public ContractException(String systemCode4AuchanSC) {
		this(systemCode4AuchanSC, (Throwable) null);
	}

	public ContractException(String systemCode4AuchanSC, Throwable t) {
		super(systemCode4AuchanSC, t);
		this.PREFIX = "contract";
	}

}
