package com.my.diary.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary.dao.PhreportDao;
import com.my.diary.dao.ReportDao;
import com.my.diary.vo.Phreport;
import com.my.diary.vo.Report;

@Controller
@RequestMapping(value="/report")
public class ReportController {
	
	@Resource(name="ReportDao")
	private ReportDao reportDao;
	
	@Resource(name="PhreportDao")
	private PhreportDao phreportDao;
	

	//tips 신고
	@RequestMapping(value="/addReport", method= {RequestMethod.POST} )
	public @ResponseBody String addReport(
				@RequestParam(value="user_idx") int user_idx,
				@RequestParam(value="report_desc") String report_desc,
				@RequestParam(value="tips_transport") String tips_transport,
				@RequestParam(value="tips_accomodation") String tips_accomodation,
				@RequestParam(value="tips_eat") String tips_eat,
				@RequestParam(value="tips_etc") String tips_etc
			) {
		
		Report newReport = new Report();
		
		newReport.setUser_idx(user_idx);
		newReport.setReport_desc(report_desc);
		newReport.setTips_transport(tips_transport);
		newReport.setTips_accomodation(tips_accomodation);
		newReport.setTips_eat(tips_eat);
		newReport.setTips_etc(tips_etc);
		
		reportDao.addReport(newReport);
		
		return "ok";
	}
	
	
	//photos 신고
	@RequestMapping(value="/addPhreport", method= {RequestMethod.POST} )
	public @ResponseBody String addPhreport(
				@RequestParam(value="user_idx") int user_idx,
				@RequestParam(value="report_desc") String report_desc,
				@RequestParam(value="domestic_sight_img") String domestic_sight_img,
				@RequestParam(value="domestic_sight_desc") String domestic_sight_desc,
				@RequestParam(value="abroad_sight_img") String abroad_sight_img,
				@RequestParam(value="abroad_sight_desc") String abroad_sight_desc
			) {
		
		Phreport ph = new Phreport();
		ph.setUser_idx(user_idx);
		ph.setReport_desc(report_desc);
		ph.setDomestic_sight_img(domestic_sight_img);
		ph.setDomestic_sight_desc(domestic_sight_desc);
		ph.setAbroad_sight_img(abroad_sight_img);
		ph.setAbroad_sight_desc(abroad_sight_desc);
		
		phreportDao.addPhreport(ph);
		
		return "ok";
	}
}
