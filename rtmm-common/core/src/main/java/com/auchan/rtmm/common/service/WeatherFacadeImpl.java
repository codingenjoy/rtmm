// license-header java merge-point
/**
 * This is only generated once! It will never be overwritten.
 * You can (and have to!) safely modify it by hand.
 * TEMPLATE:    SpringServiceImpl.vsl in andromda-spring cartridge
 * MODEL CLASS: Data::com.auchan.rtmm.common.service::WeatherFacade
 * STEREOTYPE:  Service
 */
package com.auchan.rtmm.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.BeanPropertyRowMapper;

import com.auchan.rtmm.common.utils.QueryUtil;
import com.auchan.rtmm.common.vo.SearchWeatherReportVO;
import com.auchan.rtmm.common.vo.WeatherReportVO;

/**
 * @see com.auchan.rtmm.common.service.WeatherFacade
 */
public class WeatherFacadeImpl
    extends WeatherFacadeBase
{

    /**
     * @see com.auchan.rtmm.common.service.WeatherFacade#getHistoricalWeatherByDate(SearchWeatherReportVO)
     */
    protected  List<WeatherReportVO> handleGetHistoricalWeatherByDate(SearchWeatherReportVO swrVO)
        throws Exception
    {
    	Map<String, Object> whereMap = QueryUtil.inverBeanToMap(swrVO);
		BeanPropertyRowMapper<WeatherReportVO> beanPropertyRowMapper = new BeanPropertyRowMapper<WeatherReportVO>(
				WeatherReportVO.class);
		List<WeatherReportVO> pr = QueryUtil.serachDataList("rtmm", "analysis", "getWeatherByDate", "query_date", whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return (pr!= null && pr.size() >0 ? pr : null);
    }

}