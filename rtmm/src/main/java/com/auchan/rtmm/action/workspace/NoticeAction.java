package com.auchan.rtmm.action.workspace;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.common.logging.AuchanLogger;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.staff.search.PaginationResult;
import com.auchan.rtmm.staff.search.PaginationSettings;
import com.auchan.rtmm.staff.service.NoticeFacade;
import com.auchan.rtmm.staff.service.Order;
import com.auchan.rtmm.staff.vo.NoticeVO;
import com.auchan.rtmm.util.Page;

@Controller
@RequestMapping(value = "/workspace")
public class NoticeAction extends BasicAction {

	private final static AuchanLogger log = AuchanLogger.getLogger(NoticeAction.class);

	@RequestMapping({ "/noticeList" })
	public String list() {
		return "workspace/noticeList";
	}

	@ResponseBody
	@RequestMapping({ "/getNotice4Row" })
	public List getNotice4Row() {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		PaginationSettings ps = new PaginationSettings();
		ps.setPageNo(1);
		ps.setPageSize(5);
		Order order = new Order("createDate", false);
		List<Order> olist = new ArrayList<Order>();
		olist.add(order);
		ps.setOrderBy(olist);
		NoticeFacade nf = ServiceUtil.getService("noticeFacade", NoticeFacade.class);
		PaginationResult paginationResult = nf.getNoticeByPage(null, ps, 1);
		return paginationResult.getData();
	}

	@RequestMapping({ "/noticeInfo" })
	public String getNoticeByPage(Model model, Long noticeId,HttpServletRequest request) {
		request.getSession().removeAttribute("noticeId");
		NoticeFacade nf = ServiceUtil.getService("noticeFacade", NoticeFacade.class);
		NoticeVO nvo = nf.getNoticeById(noticeId);
		model.addAttribute("nvo", nvo);
		return "workspace/noticeInfo";
	}

	@ResponseBody
	@RequestMapping({ "/getNoticeByPage" })
	public Map<String, Object> getNoticeByPage(String title,Integer page, Integer rows) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		PaginationSettings ps = new PaginationSettings();
		ps.setPageNo(1);
		ps.setPageSize(4);
		Order order = new Order("createDate", false);
		List<Order> olist = new ArrayList<Order>();
		olist.add(order);
		ps.setOrderBy(olist);
		NoticeFacade nf = ServiceUtil.getService("noticeFacade", NoticeFacade.class);
		PaginationResult paginationResult = nf.getNoticeByPage(title, ps, 1);
		if (null != paginationResult.getTotalCount()) {
			jsonMap.put("total", paginationResult.getTotalCount());
			jsonMap.put("rows", paginationResult.getData());
		} else {
			jsonMap.put("total", 0);
			jsonMap.put("rows", new ArrayList());
		}
		return jsonMap;
	}
	
	@RequestMapping({ "/getNoticeListByPage" })
	public String getNoticeListByPage(String title,Page<NoticeVO> page,Model model,HttpServletRequest request) {
		Object noticeObj = request.getSession().getAttribute("noticeId");
		String noticeId = null;
		if(noticeObj!=null){
			noticeId = (String)noticeObj;
			request.getSession().removeAttribute("noticeId");
		}
		
		model.addAttribute("noticeId", noticeId);
		PaginationSettings ps = new PaginationSettings();
		if (null == page){
			page = new Page<NoticeVO>(); 
		}
		Order order = new Order("createDate", false);
		List<Order> olist = new ArrayList<Order>();
		olist.add(order);
		ps.setOrderBy(olist);
		ps.setPageNo(page.getPageNo());
		ps.setPageSize(page.getPageSize());
		NoticeFacade nf = ServiceUtil.getService("noticeFacade", NoticeFacade.class);
		PaginationResult paginationResult = nf.getNoticeByPage(title, ps, 1);
		
		if (null != paginationResult.getTotalCount()) {
			page.setResult(paginationResult.getData());
			page.setTotalCount(paginationResult.getTotalCount());
		}
		model.addAttribute("page", page);
		return "workspace/noticeInfoPage";
	}
}
