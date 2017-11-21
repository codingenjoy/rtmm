// license-header java merge-point
/**
 * This is only generated once! It will never be overwritten.
 * You can (and have to!) safely modify it by hand.
 * TEMPLATE:    SpringServiceImpl.vsl in andromda-spring cartridge
 * MODEL CLASS: Data::com.auchan.rtmm.rp.service::RpBatchImportFacade
 * STEREOTYPE:  Service
 */
package com.auchan.rtmm.rp.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.BeanPropertyRowMapper;

import com.auchan.common.logging.AuchanLogger;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.session.SessionHelper;
import com.auchan.rtmm.common.utils.DateUtils;
import com.auchan.rtmm.common.utils.QueryUtil;
import com.auchan.rtmm.rp.RPException;
import com.auchan.rtmm.rp.vo.LBatchRpDmVO;
import com.auchan.rtmm.rp.vo.LBatchRpItemInvalidVO;
import com.auchan.rtmm.rp.vo.LBatchRpItemVO;
import com.auchan.rtmm.rp.vo.LBatchRpStoreVO;
import com.auchan.rtmm.rp.vo.LBatchRpTotalVO;
import com.auchan.rtmm.rp.vo.RpDmVo;

/**
 * @see com.auchan.rtmm.rp.service.RpBatchImportFacade
 */
public class RpBatchImportFacadeImpl extends RpBatchImportFacadeBase {
	private final static AuchanLogger log = AuchanLogger.getLogger(RpBatchImportFacadeImpl.class);

	/**
	 * @see com.auchan.rtmm.rp.service.RpBatchImportFacade#checkRpDmValid(LBatchRpDmVO)
	 */
	protected Double handleCheckRpDmValid(LBatchRpDmVO lBatchRpDmVO) throws Exception {
		// 1.获取RPDM信息
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("rdmNo", lBatchRpDmVO.getRmdNo());
		BeanPropertyRowMapper<RpDmVo> beanPropertyRowMapper = new BeanPropertyRowMapper<RpDmVo>(RpDmVo.class);
		List<RpDmVo> list = QueryUtil.serachDataList("rtmm", "rp", "rpDm", "searchRpDmByPage", whereMap, this.getNamedParameterJdbcTemplate(),
				beanPropertyRowMapper);
		if (list == null || list.size() == 0) {
			throw new RPException("001");
		}

		// 2.判断课别是否存在或有该课别权限
		whereMap = new HashMap<String, Object>();
		whereMap.put("catlgId", lBatchRpDmVO.getCatlgId());
		String sql = QueryUtil.getDataSql("rtmm", "rp", "rpImport", "checkCatlg", whereMap);
		int ret = this.getNamedParameterJdbcTemplate().queryForInt(sql, whereMap);
		if (ret == 0) {
			throw new RPException("002");
		}

		// 3.验证门店确认天数
		if (1 == lBatchRpDmVO.getStCnfrmInd()
				&& DateUtils.dayOffset(lBatchRpDmVO.getStCnfrmBeginDate(), list.get(0).getStCnfrmDays()).after(lBatchRpDmVO.getStCnfrmEndDate())) {
			throw new RPException("003");
		}

		// 4.验证物流准备天数（从门店需求确认结束到门店可以开始下单/补货，中间至少需要留足这个天数供物流部门准备）
		if (1 == lBatchRpDmVO.getStCnfrmInd()
				&& DateUtils.dayOffset(lBatchRpDmVO.getStCnfrmEndDate(), list.get(0).getScmPrepDays()).after(lBatchRpDmVO.getStRepBeginDate())) {
			throw new RPException("004");
		}

		// TODO
		// 5.门店补货提前天数，即DM活动开始日的前多少天，门店可以开始补货（目前系统保留计划的界面中不使用这个参数来决定门店补货期间）
		if(!DateUtils.dayOffset(lBatchRpDmVO.getStRepBeginDate(),list.get(0).getStDlvryBefDays()).after(list.get(0).getRdmBeginDate()))
		{
			throw new RPException("004");
		}
		// 6.获取processId
		sql = QueryUtil.getDataSql("rtmm", "rp", "rpImport", "getProcessId", new HashMap());
		Double processId = this.getNamedParameterJdbcTemplate().queryForObject(sql, new HashMap(), Double.class);
		return processId;
	}

