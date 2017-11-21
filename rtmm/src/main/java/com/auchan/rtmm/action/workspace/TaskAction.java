package com.auchan.rtmm.action.workspace;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.auchan.common.codetable.utils.CodeTableI18NUtil;
import com.auchan.common.core.util.ServiceUtil;
import com.auchan.common.logging.AuchanLogger;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.bean.ProcessRetBean;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.service.CommonFacade;
import com.auchan.rtmm.common.session.SessionHelper;
import com.auchan.rtmm.common.vo.SearchTaskVO;
import com.auchan.rtmm.common.vo.TaskVO;
import com.auchan.rtmm.items.service.ItemCreateFacade;
import com.auchan.rtmm.items.service.ItemsFacade;
import com.auchan.rtmm.items.vo.ItemBasicAuditVO;
import com.auchan.rtmm.items.vo.ItemBasicVO;
import com.auchan.rtmm.staff.service.StaffSessionFacade;
import com.auchan.rtmm.supplier.service.SupplierAduitFacade;
import com.auchan.rtmm.util.BPMUtils;
import com.auchan.rtmm.util.Page;

@Controller
@RequestMapping(value = "/workspace/task")
public class TaskAction extends BasicAction {

	private final static AuchanLogger log = AuchanLogger.getLogger(TaskAction.class);

	/**
	 * 我的草稿箱-厂商管理
	 * 
	 * @return
	 */
	@RequestMapping({ "/list" })
	public String list(String module, Model model) {
		model.addAttribute("module", module);
		return "workspace/taskList";
	}

	@RequestMapping({ "/getTaskByPage" })
	public String getTaskByPage(Model model, Page page, SearchTaskVO searchTaskVO) {
		if (null == page) {
			page = new Page<ItemBasicVO>();
		}

		PaginationSettings pageSettings = new PaginationSettings();
		pageSettings.setPageNo(page.getPageNo());
		pageSettings.setPageSize(page.getPageSize());
		Ordering order = new Ordering(false, "taskId");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSettings.setOrderBy(olist);

		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		PaginationResult paginationResult = cf.searchTaskPage(searchTaskVO, pageSettings);
		if (0 != paginationResult.getTotalCount()) {
			page.setResult(paginationResult.getData());
			page.setTotalCount(paginationResult.getTotalCount());
		}
		model.addAttribute("page", page);

		return "workspace/taskListPage";
	}

