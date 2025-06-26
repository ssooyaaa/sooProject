package com.my.diary_admin.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary_admin.dao.PhreportDao;
import com.my.diary_admin.vo.Phreport;
import com.my.diary_admin.vo.Report;

@Controller
@RequestMapping(value="/phreport")
public class PhreportController {

	@Resource(name="PhreportDao")
	private PhreportDao phreportDao;
	
	@RequestMapping(value = "/getPhotosCount", method = RequestMethod.GET)
	public @ResponseBody int getPhotosCount() {
		int count = phreportDao.getPhotosCount();
				
		return count;
		
	}
	
	
	@RequestMapping(value = "/getPhotosAll", method = RequestMethod.GET)
	public @ResponseBody List<Phreport> getPhotosAll(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<Phreport> phreportList = phreportDao.getPhotosAll(map);
		
		return phreportList;
	}
	
	
	@RequestMapping(value = "/updateCheck", method = RequestMethod.POST)
	public @ResponseBody String updateCheck(
				@RequestParam(value="phreport_idx") int phreport_idx
			) {
		
		phreportDao.updateCheck(phreport_idx);
		
		return "ok";
	}
	
	@RequestMapping(value = "/returnCheck", method = RequestMethod.POST)
	public @ResponseBody String retrunCheck(
				@RequestParam(value="phreport_idx") int phreport_idx
			) {
		
		phreportDao.returnCheck(phreport_idx);
		
		return "ok";
	}
}
