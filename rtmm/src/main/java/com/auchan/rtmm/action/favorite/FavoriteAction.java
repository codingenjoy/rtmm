package com.auchan.rtmm.action.favorite;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.staff.service.MenuFacade;
import com.auchan.rtmm.staff.service.RoleFacade;
import com.auchan.rtmm.staff.service.StaffSessionFacade;
import com.auchan.rtmm.staff.vo.JobFunctionVO;
import com.auchan.rtmm.staff.vo.MenuVO;
import com.auchan.rtmm.staff.vo.RuntimeStaffVO;

@Controller
@RequestMapping("/fav")
public class FavoriteAction extends BasicAction {

	@ModelAttribute
	public void setAttribute(Model model) {
		setSeoAndSettingToModel(model);
		StaffSessionFacade saf = ServiceUtil.getService("staffSessionFacade", StaffSessionFacade.class);
		RuntimeStaffVO runtimeStaffVO = saf.getRuntimeStaffInfo();
		model.addAttribute("staffName", runtimeStaffVO.getStaffName());
		model.addAttribute("isFirstLogin", runtimeStaffVO.getIsFirstLogin());

	}

	@RequestMapping("/{sid}")
	public String toSubPage(@PathVariable Long sid, Model model, HttpServletRequest request,Long jobFunctionId) {
		RoleFacade rf = ServiceUtil.getService("roleFacade", RoleFacade.class);
		List<JobFunctionVO> jfList = rf.getJobFunctionInfoByStaff(false);
		model.addAttribute("currentId",jobFunctionId);
		model.addAttribute("jfList", jfList);
		MenuFacade mf = ServiceUtil.getService("menuFacade", MenuFacade.class);
		MenuVO mvo = mf.getFavoriteMenuInfo(sid);
		if (mvo == null) {
			return "commons/noauth";
		}
		MenuVO topMenu = getTopMenu(mf, mvo);
		model.addAttribute("sid", mvo.getId());
		model.addAttribute("toUrl", mvo.getUrl());
		model.addAttribute("mid", topMenu.getId());
		model.addAttribute("pid", topMenu.getId());
		Map<String, Object> paramMap = request.getParameterMap();
		Iterator it = request.getParameterMap().keySet().iterator();
		while (it.hasNext()) {
			String key = (String) it.next();
			String values[] = request.getParameterValues(key);
			if (values.length == 1) {
				request.getSession().setAttribute(key, values[0].trim());
			} else {
				request.getSession().setAttribute(key,values);
			}
		}
		return "main/favIndex";
	}

	/**
	 * 收藏或删除收藏
	 * 
	 * @param mid
	 * @param flag
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/addOrRemove")
	public boolean addOrRemove(Long[] menuIds, boolean flag) {
		MenuFacade mf = ServiceUtil.getService("menuFacade", MenuFacade.class);
		if (flag) {
			mf.setMenuToFavorite(menuIds, false);
		} else {
			mf.delFavoriteByMenus(menuIds);
		}
		return true;
	}

	@ResponseBody
	@RequestMapping("/getAllFavoriteByStaff")
	public List<MenuVO> getAll(Long[] menuIds, boolean flag) {
		MenuFacade mf = ServiceUtil.getService("menuFacade", MenuFacade.class);
		return mf.getAllFavoriteByStaff();
	}

	private MenuVO getTopMenu(MenuFacade mf, MenuVO mvo) {
		MenuVO top = null;
		if (mvo.getParentId() != null) {
			top = getTopMenu(mf, mf.getFavoriteMenuInfo(mvo.getParentId()));
		} else {
			top = mvo;
		}
		return top;
	}

}
