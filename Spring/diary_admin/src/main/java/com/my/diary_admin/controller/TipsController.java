package com.my.diary_admin.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary_admin.dao.AccomodationDao;
import com.my.diary_admin.dao.EatDao;
import com.my.diary_admin.dao.EtcDao;
import com.my.diary_admin.dao.TransportDao;
import com.my.diary_admin.vo.Accomodation;
import com.my.diary_admin.vo.Eat;
import com.my.diary_admin.vo.Etc;
import com.my.diary_admin.vo.Transport;

@Controller
@RequestMapping(value="/tips")
public class TipsController {
	
	@Resource(name="TransportDao")
	private TransportDao transportDao;
	
	@Resource(name="AccomodationDao")
	private AccomodationDao accomodationDao;
	
	@Resource(name="EatDao")
	private EatDao eatDao;
	
	@Resource(name="EtcDao")
	private EtcDao etcDao;
	
	
	//tips-transport
		@RequestMapping(value="/getTransportCount", method=RequestMethod.GET)
		public @ResponseBody int getTransportCount() {
			int count = transportDao.getTransportCount();
			
			return count;
		}
		
		
		@RequestMapping(value="/getTransportAll", method=RequestMethod.GET)
		public @ResponseBody List<Transport> getTransportAll(
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				){
			
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Transport> transportList = transportDao.getTransportAll(map);
			
			return transportList;
		}
		
		
		@RequestMapping(value="/delTrans", method=RequestMethod.POST)
		public @ResponseBody String delTrans(
					@RequestParam(value="transport_idx") int transport_idx
				) {
			
			Transport trans = new Transport();
			trans.setTransport_idx(transport_idx);
			
			transportDao.delTrans(trans);
			
			return "ok";
		}
		
		
		//검색 리스트-transport
		@RequestMapping(value="/getTransCountAfterSch", method=RequestMethod.GET)
		public @ResponseBody int getTransCountAfterSch(
					@RequestParam(value="user_idx") int user_idx
				) {
			
			int count = transportDao.getTransCountAfterSch(user_idx);
			
			return count;
		}
		
		@RequestMapping(value="/getTransChunkAfterSch", method=RequestMethod.GET)
		public @ResponseBody List<Transport> getTransChunkAfterSch(
					@RequestParam(value="user_idx") int user_idx,
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				){
		/*
		 * Transport transport = new Transport(); transport.setUser_idx(user_idx);
		 */
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("user_idx", user_idx);
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Transport> list = transportDao.getTransChunkAfterSch(map);
			
			return list;
		}
		
		
		//tips-accomodation
		@RequestMapping(value="/getAccomodationCount", method=RequestMethod.GET)
		public @ResponseBody int getAccomodationCount() {
			
			int count = accomodationDao.getAccomodationCount();
			
			return count;
		}
		
		
		@RequestMapping(value="/getAccomodationAll", method=RequestMethod.GET)
		public @ResponseBody List<Accomodation> getAccomodationAll(
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				) {
			
			HashMap<String, Object> map = new HashMap<String,Object>();
			
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Accomodation> accomodationList = accomodationDao.getAccomodationAll(map);
			
			return accomodationList;
		}
		
		@RequestMapping(value="/delAccom", method=RequestMethod.POST)
		public @ResponseBody String delAccom(
					@RequestParam(value="accomodation_idx") int accomodation_idx
				) {
			
			Accomodation accom = new Accomodation();
			accom.setAccomodation_idx(accomodation_idx);
			
			accomodationDao.delAccom(accom);
			
			return "ok";
		}
		
		//검색 리스트-accomodation
		@RequestMapping(value="/getAccomCountAfterSch", method=RequestMethod.GET)
		public @ResponseBody int getAccomCountAfterSch(
					@RequestParam(value="user_idx") int user_idx
				) {
			
			int count = accomodationDao.getAccomCountAfterSch(user_idx);
			
			return count;
		}
		
		@RequestMapping(value="/getAccomChunkAfterSch", method=RequestMethod.GET)
		public @ResponseBody List<Accomodation> getAccomChunkAfterSch(
					@RequestParam(value="user_idx") int user_idx,
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				){
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("user_idx", user_idx);
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Accomodation> list = accomodationDao.getAccomChunkAfterSch(map);
			
			return list;
		}
		
		
		//tips-eat
		@RequestMapping(value="/getEatCount", method=RequestMethod.GET)
		public @ResponseBody int getEatCount() {
			
			int count = eatDao.getEatCount();
			
			return count;
		}
		
		
		@RequestMapping(value="/getEatAll", method=RequestMethod.GET)
		public @ResponseBody List<Eat> getEatAll(
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				) {
			
			HashMap<String, Object> map = new HashMap<String,Object>();
			
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Eat> eatList = eatDao.getEatAll(map);
			
			return eatList;
		}
	
		@RequestMapping(value="/delEat", method=RequestMethod.POST)
		public @ResponseBody String delEat(
					@RequestParam(value="eat_idx") int eat_idx
				) {
			
			Eat eat = new Eat();
			eat.setEat_idx(eat_idx);
			
			eatDao.delEat(eat);
			
			return "ok";
		}
		
		
		//검색 리스트-eat
		@RequestMapping(value="/getEatCountAfterSch", method=RequestMethod.GET)
		public @ResponseBody int getEatCountAfterSch(
					@RequestParam(value="user_idx") int user_idx
				) {
			
			int count = eatDao.getEatCountAfterSch(user_idx);
			
			return count;
		}
		
