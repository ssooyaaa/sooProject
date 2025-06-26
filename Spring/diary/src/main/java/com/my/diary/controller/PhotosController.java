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

import com.my.diary.dao.AbroadCommentDao;
import com.my.diary.dao.AbroadDao;
import com.my.diary.dao.DomesticCommentDao;
import com.my.diary.dao.DomesticDao;
import com.my.diary.dao.PhotosDao;
import com.my.diary.vo.Abroad;
import com.my.diary.vo.AbroadComment;
import com.my.diary.vo.Domestic;
import com.my.diary.vo.DomesticComment;
import com.my.diary.vo.Photos;
import com.my.diary.vo.User;


@Controller
@RequestMapping(value="/photos")
public class PhotosController {

	@Resource(name="AbroadDao")
	private AbroadDao abroadDao;
	
	@Resource(name="DomesticDao")
	private DomesticDao domesticDao;
	
	@Resource(name="PhotosDao")
	private PhotosDao photosDao;
	
	@Resource(name="DomesticCommentDao")
	private DomesticCommentDao domComDao;
	
	@Resource(name="AbroadCommentDao")
	private AbroadCommentDao abComDao;
	
	
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
		
		//main화면-domestic
		@RequestMapping(value = "/getDomesticPics", method = RequestMethod.GET)
		public @ResponseBody List<Domestic> getDomesticPics(){
			
			List<Domestic> domesticList = domesticDao.getDomesticPics();
			
			return domesticList;
		}
	
		
		//main화면-abroad
		@RequestMapping(value = "/getAbroadPics", method = RequestMethod.GET)
		public @ResponseBody List<Abroad> getAbroadPics(){
			
			List<Abroad> abroadList = abroadDao.getAbroadPics();
			
			return abroadList;
		}
		
		
		//다이어리더보기-숨은명소
		@RequestMapping(value = "/getAbroadByIdx", method = RequestMethod.GET)
		public @ResponseBody Abroad getAbroadByIdx(
					@RequestParam(value="mydiary_idx") int mydiary_idx
				) {
			
			Abroad abroad = new Abroad();
			abroad.setMydiary_idx(mydiary_idx);
			
			Abroad abroadSight = abroadDao.getAbroadByIdx(abroad);
			
			return abroadSight;
						
		}
		
		@RequestMapping(value = "/getDomesticByIdx", method = RequestMethod.GET)
		public @ResponseBody Domestic getDomesticByIdx(
					@RequestParam(value="mydiary_idx") int mydiary_idx
				) {
			
			Domestic domestic = new Domestic();
			domestic.setMydiary_idx(mydiary_idx);
			
			Domestic domesticSight = domesticDao.getDomesticByIdx(domestic);
			
			return domesticSight;
			
		}
		
		
		//검색리스트-abroad
		@RequestMapping(value="/getAbroadCountAfterSch", method=RequestMethod.GET)
		public @ResponseBody int getAbroadCountAfterSch(
					@RequestParam(value="nation") String nation
				) {
			
			Abroad ab = new Abroad();
			ab.setNation(nation);
			
			int count = abroadDao.getAbroadCountAfterSch(ab);
			
			return count;
		}
		
		@RequestMapping(value="/getAbroadChunkAfterSch", method=RequestMethod.GET)
		public @ResponseBody List<Abroad> getAbroadChunkAfterSch(
					@RequestParam(value="nation") String nation,
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				){
			
			Abroad ab = new Abroad();
			ab.setNation(nation);
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("nation", nation);
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Abroad> list = abroadDao.getAbroadChunkAfterSch(map);
			
			return list;
		}
		
		//검색리스트-domestic
		@RequestMapping(value="/getDomCountAfterSch", method=RequestMethod.GET)
		public @ResponseBody int getDomCountAfterSch(
					@RequestParam(value="nation") String nation
				) {
			
			Domestic dom = new Domestic();
			dom.setNation(nation);
			
			int count = domesticDao.getDomCountAfterSch(dom);
			
			return count;
		}
		