	/**
	 * @see com.auchan.rtmm.rp.service.RpBatchImportFacade#createRpDM(Integer,
	 *      LBatchRpDmVO)
	 */
	protected void handleCreateRpDM(Double processId, LBatchRpDmVO lBatchRpDmVO) throws Exception {
		Connection conn = null;
		PreparedStatement prest = null;
		try {
			conn = this.getJdbcTemplate().getDataSource().getConnection();
			StringBuilder sql = new StringBuilder("insert into L_BATCH_RP_DM(");
			sql.append("process_id,");
			sql.append("rdm_no,");
			sql.append("catlg_id,");
			sql.append("dc_store_no,");
			sql.append("st_rep_begin_date,");
			sql.append("st_rep_end_date,");
			sql.append("creat_by,");
			sql.append("creat_date,");
			sql.append("rp_tot_qty,");
			sql.append("rp_tot_amnt,");
			sql.append("st_cnfrm_ind");
			if (1 == lBatchRpDmVO.getStCnfrmInd()) {
				sql.append(",st_cnfrm_begin_date");
				sql.append(",st_cnfrm_end_date");
			}
			sql.append(") values (");
			sql.append("?,");
			sql.append("?,");
			sql.append("?,");
			sql.append("?,");
			sql.append("?,");
			sql.append("?,");
			sql.append("?,");
			sql.append("?,");
			sql.append("?,");
			sql.append("?,");
			sql.append("?");
			if (1 == lBatchRpDmVO.getStCnfrmInd()) {
				sql.append(",?");
				sql.append(",?");
			}
			sql.append(")");
			prest = conn.prepareStatement(sql.toString(), ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			int rowIdx = 1;
			prest.setDouble(rowIdx++, processId);
			prest.setInt(rowIdx++, lBatchRpDmVO.getRmdNo());
			prest.setInt(rowIdx++, lBatchRpDmVO.getCatlgId());
			prest.setInt(rowIdx++, lBatchRpDmVO.getDcStoreNo());
			prest.setDate(rowIdx++, new java.sql.Date(lBatchRpDmVO.getStRepBeginDate().getTime()));
			prest.setDate(rowIdx++, new java.sql.Date(lBatchRpDmVO.getStRepEndDate().getTime()));
			prest.setString(rowIdx++, SessionHelper.getCurrentStaffNo());
			prest.setDate(rowIdx++, new java.sql.Date(new Date().getTime()));
			prest.setDouble(rowIdx++, lBatchRpDmVO.getRpTotQty());
			prest.setDouble(rowIdx++, lBatchRpDmVO.getRpTotAmnt());
			prest.setInt(rowIdx++, lBatchRpDmVO.getStCnfrmInd());
			if (1 == lBatchRpDmVO.getStCnfrmInd()) {
				prest.setDate(rowIdx++, new java.sql.Date(lBatchRpDmVO.getStCnfrmBeginDate().getTime()));
				prest.setDate(rowIdx++, new java.sql.Date(lBatchRpDmVO.getStCnfrmEndDate().getTime()));
			}
			prest.execute();
		} catch (Exception e) {
			log.error(e);
		} finally {
			if (prest != null) {
				try {
					prest.close();
				} catch (SQLException e) {
					log.error(e);
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					log.error(e);
				}
			}
		}
	}

	@Override
	protected void handleCreateRpItem(Double processId, List lBatchRpItemList) throws Exception {
		List<LBatchRpItemVO> list = lBatchRpItemList;
		Connection conn = null;
		PreparedStatement prest = null;
		try {
			conn = this.getJdbcTemplate().getDataSource().getConnection();
			StringBuilder sql = new StringBuilder("insert into l_batch_rp_item(id,process_id,item_no,buy_price,dc_sup_no,");
			sql.append("ord_multi_parm,init_tot_qty,init_tot_amount,store_no,store_qty,creat_date,creat_by,row_num) values ");
			sql.append("(seq_l_batch_rp_item.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)");
			prest = conn.prepareStatement(sql.toString(), ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			for (LBatchRpItemVO rpItem : list) {
				prest.setDouble(1, processId);
				prest.setString(2, rpItem.getItemNo());
				prest.setString(3, rpItem.getBuyPrice());
				prest.setString(4, rpItem.getDcSupNo());
				prest.setString(5, rpItem.getOrdMultiParm());
				prest.setString(6, rpItem.getInitTotQty());
				prest.setString(7, rpItem.getInitTotAmnt());
				prest.setString(8, rpItem.getStoreNo());
				prest.setString(9, rpItem.getStoreQty());
				prest.setDate(10, new java.sql.Date(new Date().getTime()));
				prest.setString(11, SessionHelper.getCurrentStaffNo());
				prest.setInt(12, rpItem.getRowNum());
				prest.addBatch();
			}
			prest.executeBatch();
		} catch (Exception e) {
			log.error(e);
		} finally {
			if (prest != null) {
				try {
					prest.close();
				} catch (SQLException e) {
					log.error(e);
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					log.error(e);
				}
			}
		}
	}

	/**
	 * @see com.auchan.rtmm.rp.service.RpBatchImportFacade#getRpDM(Integer)
	 */
	protected LBatchRpDmVO handleGetRpDM(Double processId) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("processId", processId);
		BeanPropertyRowMapper<LBatchRpDmVO> beanPropertyRowMapper = new BeanPropertyRowMapper<LBatchRpDmVO>(LBatchRpDmVO.class);
		List<LBatchRpDmVO> list = QueryUtil.serachDataList("rtmm", "rp", "rpImport", "getRpDM", whereMap, this.getNamedParameterJdbcTemplate(),
				beanPropertyRowMapper);
		return list.get(0);
	}

	/**
	 * @see com.auchan.rtmm.rp.service.RpBatchImportFacade#searchRpDmItemValidByPage(Integer,
	 *      PaginationSettings)
	 */
	protected PaginationResult handleSearchRpDmItemValidByPage(Double processId, PaginationSettings pageSet) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("processId", processId);
		BeanPropertyRowMapper<LBatchRpItemVO> beanPropertyRowMapper = new BeanPropertyRowMapper<LBatchRpItemVO>(LBatchRpItemVO.class);
		PaginationResult result = QueryUtil.serachPageData("rtmm", "rp", "rpImport", "searchRpDmItemValidByPage", pageSet, whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return result;
	}

	/**
	 * @see com.auchan.rtmm.rp.service.RpBatchImportFacade#findRpStore(Integer,
	 *      Integer, Integer)
	 */
	protected List handleFindRpStore(Double processId, Integer itemNo, Integer type) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("processId", processId);
		whereMap.put("itemNo", itemNo);
		whereMap.put("type", type);
		BeanPropertyRowMapper<LBatchRpStoreVO> beanPropertyRowMapper = new BeanPropertyRowMapper<LBatchRpStoreVO>(LBatchRpStoreVO.class);
		return QueryUtil.serachDataList("rtmm", "rp", "rpImport", "searchRpDmItemValidByPage", whereMap, this.getNamedParameterJdbcTemplate(),
				beanPropertyRowMapper);

	}