		@RequestMapping(value="/getEatChunkAfterSch", method=RequestMethod.GET)
		public @ResponseBody List<Eat> getEatChunkAfterSch(
					@RequestParam(value="user_idx") int user_idx,
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				){
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("user_idx", user_idx);
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Eat> list = eatDao.getEatChunkAfterSch(map);
			
			return list;
		}
		
		
		//tips-etc
		@RequestMapping(value="/getEtcCount", method=RequestMethod.GET)
		public @ResponseBody int getEtcCount() {
			
			int count = etcDao.getEtcCount();
			
			return count;
		}
		
		
		@RequestMapping(value="/getEtcAll", method=RequestMethod.GET)
		public @ResponseBody List<Etc> getEtcAll(
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				) {
			
			HashMap<String, Object> map = new HashMap<String,Object>();
			
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Etc> etcList = etcDao.getEtcAll(map);
			
			return etcList;
		}
		
		
		@RequestMapping(value="/delEtc", method=RequestMethod.POST)
		public @ResponseBody String delEtc(
					@RequestParam(value="etc_idx") int etc_idx
				) {
			
			Etc etc = new Etc();
			etc.setEtc_idx(etc_idx);
			
			etcDao.delEtc(etc);
			
			return "ok";
		}
		
		
		//검색 리스트-etc
		@RequestMapping(value="/getEtcCountAfterSch", method=RequestMethod.GET)
		public @ResponseBody int getEtcCountAfterSch(
					@RequestParam(value="user_idx") int user_idx
				) {
			
			int count = etcDao.getEtcCountAfterSch(user_idx);
			
			return count;
		}
		
		@RequestMapping(value="/getEtcChunkAfterSch", method=RequestMethod.GET)
		public @ResponseBody List<Etc> getEtcChunkAfterSch(
					@RequestParam(value="user_idx") int user_idx,
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				){
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("user_idx", user_idx);
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Etc> list = etcDao.getEtcChunkAfterSch(map);
			
			return list;
		}
		
		
		//수정-transport
		@RequestMapping(value="/getTransForUp", method=RequestMethod.GET)
		public @ResponseBody Transport getTransForUp(
					@RequestParam(value="transport_idx") int transport_idx
				) {
			
			Transport trans = transportDao.getTransForUp(transport_idx);
			
			return trans;
		}
		
		@RequestMapping(value="/updateTrans", method=RequestMethod.POST)
		public @ResponseBody String updateTrans(
					@RequestParam(value="transport_idx") int transport_idx,
					@RequestParam(value="tips_transport") String tips_transport
				) {
			
			Transport trans = new Transport();
			trans.setTransport_idx(transport_idx);
			trans.setTips_transport(tips_transport);
			
			transportDao.updateTrans(trans);
			
			return "ok";
		}
		
		
		//수정-accomodation
		@RequestMapping(value="/getAccomForUp", method=RequestMethod.GET)
		public @ResponseBody Accomodation getAccomForUp(
					@RequestParam(value="accomodation_idx") int accomodation_idx
				) {
			
			Accomodation accom = accomodationDao.getAccomForUp(accomodation_idx);
			
			return accom;
		}
		
		@RequestMapping(value="/updateAccom", method=RequestMethod.POST)
		public @ResponseBody String updateAccom(
					@RequestParam(value="accomodation_idx") int accomodation_idx,
					@RequestParam(value="tips_accomodation") String tips_accomodation
				) {
			
			Accomodation accom = new Accomodation();
			accom.setAccomodation_idx(accomodation_idx);
			accom.setTips_accomodation(tips_accomodation);
			
			accomodationDao.updateAccom(accom);
			
			return "ok";
		}
		
		
		//수정-eat
		@RequestMapping(value="/getEatForUp", method=RequestMethod.GET)
		public @ResponseBody Eat getEatForUp(
					@RequestParam(value="eat_idx") int eat_idx
				) {
			
			Eat eat = eatDao.getEatForUp(eat_idx);
			
			return eat;
		}
		
		@RequestMapping(value="/updateEat", method=RequestMethod.POST)
		public @ResponseBody String updateEat(
					@RequestParam(value="eat_idx") int eat_idx,
					@RequestParam(value="tips_eat") String tips_eat
				) {

			Eat eat = new Eat();
			eat.setEat_idx(eat_idx);
			eat.setTips_eat(tips_eat);
			
			eatDao.updateEat(eat);
			
			return "ok";
		}
		
		
		//수정-etc
		@RequestMapping(value="/getEtcForUp", method=RequestMethod.GET)
		public @ResponseBody Etc getEtcForUp(
					@RequestParam(value="etc_idx") int etc_idx
				) {
			
			Etc etc = etcDao.getEtcForUp(etc_idx);
			
			return etc;
		}
		
		@RequestMapping(value="/updateEtc", method=RequestMethod.POST)
		public @ResponseBody String updateEtc(
					@RequestParam(value="etc_idx") int etc_idx,
					@RequestParam(value="tips_etc") String tips_etc
				) {

			Etc etc = new Etc();
			etc.setEtc_idx(etc_idx);
			etc.setTips_etc(tips_etc);
			
			etcDao.updateEtc(etc);
			
			return "ok";
		}
}
