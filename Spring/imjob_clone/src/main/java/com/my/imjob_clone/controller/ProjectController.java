package com.my.imjob_clone.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.imjob_clone.dao.ProjectDao;
import com.my.imjob_clone.vo.Project;

@Controller
@RequestMapping(value="/project")
public class ProjectController {

	@Resource(name="ProjectDao")
	private ProjectDao projectDao;
	
	
	//project 총 개수
	@RequestMapping(value="/getCount", method=RequestMethod.GET)
	public @ResponseBody int getCount() {
		
		int count = projectDao.getCount();
		
		return count;		
	}
	
	@RequestMapping(value="/getProjectAll", method=RequestMethod.GET)
	public @ResponseBody List<Project> getProjectAll(
			@RequestParam(value="start") int start,
			@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<Project> projectList = projectDao.getProjectAll(map);
		
		return projectList;
	}
	
	@RequestMapping(value="/getProjectByIdx", method=RequestMethod.GET)
	public @ResponseBody Project getProjectByIdx(
			@RequestParam(value="project_idx") int project_idx
			) {
		
		Project project = projectDao.getProjectByIdx(project_idx);
		
		return project;
	}
	
	
	@RequestMapping(value="/searchProjectCount", method=RequestMethod.POST)
	public @ResponseBody int searchProjectCount(
			@RequestBody HashMap<String,Object> map
			){
		
		List<String> checkArray = (List<String>)map.get("checkArray");
		String selectOption = (String)map.get("selectOption");
		String keyword = (String)map.get("keyword");
		
		
		map.put("checkArray", checkArray);
		map.put("selectOption", selectOption);
		map.put("keyword", keyword);
		
		
		int count = projectDao.searchProjectCount(map);
		
		return count;
	}
	
	
	@RequestMapping(value="/searchProjectList", method=RequestMethod.POST)
	public @ResponseBody List<Project> searchProjectList(
			@RequestBody HashMap<String,Object> map
			){
		
		List<String> checkArray = (List<String>)map.get("checkArray");
		String selectOption = (String)map.get("selectOption");
		String keyword = (String)map.get("keyword");
		int start = (Integer)map.get("start");
		int cnt = (Integer)map.get("cnt");
		
		
		map.put("checkArray", checkArray);
		map.put("selectOption", selectOption);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("cnt", cnt);
		
		
		List<Project> projectList = projectDao.searchProjectList(map);
		
		return projectList;
	}
	
	
	@RequestMapping(value="/getCheckedCount", method=RequestMethod.GET)
	public @ResponseBody int getCheckedCount(
			@RequestParam(value="field") String field
			) {
		
		int count = projectDao.getCheckedCount(field);
		
		return count;
	}
	
	
	@RequestMapping(value="/getCheckedAll", method=RequestMethod.GET)
	public @ResponseBody List<Project> getCheckedAll(
			@RequestParam(value="field") String field,
			@RequestParam(value="start") int start,
			@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("field", field);
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<Project> checkedList = projectDao.getCheckedAll(map);
		
		return checkedList;
	}
	
	
}


