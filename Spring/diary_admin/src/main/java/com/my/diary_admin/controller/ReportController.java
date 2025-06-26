package com.my.diary_admin.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary_admin.dao.ReportDao;
import com.my.diary_admin.vo.Report;

@Controller
@RequestMapping(value="/report")
public class ReportController {
	
	@Resource(name="ReportDao")
	private ReportDao reportDao;
	
	
	@RequestMapping(value = "/getTipsCount", method = RequestMethod.GET)
	public @ResponseBody int getTipsCount() {
		int count = reportDao.getTipsCount();
		
		return count;
		
	}
	
	
	@RequestMapping(value = "/getTipsAll", method = RequestMethod.GET)
	public @ResponseBody List<Report> getTipsAll(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<Report> reportList = reportDao.getTipsAll(map);
		
		return reportList;
	}
	
	
	@RequestMapping(value = "/updateCheck", method = RequestMethod.POST)
	public @ResponseBody String updateCheck(
				@RequestParam(value="report_idx") int report_idx
			) {
		
		reportDao.updateCheck(report_idx);
		
		return "ok";
	}
	
	@RequestMapping(value = "/returnCheck", method = RequestMethod.POST)
	public @ResponseBody String retrunCheck(
				@RequestParam(value="report_idx") int report_idx
			) {
		
		reportDao.returnCheck(report_idx);
		
		return "ok";
	}

}
