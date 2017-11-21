--查询
SELECT HIER.P_REGN_NO AS regnNo,
       HIER.P_REGN_NAME AS regnName,
       REAL.STORE_NO AS storeNo,
       
       CATLG.div_No AS divNo,
       CATLG.div_Name AS divName,
       CATLG.div_En_Name AS divEnName,
       CATLG.SEC_NO AS secNo,
       CATLG.SEC_NAME AS secName,
       CATLG.SEC_EN_NAME AS secEnName,
       CATLG.GRP_NO AS grpNo,
       CATLG.GRP_NAME AS grpName,
       CATLG.grp_En_Name AS grpEnName,
       CATLG.MIDGRP_NO AS midNo,
       CATLG.MIDGRP_NAME AS midName,
       CATLG.midgrp_En_Name AS midEnName,
       
       CATLG.CATLG_ID AS catlgId,
       CATLG.catlg_No AS catlgNo,
       CATLG.CATLG_NAME AS catlgName,
       CATLG.catlg_En_Name AS catlgEnName,
       OBJ.MKT_POSTN AS mktPostN,
       OBJ.TRGT_NBR_B AS trgtNbrB,
       REAL.REAL_NBR_B AS realNbrB,
       OBJ.TRGT_NBR_N AS trgtNbrN,
       REAL.REAL_NRB_N AS realNrbN ,
       OBJ.TRGT_NBR_O AS trgtNbrO,
       REAL.REAL_NBR_O AS realNbrO
  FROM (SELECT B.REGN_NO,
               A.CATLG_ID,
               A.STORE_NO,
               A.REAL_NBR_B,
               A.REAL_NRB_N,
               A.REAL_NBR_O
          FROM CL_STORE_BNO_REAL A, STORE B
         WHERE A.STORE_NO = B.STORE_NO) REAL,
       CL_SUBGRP_CTRL OBJ,
       V_REGION_HIER_ASSOC_DNORM_VW HIER,
       v_cl_catalog CATLG
 WHERE REAL.REGN_NO = HIER.REGN_NO
   AND HIER.HIER_NO = 1
   AND HIER.P_LVL = 2
   AND HIER.P_ASSRT_ID = OBJ.REGON_ASSRT_ID
   AND OBJ.CTRL_VAL = 0
   AND REAL.CATLG_ID = OBJ.CATLG_ID
   AND OBJ.CATLG_ID = CATLG.CATLG_ID
   
   #if($regnNo) 
   AND HIER.P_REGN_NO = :regnNo
   #end
   #if($divNo) 
   AND CATLG.div_No = :divNo
   #end
    #if($secNo) 
   AND CATLG.sec_No = :secNo
   #end
    #if($grpNo) 
   AND CATLG.grp_No = :grpNo
   #end
   #if($midNo) 
   AND CATLG.midGRP_No = :midNo
   #end
    #if($catlgId) 
   AND CATLG.catlg_Id = :catlgId
   #end
   #if($catlgNo) 
   AND CATLG.catlg_No = :catlgNo
   #end
   #if($regnName) 
   AND HIER.P_REGN_NAME=:regnName
   #end
   #if($storeNo) 
   AND REAL.STORE_NO=:storeNo
   #end
----
SELECT V.DIV_ID AS divId,
       V.div_No AS divNo,
       V.div_Name AS divName,
       V.div_En_Name AS divEnName,

       V.sec_Id AS secId,
       V.sec_No AS secNo,
       V.sec_Name AS secName,
       V.sec_En_Name AS secEnName,
       V.grp_Id AS grpId,
       V.grp_No AS grpNo,
       V.grp_Name AS grpName,
       V.grp_En_Name AS grpEnName,
       V.midgrp_Id AS  midId,
       V.midgrp_No AS midNo,
       V.midgrp_Name AS midpName,
       V.midgrp_En_Name AS midEn_Name,
       V.subgrp_Id AS sub_Id,
       V.subgrp_No AS sub_No,
       V.subgrp_Name AS sub_Name,
       V.subgrp_En_Name AS sub_En_Name,
       V.CATLG_ID AS catlgId,
       V.CATLG_NO AS catlgNo,
       V.CATLG_NAME AS catlgName,
       V.CATLG_EN_NAME AS catlgEnName,
       V.LVL AS lvl,
       V.STATUS AS status,
       V.PARNT_CATLG_ID AS parentCatlgId,
       V.CREAT_DATE AS createDate,
       V.CHNG_DATE AS chngDate,
       V.CHNG_BY AS chngBy 
 FROM v_cl_catalog V
 WHERE 1=1 
#if($divId) 
 AND v.divId=:divId 
#end 
#if($secId) 
 AND v.secId=:secId 
#end 
#if($grpId) 
 AND v.grpId=:grpId 
#end 
#if($midId) 
 AND v.midId=:midId 
#end 
#if($subId) 
 AND v.subId=:subId 
#end 
#if($lvl) 
 AND v.LVL=:lvl 
#end 
#if($catlgId) 
 AND v.catlgId=:catlgId 
#end 
#if($catlgNo) 
 AND v.catlgNo=:catlgNo 
#end 
#if($catlgName) 
 AND (v.catlgName like :catlgName OR v.catlgEnName like :catlgName)
#end 
#if($status) 
 AND (v.status=:status)
#end