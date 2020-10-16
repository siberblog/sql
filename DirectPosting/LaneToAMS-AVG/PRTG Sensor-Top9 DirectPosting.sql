ALTER PROCEDURE "DBA"."bos_get_directposting_check"(@LastMinute varchar(8))
as

begin

declare @txn_date TIMESTAMP, @NowTimee TIMESTAMP

set 	@txn_date = DATEADD(MINUTE,(-@LastMinute-2),Current TIMESTAMP)
set 	@NowTimee = DATEADD(MINUTE,-2,Current TIMESTAMP)

Select CAST((LaneToAMS_AVG_Seconds||'.'||PlazaID)*1 as DECIMAL(15,3)) as AllData from (

	  Select TOP 9 sum(LaneToAMS_AVG_Seconds) as LaneToAMS_AVG_Seconds, PlazaID from (

		select CAST(AVG(datediff(SECOND, EXIT_TRXN_DTIME, posted_TimeStamp))as DECIMAL(15,0)) AS LaneToAMS_AVG_Seconds,
			   exit_plaza as PlazaID
		from bos_direct_posting 
		where  exit_trxn_dtime between @txn_date  and @NowTimee 
		group by exit_plaza
		
		union all		
		
		select 0  AS LaneToAMS_AVG_Seconds, 102 as PlazaID 
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 103 as PlazaID
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 108 as PlazaID
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 112 as PlazaID
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 114 as PlazaID
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 118 as PlazaID
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 119 as PlazaID
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 122 as PlazaID
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 126 as PlazaID
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 130 as PlazaID
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 131 as PlazaID
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 134 as PlazaID
		union all		
		select 0  AS LaneToAMS_AVG_Seconds, 136 as PlazaID
		
	 ) as Vendeka group by PlazaID order by LaneToAMS_AVG_Seconds desc
) as TempTable1
 
 union all	

 Select CAST((LaneToAMS_AVG_Seconds||'.'||PlazaID)*1 as DECIMAL(15,3)) as AllData from (
	
		select CAST(AVG(datediff(SECOND, EXIT_TRXN_DTIME, posted_TimeStamp))as DECIMAL(15,0)) AS LaneToAMS_AVG_Seconds,
			   999 as PlazaID
		from bos_direct_posting 
		where  exit_trxn_dtime between @txn_date  and @NowTimee 
 
 ) as TempTable2
end


--call dba.bos_get_directposting_check(60);

