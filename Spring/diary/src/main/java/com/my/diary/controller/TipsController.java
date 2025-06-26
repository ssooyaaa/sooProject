package com.my.diary.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary.dao.AccomodationCommentDao;
import com.my.diary.dao.AccomodationDao;
import com.my.diary.dao.EatCommentDao;
import com.my.diary.dao.EatDao;
import com.my.diary.dao.EtcCommentDao;
import com.my.diary.dao.EtcDao;
import com.my.diary.dao.TransportCommentDao;
import com.my.diary.dao.TransportDao;
import com.my.diary.vo.Accomodation;
import com.my.diary.vo.AccomodationComment;
import com.my.diary.vo.Eat;
import com.my.diary.vo.EatComment;
import com.my.diary.vo.Etc;
import com.my.diary.vo.EtcComment;
import com.my.diary.vo.Transport;
import com.my.diary.vo.TransportComment;
import com.my.diary.vo.User;

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
	
	@Resource(name="TransportCommentDao")
	private TransportCommentDao transComDao;
	
	@Resource(name="AccomodationCommentDao")
	private AccomodationCommentDao accomComDao;
	
	@Resource(name="EatCommentDao")
	private EatCommentDao eatComDao;
	
	@Resource(name="EtcCommentDao")
	private EtcCommentDao etcComDao;

	
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
		
		
		//다이어리 더보기-tips-transport
		@RequestMapping(value="/getTransByIdx", method=RequestMethod.GET)
		public @ResponseBody List<Transport> getTransByIdx(
					@RequestParam(value="mydiary_idx") int mydiary_idx
				) {
			
			Transport trans = new Transport();
			trans.setMydiary_idx(mydiary_idx);
			
			List<Transport> transList = transportDao.getTransByIdx(trans);
			
			return transList;
		}
		
		
		//다이어리 더보기-tips-accomodation
		@RequestMapping(value="/getAccomByIdx", method=RequestMethod.GET)
		public @ResponseBody List<Accomodation> getAccomByIdx(
					@RequestParam(value="mydiary_idx") int mydiary_idx
				) {
			
			Accomodation accom = new Accomodation();
			accom.setMydiary_idx(mydiary_idx);
			
			List<Accomodation> accomList = accomodationDao.getAccomByIdx(accom);
						
			return accomList;
		}
		
		
		//다이어리 더보기-tips-eat
		@RequestMapping(value="/getEatByIdx", method=RequestMethod.GET)
		public @ResponseBody List<Eat> getEatByIdx(
					@RequestParam(value="mydiary_idx") int mydiary_idx
				) {
			
			Eat eat = new Eat();
			eat.setMydiary_idx(mydiary_idx);
			
			List<Eat> eatList = eatDao.getEatByIdx(eat);
						
			return eatList;
		}
		
		
		//다이어리 더보기-tips-etc
		@RequestMapping(value="/getEtcByIdx", method=RequestMethod.GET)
		public @ResponseBody List<Etc> getEtcByIdx(
					@RequestParam(value="mydiary_idx") int mydiary_idx
				) {
			
			Etc etc = new Etc();
			etc.setMydiary_idx(mydiary_idx);
			
			List<Etc> etcList = etcDao.getEtcByIdx(etc);
						
			return etcList;
		}
		
		
		//검색 리스트-transport
		@RequestMapping(value="/getTransCountAfterSch", method=RequestMethod.GET)
		public @ResponseBody int getTransCountAfterSch(
					@RequestParam(value="nation") String nation
				) {
			
			Transport transport = new Transport();
			transport.setNation(nation);
			
			int count = transportDao.getTransCountAfterSch(transport);
			
			return count;
		}
		
		@RequestMapping(value="/getTransChunkAfterSch", method=RequestMethod.GET)
		public @ResponseBody List<Transport> getTransChunkAfterSch(
					@RequestParam(value="nation") String nation,
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				){
			
			Transport transport = new Transport();
			transport.setNation(nation);
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("nation", nation);
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Transport> list = transportDao.getTransChunkAfterSch(map);
			
			return list;
		}
		
		
		//검색 리스트-accomodation
		@RequestMapping(value="/getAccomCountAfterSch", method=RequestMethod.GET)
		public @ResponseBody int getAccomCountAfterSch(
					@RequestParam(value="nation") String nation
				) {
			
			Accomodation accom = new Accomodation();
			accom.setNation(nation);
			
			int count = accomodationDao.getAccomCountAfterSch(accom);
			
			return count;
		}
		
		@RequestMapping(value="/getAccomChunkAfterSch", method=RequestMethod.GET)
		public @ResponseBody List<Accomodation> getAccomChunkAfterSch(
					@RequestParam(value="nation") String nation,
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				){
			
			Accomodation accomm = new Accomodation();
			accomm.setNation(nation);
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("nation", nation);
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Accomodation> list = accomodationDao.getAccomChunkAfterSch(map);
			
			return list;
		}
		
		
		//검색 리스트-eat
		@RequestMapping(value="/getEatCountAfterSch", method=RequestMethod.GET)
		public @ResponseBody int getEatCountAfterSch(
					@RequestParam(value="nation") String nation
				) {
			
			Eat eat = new Eat();
			eat.setNation(nation);
			
			int count = eatDao.getEatCountAfterSch(eat);
			
			return count;
		}
		
		@RequestMapping(value="/getEatChunkAfterSch", method=RequestMethod.GET)
		public @ResponseBody List<Eat> getEatChunkAfterSch(
					@RequestParam(value="nation") String nation,
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				){
			
			Eat eat = new Eat();
			eat.setNation(nation);
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("nation", nation);
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Eat> list = eatDao.getEatChunkAfterSch(map);
			
			return list;
		}
		
		
		//검색 리스트-etc
		@RequestMapping(value="/getEtcCountAfterSch", method=RequestMethod.GET)
		public @ResponseBody int getEtcCountAfterSch(
					@RequestParam(value="nation") String nation
				) {
			
			Etc etc = new Etc();
			etc.setNation(nation);
			
			int count = etcDao.getEtcCountAfterSch(etc);
			
			return count;
		}
		
		@RequestMapping(value="/getEtcChunkAfterSch", method=RequestMethod.GET)
		public @ResponseBody List<Etc> getEtcChunkAfterSch(
					@RequestParam(value="nation") String nation,
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				){
			
			Etc etc = new Etc();
			etc.setNation(nation);
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("nation", nation);
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Etc> list = etcDao.getEtcChunkAfterSch(map);
			
			return list;
		}
		
		
		//댓글창-transport
		@RequestMapping(value="/getTransForCom", method=RequestMethod.GET)
		public @ResponseBody Transport getTransForCom(
				@RequestParam(value="transport_idx") int transport_idx
				) {
			
			Transport trans = transportDao.getTransForCom(transport_idx);
			
			return trans;
		}
		
		
		@RequestMapping(value="/getTransCom", method=RequestMethod.GET)
		public @ResponseBody List<TransportComment> getTransCom(
					@RequestParam(value="transport_idx") int transport_idx,
					HttpSession session
				){
				
			User loginUser = (User)session.getAttribute("loginUser");
			
			transportDao.getTransForCom(transport_idx);
			
			List<TransportComment> list = transComDao.getTransCom(transport_idx);
			
			return list;
		}
		
		
		//댓글달기-transport
		@RequestMapping(value="/addCom", method=RequestMethod.POST)
		public @ResponseBody String addCom(
					@RequestParam(value="transport_idx") int transport_idx,
					@RequestParam(value="transport_comment") String transport_comment,
					HttpSession session
				) {
			
			User loginUser = (User)session.getAttribute("loginUser");
			
			TransportComment transCom = new TransportComment();
			
			if(loginUser!=null) {
				
				transCom.setTransport_idx(transport_idx);
				transCom.setUser_idx(loginUser.getUser_idx());
				transCom.setNickname(loginUser.getNickname());
				transCom.setTransport_comment(transport_comment);
				
				transComDao.addCom(transCom);
				
				return "ok";
			}else {
				
				transCom.setTransport_idx(transport_idx);
				transCom.setUser_idx(0);
				transCom.setNickname("비회원");
				transCom.setTransport_comment(transport_comment);
				
				transComDao.addCom(transCom);
				
				return "ok";
			}
			
		}
		
		
		//댓글 삭제-transport
		@RequestMapping(value="/delCom", method=RequestMethod.POST)
		public @ResponseBody String delCom(
					@RequestParam(value="transport_comment_idx") int transport_comment_idx
				) {
			
			transComDao.delCom(transport_comment_idx);
			
			return "ok";
		}
		
		
		//댓글창-accomodation
		@RequestMapping(value="/getAccomForCom", method=RequestMethod.GET)
		public @ResponseBody Accomodation getAccomForCom(
				@RequestParam(value="accomodation_idx") int accomodation_idx
				) {
			
			Accomodation accom = accomodationDao.getAccomForCom(accomodation_idx);
			
			return accom;
		}
		
		
		@RequestMapping(value="/getAccomCom", method=RequestMethod.GET)
		public @ResponseBody List<AccomodationComment> getAccomCom(
					@RequestParam(value="accomodation_idx") int accomodation_idx,
					HttpSession session
				){
				
			User loginUser = (User)session.getAttribute("loginUser");
			
			accomodationDao.getAccomForCom(accomodation_idx);
			
			List<AccomodationComment> list = accomComDao.getAccomCom(accomodation_idx);
			
			return list;
		}
		
		
		//댓글달기-accomodation
		@RequestMapping(value="/addAccomCom", method=RequestMethod.POST)
		public @ResponseBody String addAccomCom(
					@RequestParam(value="accomodation_idx") int accomodation_idx,
					@RequestParam(value="accomodation_comment") String accomodation_comment,
					HttpSession session
				) {
			
			User loginUser = (User)session.getAttribute("loginUser");
			
			AccomodationComment accomCom = new AccomodationComment();
			
			if(loginUser!=null) {
				
				accomCom.setAccomodation_idx(accomodation_idx);
				accomCom.setUser_idx(loginUser.getUser_idx());
				accomCom.setNickname(loginUser.getNickname());
				accomCom.setAccomodation_comment(accomodation_comment);
				
				accomComDao.addAccomCom(accomCom);
				
				return "ok";
				
			}else {
				
				accomCom.setAccomodation_idx(accomodation_idx);
				accomCom.setUser_idx(0);
				accomCom.setNickname("비회원");
				accomCom.setAccomodation_comment(accomodation_comment);
				
				accomComDao.addAccomCom(accomCom);
				
				return "ok";
			}
			
		}
		
		
		//댓글 삭제-accomodation
		@RequestMapping(value="/delAccomCom", method=RequestMethod.POST)
		public @ResponseBody String delAccomCom(
					@RequestParam(value="accomodation_comment_idx") int accomodation_comment_idx
				) {
			
			accomComDao.delAccomCom(accomodation_comment_idx);
			
			return "ok";
		}
		
		
		//댓글창-eat
		@RequestMapping(value="/getEatForCom", method=RequestMethod.GET)
		public @ResponseBody Eat getEatForCom(
				@RequestParam(value="eat_idx") int eat_idx
				) {
			
			Eat eat = eatDao.getEatForCom(eat_idx);
			
			return eat;
		}
		
		
		@RequestMapping(value="/getEatCom", method=RequestMethod.GET)
		public @ResponseBody List<EatComment> getEatCom(
					@RequestParam(value="eat_idx") int eat_idx,
					HttpSession session
				){
				
			User loginUser = (User)session.getAttribute("loginUser");
			
			eatDao.getEatForCom(eat_idx);
			
			List<EatComment> list = eatComDao.getEatCom(eat_idx);
			
			return list;
		}
		
		
		//댓글달기-eat
		@RequestMapping(value="/addEatCom", method=RequestMethod.POST)
		public @ResponseBody String addEatCom(
					@RequestParam(value="eat_idx") int eat_idx,
					@RequestParam(value="eat_comment") String eat_comment,
					HttpSession session
				) {
			
			User loginUser = (User)session.getAttribute("loginUser");
			
			EatComment eatCom = new EatComment();
			
			if(loginUser!=null) {
				
				eatCom.setEat_idx(eat_idx);
				eatCom.setUser_idx(loginUser.getUser_idx());
				eatCom.setNickname(loginUser.getNickname());
				eatCom.setEat_comment(eat_comment);
				
				eatComDao.addEatCom(eatCom);
				
				return "ok";
			}else {
				
				eatCom.setEat_idx(eat_idx);
				eatCom.setUser_idx(0);
				eatCom.setNickname("비회원");
				eatCom.setEat_comment(eat_comment);
				
				eatComDao.addEatCom(eatCom);
				
				return "ok";
			}
			
		}
		
		
		//댓글 삭제-eat
		@RequestMapping(value="/delEatCom", method=RequestMethod.POST)
		public @ResponseBody String delEatCom(
					@RequestParam(value="eat_comment_idx") int eat_comment_idx
				) {
			
			eatComDao.delEatCom(eat_comment_idx);
			
			return "ok";
		}
		
		
		//댓글창-etc
		@RequestMapping(value="/getEtcForCom", method=RequestMethod.GET)
		public @ResponseBody Etc getEtcForCom(
				@RequestParam(value="etc_idx") int etc_idx
				) {
			
			Etc etc = etcDao.getEtcForCom(etc_idx);
			
			return etc;
		}
		
		
		@RequestMapping(value="/getEtcCom", method=RequestMethod.GET)
		public @ResponseBody List<EtcComment> getEtcCom(
					@RequestParam(value="etc_idx") int etc_idx,
					HttpSession session
				){
				
			User loginUser = (User)session.getAttribute("loginUser");
			
			etcDao.getEtcForCom(etc_idx);
			
			List<EtcComment> list = etcComDao.getEtcCom(etc_idx);
			
			return list;
		}
		
		
		//댓글달기-etc
		@RequestMapping(value="/addEtcCom", method=RequestMethod.POST)
		public @ResponseBody String addEtcCom(
					@RequestParam(value="etc_idx") int etc_idx,
					@RequestParam(value="etc_comment") String etc_comment,
					HttpSession session
				) {
			
			User loginUser = (User)session.getAttribute("loginUser");
			
			EtcComment etcCom = new EtcComment();
			
			if(loginUser!=null) {
				
				etcCom.setEtc_idx(etc_idx);
				etcCom.setUser_idx(loginUser.getUser_idx());
				etcCom.setNickname(loginUser.getNickname());
				etcCom.setEtc_comment(etc_comment);
				
				etcComDao.addEtcCom(etcCom);
				
				return "ok";
			}else {
				
				etcCom.setEtc_idx(etc_idx);
				etcCom.setUser_idx(0);
				etcCom.setNickname("비회원");
				etcCom.setEtc_comment(etc_comment);
				
				etcComDao.addEtcCom(etcCom);
				
				return "ok";
			}
			
		}
		
		
		//댓글 삭제-eat
		@RequestMapping(value="/delEtcCom", method=RequestMethod.POST)
		public @ResponseBody String delEtcCom(
					@RequestParam(value="etc_comment_idx") int etc_comment_idx
				) {
			
			etcComDao.delEtcCom(etc_comment_idx);
			
			return "ok";
		}
}