	@ResponseBody
	@RequestMapping({ "/doSubmitTask2Audit" })
	public Map<String, Object> doSumitTaskAudit(Integer taskId) throws UnsupportedEncodingException {
		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put(STATUS, SUCCESS);
		retMap.put(MESSAGE, "操作成功");
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		TaskVO taskVO = cf.getTaskById(taskId);

		// ********************提交流程到BPM系统***********************************
		if (taskVO.getTaskSttus() == 1 && BPMUtils.checkItemModifiable(SessionHelper.getCurrentStaffNo(), taskVO.getPrcssId())) {
			retMap.put(STATUS, ERROR);
			retMap.put(MESSAGE, "信息已提交，不可重复提交!");
			return retMap;
		}
		if (taskVO.getTaskType() == 1) {
			// 1.检查是否下传课别到门店
			SupplierAduitFacade sf = ServiceUtil.getService("supplierAduitFacade", SupplierAduitFacade.class);
			List sectionList = sf.getSupplierSectionCatalogByTaskId(taskId);
			if (sectionList.size() <= 0) {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, "信息不完整(还未下传课别到门店)，无法提交!");
				return retMap;
			}

			// 2.启动创建厂商流程
			ProcessRetBean ret = null;
			ret = BPMUtils.createSupplier(taskId.toString(), SessionHelper.getCurrentStaffNo());
			if ("0".equals(ret.getCode())) {
				cf.submitTask2Audit(taskId, ret.getSerialNo());
			} else if ("98".equals(ret.getCode())) {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, CodeTableI18NUtil.getMsgById("100000015").getTitle());
			} else {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, CodeTableI18NUtil.getMsgById("100000008").getTitle());
			}

		} else if (taskVO.getTaskType() == 2) {
			// 1.启动修改厂商流程
			ProcessRetBean ret = null;
			ret = BPMUtils.updateSupplier(taskId.toString(), SessionHelper.getCurrentStaffNo());
			if ("0".equals(ret.getCode())) {
				cf.submitTask2Audit(taskId, ret.getSerialNo());
			} else if ("98".equals(ret.getCode())) {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, CodeTableI18NUtil.getMsgById("100000015").getTitle());
			} else {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, CodeTableI18NUtil.getMsgById("100000008").getTitle());
			}
		} else {
			retMap.put(STATUS, ERROR);
			retMap.put(MESSAGE, "该任务类型不存在，请联系统管理员");
		}
		return retMap;
	}

	@ResponseBody
	@RequestMapping({ "/checkSupplierCanEdit" })
	public boolean checkSupplierCanEdit(Integer taskId) throws UnsupportedEncodingException {
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		TaskVO taskVO = cf.getTaskById(taskId);
		if (taskVO.getPrcssId() != null) {
			return BPMUtils.checkSupplierModifiable(SessionHelper.getCurrentStaffNo(), taskVO.getPrcssId());
		} else {
			return true;
		}
	}

	@ResponseBody
	@RequestMapping({ "/checkItemCanEdit" })
	public boolean doSumitItemCreateTaskCanEdit(Integer taskId) throws UnsupportedEncodingException {
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		TaskVO taskVO = cf.getTaskById(taskId);
		if (taskVO.getPrcssId() != null) {
			return BPMUtils.checkItemModifiable(SessionHelper.getCurrentStaffNo(), taskId.toString());
		} else {
			return true;
		}
	}

	@ResponseBody
	@RequestMapping({ "/checkContractCanEdit" })
	public boolean doSumitContractCreateTaskCanEdit(Integer taskId) throws UnsupportedEncodingException {
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		TaskVO taskVO = cf.getTaskById(taskId);
		if (taskVO.getPrcssId() != null) {
			return BPMUtils.checkContractModifiable(SessionHelper.getCurrentStaffNo(), taskId.toString());
		} else {
			return true;
		}
	}

	@ResponseBody
	@RequestMapping({ "/checkItemCanSubmit" })
	public Map<String, Object> doSumitItemCreateTaskCanSubmit(Integer taskId, Integer itemNo) {
		ItemBasicAuditVO data = null;
		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put(STATUS, SUCCESS);
		retMap.put(MESSAGE, "可以提交!");
		if (taskId != null) {
			CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
			TaskVO tsk = cf.getTaskById(taskId);
			if (tsk != null && tsk.getPrcssId() == null) {
				ItemsFacade itemsFacade = ServiceUtil.getService("itemsFacade", ItemsFacade.class);
				ItemBasicAuditVO base = itemsFacade.getItemAuditByTaskId(taskId);
				ItemCreateFacade createFacade = ServiceUtil.getService("itemCreateFacade", ItemCreateFacade.class);
				data = createFacade.checkItemInfoCanSubmit(base.getItemNo());
				if (data == null) {
					retMap.put(STATUS, ERROR);
					retMap.put(MESSAGE, "数据不完整!");
				}
			} else if (tsk != null && tsk.getPrcssId() != null) {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, "已提交!");
			}
		} else if (itemNo != null) {
			ItemCreateFacade createFacade = ServiceUtil.getService("itemCreateFacade", ItemCreateFacade.class);
			data = createFacade.checkItemInfoCanSubmit(itemNo);
			if (data == null) {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, "数据不完整!");
			}
		}

		return retMap;
	}

	@ResponseBody
	@RequestMapping({ "/doSubmitItemCreateTask2Audit" })
	public Map<String, Object> doSumitItemCreateTaskAudit(Integer taskId) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put(STATUS, SUCCESS);
		retMap.put(MESSAGE, "操作成功");
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		TaskVO taskVO = cf.getTaskById(taskId);

		// 2.提交到工作流系统进行审核
		if (taskVO != null && taskVO.getModule() == 2) {
			// 启动创建厂商流程
			ProcessRetBean ret = null;
			try {
				ret = BPMUtils.createItem(taskId, SessionHelper.getCurrentStaffNo());
			} catch (Exception e) {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, e.getMessage());
				return retMap;
			}
			if ("0".equals(ret.getCode())) {
				cf.submitTask2Audit(taskId, ret.getSerialNo());
			} else if ("98".equals(ret.getCode())) {
				this.log.error(ret.getDesc());
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, ret.getDesc());
			} else {
				this.log.error(ret.getDesc());
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, "提交失败,请尝试重试,或联系系统维护人员！");
			}
		} else {
			retMap.put(STATUS, ERROR);
			retMap.put(MESSAGE, "数据异常!");
		}
		return retMap;
	}

	@ResponseBody
	@RequestMapping({ "/doTaskAudit" })
	public boolean doTaskAudit(Integer taskId) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		cf.doTaskAudit(taskId, 2);
		return true;
	}
	
	@ResponseBody
	@RequestMapping({"/doSubmitContract2Audit"})
	public Map<String, Object> doSubmitContract2Audit(Integer taskId) throws UnsupportedEncodingException {
		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put(STATUS, SUCCESS);
		retMap.put(MESSAGE, "操作成功");
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		TaskVO taskVO = cf.getTaskById(taskId);

		// ********************提交流程到BPM系统***********************************
		if (taskVO.getTaskSttus() == 1 && BPMUtils.checkItemModifiable(SessionHelper.getCurrentStaffNo(), taskVO.getPrcssId())) {
			retMap.put(STATUS, ERROR);
			retMap.put(MESSAGE, "信息已提交，不可重复提交!");
			return retMap;
		}
		if (taskVO.getTaskType() == 51) {
			// 1.启动创建厂商流程
			ProcessRetBean ret = null;
			ret = BPMUtils.createContract(taskId.toString(), SessionHelper.getCurrentStaffNo());
			if ("0".equals(ret.getCode())) {
				cf.submitTask2Audit(taskId, ret.getSerialNo());
			} else if ("98".equals(ret.getCode())) {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, CodeTableI18NUtil.getMsgById("100000015").getTitle());
			} else {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, CodeTableI18NUtil.getMsgById("100000008").getTitle());
			}
		} else if (taskVO.getTaskType() == 52) {
			// 1.启动修改厂商流程
			ProcessRetBean ret = null;
			ret = BPMUtils.updateContract(taskId.toString(), SessionHelper.getCurrentStaffNo());
			if ("0".equals(ret.getCode())) {
				cf.submitTask2Audit(taskId, ret.getSerialNo());
			} else if ("98".equals(ret.getCode())) {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, CodeTableI18NUtil.getMsgById("100000015").getTitle());
			} else {
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, CodeTableI18NUtil.getMsgById("100000008").getTitle());
			}
		} else {
			retMap.put(STATUS, ERROR);
			retMap.put(MESSAGE, "该任务类型不存在，请联系统管理员");
		}
		return retMap;
	}

	@RequestMapping({ "/myTodoTask" })
	public String myTodoTask(String module, Model model) {
		model.addAttribute("locale", getLocale());
		model.addAttribute("module", module);
		return "workspace/myTodoTask";
	}

	@RequestMapping({ "/todoTaskList" })
	public String todoTaskList(String module, Model model) {
		model.addAttribute("locale", getLocale());
		model.addAttribute("module", module);
		return "workspace/todoTaskList";
	}

	@RequestMapping({ "/delegateMgt" })
	public String delegateMgt(String module, Model model) {
		model.addAttribute("locale", getLocale());
		model.addAttribute("module", module);
		return "workspace/delegateMgt";
	}

	@RequestMapping({ "/todoDelegate" })
	public String todoDelegate(String module, Model model) {
		model.addAttribute("locale", getLocale());
		model.addAttribute("module", module);
		return "workspace/todoDelegate";
	}

	private String getLocale() {
		StaffSessionFacade saf = ServiceUtil.getService("staffSessionFacade", StaffSessionFacade.class);
		String lang = saf.getRuntimeStaffLang();
		if ("en".equals(lang)) {
			return "en";
		} else if ("fr".equals(lang)) {
			return "fr";
		} else {
			return "zh";
		}
	}

}
