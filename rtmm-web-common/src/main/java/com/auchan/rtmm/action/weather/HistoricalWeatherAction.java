package com.auchan.rtmm.action.weather;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.common.service.CommonFacade;
import com.auchan.rtmm.common.service.WeatherFacade;
import com.auchan.rtmm.common.utils.DateUtils;
import com.auchan.rtmm.common.vo.SearchWeatherReportVO;
import com.auchan.rtmm.common.vo.WeatherReportVO;

@Controller
@RequestMapping("/weather/")
public class HistoricalWeatherAction {
	
	/**
	 * 歷史天氣查詢入口
	 * @return
	 */
	@RequestMapping("historicalWeather")
	public ModelAndView historicalWeather(){
		return 	new ModelAndView("/analysis/historicalWeather/historicalWeather");
	}
	
	/**
	 * 天氣報表查詢入口
	 * @return
	 */
	@RequestMapping("historicalCityWeather")
	public ModelAndView historicalCityWeather(){
		return new ModelAndView("/analysis/historicalWeather/historicalCityWeather");
	}
	
	/**
	 * 查詢歷史天氣列表
	 * @param model
	 * @param swrVO
	 * @return
	 */
	@RequestMapping("getWeather")
	public String getWeather(Model model, SearchWeatherReportVO swrVO ){
		WeatherFacade wf = ServiceUtil.getService("weatherFacade", WeatherFacade.class);
		List<List<WeatherReportVO>> result = new ArrayList<List<WeatherReportVO>> ();
		
		if (swrVO.getStartDate().isEmpty()){
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -5);
			swrVO.setStartDate(sf.format(cal.getTime()));
			swrVO.setEndDate(sf.format(new Date()));
		} 
		//取得所有天氣概況
		List<WeatherReportVO> list = wf.getHistoricalWeatherByDate(swrVO);
		if (list != null){
			// 處理取得的天氣概況
			Integer currentRegnNo = 0;
			List<WeatherReportVO> cityList = new ArrayList<WeatherReportVO> ();
			Integer count = 0;
			
			for (WeatherReportVO record: list){
				// 還是同一個城市, 則加進去 list 裡
				if (record.getRegnNo() != null && record.getRegnNo().equals(currentRegnNo)){
					cityList.add(record);
				}
				else{
					if (count!= 0){
						result.add(cityList);
						cityList= new ArrayList<WeatherReportVO> ();
					}
					cityList.add(record);
					currentRegnNo = record.getRegnNo();
				}
				count++;
				
				// 將最後一筆資料加進 result
				if (count == list.size()){
					result.add(cityList);
				}
			}
		}
		
		model.addAttribute("result", result);
		return "/analysis/historicalWeather/historicalWeatherList";
		
	}
	
	@RequestMapping("chooseMultiCity")
	public String chooseMultiCity(Model model) {
		WeatherFacade wf = ServiceUtil.getService("weatherFacade", WeatherFacade.class);
		List provinceList = wf.getStoreExistGetProvinceList();
		model.addAttribute("provinceList", provinceList);
		//model.addAttribute("callback", callback);
		return "/analysis/historicalWeather/chooseMultiCity";
	}
	
	@ResponseBody
	@RequestMapping("/getStoreExistCity")
	public List getStoreExistCity(Integer regnNo) {
		WeatherFacade wf = ServiceUtil.getService("weatherFacade", WeatherFacade.class);
		return wf.getStoreExistGetCityList(regnNo);
	}
	
	@RequestMapping("getWeatherByCity")
	public String getWeatherByCity(Model model, String startDate,
			String endDate, String cityList) {
		WeatherFacade wf = ServiceUtil.getService("weatherFacade",
				WeatherFacade.class);
		List<List<WeatherReportVO>> finalResult = new ArrayList<List<WeatherReportVO>>();
		//cityList = "320100,420100,320581,320582,210100,330200";
		List<WeatherReportVO> resultList = wf.getHistoricalWeatherByCityList(startDate, endDate, cityList);

		if (resultList != null && resultList.size() > 0) {
			// 處理取得的天氣概況
			Integer currentRegnNo = 0;
			List<WeatherReportVO> cityResult = new ArrayList<WeatherReportVO>();
			Integer count = 0;

			for (WeatherReportVO record : resultList) {
				// 還是同一個城市, 則加進去 list 裡
				if (record.getRegnNo() != null
						&& record.getRegnNo().equals(currentRegnNo)) {
					cityResult.add(record);
				} else {
					if (count != 0) {
						finalResult.add(cityResult);
						cityResult = new ArrayList<WeatherReportVO>();
					}
					cityResult.add(record);
					currentRegnNo = record.getRegnNo();
				}
				count++;

				// 將最後一筆資料加進 result
				if (count == resultList.size()) {
					finalResult.add(cityResult);
				}
			}
		}
		model.addAttribute("result", finalResult);
		return "/analysis/historicalWeather/historicalCityWeatherList";
	}
}