		@RequestMapping(value="/getDomChunkAfterSch", method=RequestMethod.GET)
		public @ResponseBody List<Domestic> getDomChunkAfterSch(
					@RequestParam(value="nation") String nation,
					@RequestParam(value="start") int start,
					@RequestParam(value="cnt") int cnt
				){
			
			Domestic dom = new Domestic();
			dom.setNation(nation);
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("nation", nation);
			map.put("start", start);
			map.put("cnt", cnt);
			
			List<Domestic> list = domesticDao.getDomChunkAfterSch(map);
			
			return list;
		}

		
		//다이어리 더보기-more photos
		@RequestMapping(value="/getPhotosByIdx", method=RequestMethod.GET)
		public @ResponseBody List<Photos> getPhotosByIdx(
					@RequestParam(value="mydiary_idx") int mydiary_idx
				) {
			
			Photos photos = new Photos();
			photos.setMydiary_idx(mydiary_idx);
			
			List<Photos> photoList = photosDao.getPhotosByIdx(photos);
			
			return photoList;
		}
		
		
		//다이어리 more photos 개수 - idx
		@RequestMapping(value="/getCountByIdx", method=RequestMethod.GET)
		public @ResponseBody int getCountByIdx(
					@RequestParam(value="mydiary_idx") int mydiary_idx
				) {
			
			Photos photos = new Photos();
			photos.setMydiary_idx(mydiary_idx);
			
			int count = photosDao.getCountByIdx(photos);
			
			return count;
		}
		
		
		//댓글창-domestic
		@RequestMapping(value="/getDomForCom", method=RequestMethod.GET)
		public @ResponseBody Domestic getDomForCom(
				@RequestParam(value="domestic_idx") int domestic_idx
				) {
			
			Domestic dom = domesticDao.getDomForCom(domestic_idx);
			
			return dom;
		}
		
		
		@RequestMapping(value="/getDomCom", method=RequestMethod.GET)
		public @ResponseBody List<DomesticComment> getDomCom(
					@RequestParam(value="domestic_idx") int domestic_idx,
					HttpSession session
				){
				
			User loginUser = (User)session.getAttribute("loginUser");
			
			domesticDao.getDomForCom(domestic_idx);
			
			List<DomesticComment> list = domComDao.getDomCom(domestic_idx);
			
			return list;
		}
		
		
		//댓글달기-domestic
		@RequestMapping(value="/addDomCom", method=RequestMethod.POST)
		public @ResponseBody String addDomCom(
					@RequestParam(value="domestic_idx") int domestic_idx,
					@RequestParam(value="domestic_comment") String domestic_comment,
					HttpSession session
				) {
			
			User loginUser = (User)session.getAttribute("loginUser");
			
			DomesticComment domCom = new DomesticComment();
			
			if(loginUser!=null) {
				
				domCom.setDomestic_idx(domestic_idx);
				domCom.setUser_idx(loginUser.getUser_idx());
				domCom.setNickname(loginUser.getNickname());
				domCom.setDomestic_comment(domestic_comment);
				
				domComDao.addDomCom(domCom);
				
				return "ok";
			}else {
				
				domCom.setDomestic_idx(domestic_idx);
				domCom.setUser_idx(0);
				domCom.setNickname(loginUser.getNickname());
				domCom.setDomestic_comment(domestic_comment);
				
				domComDao.addDomCom(domCom);
				
				return "ok";
			}
			
		}
		
		
		//댓글 삭제-eat
		@RequestMapping(value="/delDomCom", method=RequestMethod.POST)
		public @ResponseBody String delDomCom(
					@RequestParam(value="domestic_comment_idx") int domestic_comment_idx
				) {
			
			domComDao.delDomCom(domestic_comment_idx);
			
			return "ok";
		}

		
		//댓글창-abroad
		@RequestMapping(value="/getAbForCom", method=RequestMethod.GET)
		public @ResponseBody Abroad getAbForCom(
				@RequestParam(value="abroad_idx") int abroad_idx
				) {
			
			Abroad ab = abroadDao.getAbForCom(abroad_idx);
			
			return ab;
		}
		
		
		@RequestMapping(value="/getAbCom", method=RequestMethod.GET)
		public @ResponseBody List<AbroadComment> getAbCom(
					@RequestParam(value="abroad_idx") int abroad_idx,
					HttpSession session
				){
				
			User loginUser = (User)session.getAttribute("loginUser");
			
			abroadDao.getAbForCom(abroad_idx);
			
			List<AbroadComment> list = abComDao.getAbCom(abroad_idx);
			
			return list;
		}
		
		
		//댓글달기-domestic
		@RequestMapping(value="/addAbCom", method=RequestMethod.POST)
		public @ResponseBody String addAbCom(
					@RequestParam(value="abroad_idx") int abroad_idx,
					@RequestParam(value="abroad_comment") String abroad_comment,
					HttpSession session
				) {
			
			User loginUser = (User)session.getAttribute("loginUser");
			
			AbroadComment abCom = new AbroadComment();
			
			if(loginUser!=null) {
				
				abCom.setAbroad_idx(abroad_idx);
				abCom.setUser_idx(loginUser.getUser_idx());
				abCom.setNickname(loginUser.getNickname());
				abCom.setAbroad_comment(abroad_comment);
				
				abComDao.addAbCom(abCom);
				
				return "ok";
			}else {
				
				abCom.setAbroad_idx(abroad_idx);
				abCom.setUser_idx(0);
				abCom.setNickname("비회원");
				abCom.setAbroad_comment(abroad_comment);
				
				abComDao.addAbCom(abCom);
				
				return "ok";
			}
			
		}
		
		
		//댓글 삭제-eat
		@RequestMapping(value="/delAbCom", method=RequestMethod.POST)
		public @ResponseBody String delAbCom(
					@RequestParam(value="abroad_comment_idx") int abroad_comment_idx
				) {
			
			abComDao.delAbCom(abroad_comment_idx);
			
			return "ok";
		}
}
