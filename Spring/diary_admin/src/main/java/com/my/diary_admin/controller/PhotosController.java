package com.my.diary_admin.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary_admin.dao.AbroadDao;
import com.my.diary_admin.dao.DomesticDao;
import com.my.diary_admin.vo.Abroad;
import com.my.diary_admin.vo.Domestic;

@Controller
@RequestMapping(value="/photos")
public class PhotosController {

	@Resource(name="DomesticDao")
	private DomesticDao domesticDao;
	
	@Resource(name="AbroadDao")
	private AbroadDao abroadDao;
	
	
	//photos-domestic
	@RequestMapping(value="/getDomesticCount", method=RequestMethod.GET)
	public @ResponseBody int getDomesticCount() {
		
		int count = domesticDao.getDomesticCount();
		
		return count;
	}
	
	@RequestMapping(value="/getDomesticAll", method=RequestMethod.GET)
	public @ResponseBody List<Domestic> getDomesticAll(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<Domestic> domesticList = domesticDao.getDomesticAll(map);
		
		return domesticList;
		
	}
	
	
	//검색리스트-domestic
	@RequestMapping(value="/getDomCountAfterSch", method=RequestMethod.GET)
	public @ResponseBody int getDomCountAfterSch(
				@RequestParam(value="user_idx") int user_idx
			) {
		
		int count = domesticDao.getDomCountAfterSch(user_idx);
		
		return count;
	}
	
	@RequestMapping(value="/getDomChunkAfterSch", method=RequestMethod.GET)
	public @ResponseBody List<Domestic> getDomChunkAfterSch(
				@RequestParam(value="user_idx") int user_idx,
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("user_idx", user_idx);
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<Domestic> list = domesticDao.getDomChunkAfterSch(map);
		
		return list;
	}
	
	@RequestMapping(value="/delDom", method=RequestMethod.POST)
	public @ResponseBody String delDom(
				@RequestParam(value="domestic_idx") int domestic_idx
			) {
		
		Domestic dom = new Domestic();
		dom.setDomestic_idx(domestic_idx);
		
		domesticDao.delDomestic(dom);
		
		return "ok";
	}
	
	
	//photos-abroad
	@RequestMapping(value="/getAbroadCount", method=RequestMethod.GET)
	public @ResponseBody int getAbroadCount() {
		
		int count = abroadDao.getAbroadCount();
		
		return count;
	}
	
	@RequestMapping(value="/getAbroadAll", method=RequestMethod.GET)
	public @ResponseBody List<Abroad> getAbroadAll(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<Abroad> abroadList = abroadDao.getAbroadAll(map);
		
		return abroadList;
		
	}
	
	
	//검색리스트-abroad
	@RequestMapping(value="/getAbroadCountAfterSch", method=RequestMethod.GET)
	public @ResponseBody int getAbroadCountAfterSch(
				@RequestParam(value="user_idx") int user_idx
			) {
		
		int count = abroadDao.getAbroadCountAfterSch(user_idx);
		
		return count;
	}
	
	@RequestMapping(value="/getAbroadChunkAfterSch", method=RequestMethod.GET)
	public @ResponseBody List<Abroad> getAbroadChunkAfterSch(
				@RequestParam(value="user_idx") int user_idx,
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("user_idx", user_idx);
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<Abroad> list = abroadDao.getAbroadChunkAfterSch(map);
		
		return list;
	}
	
	@RequestMapping(value="/delAbroad", method=RequestMethod.POST)
	public @ResponseBody String delAbroad(
				@RequestParam(value="abroad_idx") int abroad_idx
			) {
		
		Abroad ab = new Abroad();
		ab.setAbroad_idx(abroad_idx);
		
		abroadDao.delAbroad(ab);
		
		return "ok";
	}
	
	
	//수정-dom
	@RequestMapping(value="/getDomForUp", method=RequestMethod.GET)
	public @ResponseBody Domestic getDomForUp(
				@RequestParam(value="domestic_idx") int domestic_idx
			) {
		
		Domestic dom = domesticDao.getDomForUp(domestic_idx);
		
		return dom;
	}
	
	
	@RequestMapping(value="/updateDom", method=RequestMethod.POST)
	public @ResponseBody String updateDom(
				@RequestParam(value="domestic_idx") int domestic_idx,
				@RequestParam(value="sight_desc") String sight_desc
			) {
		
		Domestic dom = new Domestic();
		dom.setDomestic_idx(domestic_idx);
		dom.setSight_desc(sight_desc);
		
		domesticDao.updateDom(dom);
		
		return "ok";
		
	}
	
	
	//수정-abroad
	@RequestMapping(value="/getAbForUp", method=RequestMethod.GET)
	public @ResponseBody Abroad getAbForUp(
				@RequestParam(value="abroad_idx") int abroad_idx
			) {
		
		Abroad ab = abroadDao.getAbForUp(abroad_idx);
		
		return ab;
	}
	
	
	@RequestMapping(value="/updateAb", method=RequestMethod.POST)
	public @ResponseBody String updateAb(
				@RequestParam(value="abroad_idx") int abroad_idx,
				@RequestParam(value="sight_desc") String sight_desc
			) {
		
		Abroad ab = new Abroad();
		ab.setAbroad_idx(abroad_idx);
		ab.setSight_desc(sight_desc);
		
		abroadDao.updateAb(ab);
		
		return "ok";
		
	}
}
