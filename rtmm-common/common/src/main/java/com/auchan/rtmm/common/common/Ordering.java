package com.auchan.rtmm.common.common;

import com.auchan.rtmm.common.search.BaseOrdering;

public class Ordering extends BaseOrdering{

	/**
	 *  
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public String toString() {
		return propertyName + " " + (ascending?"asc":"desc");
	}

	public Ordering() {
		super();
	}

	public Ordering(BaseOrdering otherBean) {
		super(otherBean);
	}

	public Ordering(Boolean ascendingIn, String propertyNameIn) {
		super(ascendingIn, propertyNameIn);
	}
	
}
