package com.hero.wireless.timer;

import com.drondea.wireless.util.DateTime;
import com.hero.wireless.sms.sender.service.TableDDLService;
import com.hero.wireless.web.config.DatabaseCache;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Date;

import static com.drondea.wireless.util.DateTime.Y_M_D_2;

/**
 * 
 * 删除推送日志
 * 
 * @author volcano
 * @date 2020年1月12日下午9:39:01
 * @version V1.0
 */
@Component
public class DropTableTask extends OperatDataBase {
	@Resource
	private TableDDLService tableDDLService;
	
	/**
	 * 删除50天之前的数据
	* 
	* @author volcano
	* @date 2020年1月12日下午9:43:43
	* @version V1.0
	 */
	@Scheduled(cron = "0 0 1 * * ?")
	public void delete() {
		long startTime = System.currentTimeMillis();
		int dayData = DatabaseCache.getIntValueBySortCodeAndCode(
				"sys_performance_setup", "delete_report_notify_time_interval", 50);
		//删除notify表
		Date date = DateTime.addDay(-dayData);
		String tableSuffix = DateTime.getString(date, Y_M_D_2);
		tableDDLService.dropReportNotifyTable(tableSuffix);
		long endTime = System.currentTimeMillis();
		saveSystemLog("删除状态报告通知表report_notify" + tableSuffix, startTime, endTime, "");

		int deleteMonitorDay = DatabaseCache.getIntValueBySortCodeAndCode(
				"sys_performance_setup", "delete_monitor_day_interval", 10);
		Date dropMonitorDate = DateTime.addDay(-deleteMonitorDay);
		tableSuffix = DateTime.getString(dropMonitorDate, Y_M_D_2);
		saveSystemLog("删除monitor分表" + tableSuffix, System.currentTimeMillis(), System.currentTimeMillis(), "");

		// R3 时限清理:按 log_retention_months 清理日志分表(input_log/report/submit),合规日志留存
		// 安全:Mapper 用 DROP TABLE IF EXISTS(删不存在表不报错);至少保留90天防配置误改误删
		int logRetentionMonths = DatabaseCache.getIntValueBySortCodeAndCode(
				"system_env", "log_retention_months", 12);
		int logRetentionDays = Math.max(logRetentionMonths * 30, 90);
		Date logRetentionDate = DateTime.addDay(-logRetentionDays);
		String logTableSuffix = DateTime.getString(logRetentionDate, Y_M_D_2);
		long r3Start = System.currentTimeMillis();
		try {
			tableDDLService.dropInputLogTable(logTableSuffix);
			tableDDLService.dropReportTable(logTableSuffix);
			tableDDLService.dropSubmitTable(logTableSuffix);
			saveSystemLog("R3日志分表清理 input_log/report/submit@" + logTableSuffix, r3Start, System.currentTimeMillis(),
					"log_retention_months=" + logRetentionMonths + "(约" + logRetentionDays + "天)");
		} catch (Exception e) {
			saveSystemLog("R3日志分表清理失败@" + logTableSuffix, r3Start, System.currentTimeMillis(), e.getMessage());
		}
	}

}