	/**
	 * @see com.auchan.rtmm.rp.service.RpBatchImportFacade#searchRpDmItemInValidByPage(Integer,
	 *      Integer, PaginationSettings)
	 */
	protected PaginationResult handleSearchRpDmItemInValidByPage(Double processId, Integer errorCode, PaginationSettings pageSet) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("processId", processId);
		BeanPropertyRowMapper<LBatchRpItemInvalidVO> beanPropertyRowMapper = new BeanPropertyRowMapper<LBatchRpItemInvalidVO>(LBatchRpItemInvalidVO.class);
		PaginationResult result = QueryUtil.serachPageData("rtmm", "rp", "rpImport", "searchRpDmItemInValidByPage", pageSet, whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return result;
	}

	/**
	 * @see com.auchan.rtmm.rp.service.RpBatchImportFacade#getRPTotal(Integer)
	 */
	protected LBatchRpTotalVO handleGetRPTotal(Double processId) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("processId", processId);
		BeanPropertyRowMapper<LBatchRpTotalVO> beanPropertyRowMapper = new BeanPropertyRowMapper<LBatchRpTotalVO>(LBatchRpTotalVO.class);
		List<LBatchRpTotalVO> list = QueryUtil.serachDataList("rtmm", "rp", "rpImport", "getRPTotal", whereMap, this.getNamedParameterJdbcTemplate(),
				beanPropertyRowMapper);
		return list.get(0);
	}

	@Override
	protected Boolean handleCheckOrder(Double processId) throws Exception {
		Connection conn = this.getJdbcTemplate().getDataSource().getConnection();
		CallableStatement st = null;
		// 生成存储过程名
		StringBuilder procName = new StringBuilder("{ call pkg_rp.check_item(?) }");
		st = conn.prepareCall(procName.toString());
		st.setObject(1, processId, java.sql.Types.VARCHAR);
		st.execute();
		if (null != st)
			st.close();
		if (null != conn)
			conn.close();
		return true;
	}

	@Override
	protected Boolean handleMakeOrder(Double processId) throws Exception {
		Connection conn = null;
		CallableStatement st = null;
		boolean ret = true;
		try {
			conn = this.getJdbcTemplate().getDataSource().getConnection();
			// 生成存储过程名
			StringBuilder procName = new StringBuilder("{ call pkg_rp.make_order(?) }");
			st = conn.prepareCall(procName.toString());
			st.setObject(1, processId, java.sql.Types.VARCHAR);
			st.execute();
		} catch (Exception e) {
			ret = false;
			log.error(e);
		} finally {
			if (null != st) {
				try {
					st.close();
				} catch (SQLException e) {
					ret = false;
					log.error(e);
				}
			}
			if (null != conn) {
				try {
					conn.close();
				} catch (SQLException e) {
					ret = false;
					log.error(e);
				}
			}
		}
		return ret;
	}

	@Override
	protected Integer handleGetTotalCount(Double processId) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("processId", processId);
		String sql = QueryUtil.getDataSql("rtmm", "rp", "rpImport", "getBatchTotalCount", whereMap);
		Integer ret = this.getNamedParameterJdbcTemplate().queryForInt(sql, whereMap);
		return ret;
	}

	@Override
	protected List handleGetStoreDetail(Double processId, Integer itemNo)
			throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("processId", processId);
		whereMap.put("itemNo", itemNo);
		BeanPropertyRowMapper<LBatchRpStoreVO> beanPropertyRowMapper = new BeanPropertyRowMapper<LBatchRpStoreVO>(LBatchRpStoreVO.class);
		List<LBatchRpStoreVO> list = QueryUtil.serachDataList("rtmm", "rp", "rpImport", "getStoreDetail", whereMap, this.getNamedParameterJdbcTemplate(),
				beanPropertyRowMapper);
		return (list != null && list.size()>0? list: null);
	}

	@Override
	protected void handleUpdateRpDmItemValid(List updateList) throws Exception {
		// TODO Auto-generated method stub
		
	}

}