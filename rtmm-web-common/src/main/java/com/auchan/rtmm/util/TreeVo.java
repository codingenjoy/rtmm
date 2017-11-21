package com.auchan.rtmm.util;

import java.util.List;

public class TreeVo {
	String id;
	String text;
	String state;
	List<TreeVo> children;

	public TreeVo(String id, String text, String state, List<TreeVo> children) {
		super();
		this.id = id;
		this.text = text;
		this.state = state;
		this.children = children;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public List<TreeVo> getChildren() {
		return children;
	}

	public void setChildren(List<TreeVo> children) {
		this.children = children;
	}

}
