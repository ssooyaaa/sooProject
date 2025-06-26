package com.my.diary_admin.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary_admin.dao.AbroadCommentDao;
import com.my.diary_admin.dao.AccomodationCommentDao;
import com.my.diary_admin.dao.DomesticCommentDao;
import com.my.diary_admin.dao.EatCommentDao;
import com.my.diary_admin.dao.EtcCommentDao;
import com.my.diary_admin.dao.TransportCommentDao;
import com.my.diary_admin.vo.AbroadComment;
import com.my.diary_admin.vo.AccomodationComment;
import com.my.diary_admin.vo.DomesticComment;
import com.my.diary_admin.vo.EatComment;
import com.my.diary_admin.vo.EtcComment;
import com.my.diary_admin.vo.TransportComment;

@Controller
@RequestMapping(value="/comment")
public class CommentController {

	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@Resource(name="TransportCommentDao")
	private TransportCommentDao transComDao;
	
	@Resource(name="AccomodationCommentDao")
	private AccomodationCommentDao accomComDao;
	
	@Resource(name="EatCommentDao")
	private EatCommentDao eatComDao;
	
	@Resource(name="EtcCommentDao")
	private EtcCommentDao etcComDao;
	
	@Resource(name="DomesticCommentDao")
	private DomesticCommentDao domComDao;
	
	@Resource(name="AbroadCommentDao")
	private AbroadCommentDao abComDao;
	
	
	//transport
	@RequestMapping(value="/getTransComCount", method=RequestMethod.GET)
	public @ResponseBody int getTransComCount() {
		
		int count = transComDao.getTransComCount();
		
		return count;
	}
	
	@RequestMapping(value="/getTransComAll", method=RequestMethod.GET)
	public @ResponseBody List<TransportComment> getTransComAll(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<TransportComment> list = transComDao.getTransComAll(map);
		
		return list;
	}
	
	@RequestMapping(value="/delTransCom", method=RequestMethod.POST)
	public @ResponseBody String delTransCom(
				@RequestParam(value="transport_comment_idx") int transport_comment_idx
			) {
		
		transComDao.delTransCom(transport_comment_idx);
		
		return "ok";
	}
	
	
	//accomodation
	@RequestMapping(value="/getAccomComCount", method=RequestMethod.GET)
	public @ResponseBody int getAccomComCount() {
		
		int count = accomComDao.getAccomComCount();
		
		return count;
	}
	
	@RequestMapping(value="/getAccomComAll", method=RequestMethod.GET)
	public @ResponseBody List<AccomodationComment> getAccomComAll(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<AccomodationComment> list = accomComDao.getAccomComAll(map);
		
		return list;
	}
	
	@RequestMapping(value="/delAccomCom", method=RequestMethod.POST)
	public @ResponseBody String delAccomCom(
				@RequestParam(value="accomodation_comment_idx") int accomodation_comment_idx
			) {
		
		accomComDao.delAccomCom(accomodation_comment_idx);
		
		return "ok";
	}
	
	
	//eat
	@RequestMapping(value="/getEatComCount", method=RequestMethod.GET)
	public @ResponseBody int getEatComCount() {
		
		int count = eatComDao.getEatComCount();
		
		return count;
	}
	
	@RequestMapping(value="/getEatComAll", method=RequestMethod.GET)
	public @ResponseBody List<EatComment> getEatComAll(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<EatComment> list = eatComDao.getEatComAll(map);
		
		return list;
	}
	
	@RequestMapping(value="/delEatCom", method=RequestMethod.POST)
	public @ResponseBody String delEatCom(
				@RequestParam(value="eat_comment_idx") int eat_comment_idx
			) {
		
		eatComDao.delEatCom(eat_comment_idx);
		
		return "ok";
	}
	
	
	//etc
	@RequestMapping(value="/getEtcComCount", method=RequestMethod.GET)
	public @ResponseBody int getEtcComCount() {
		
		int count = etcComDao.getEtcComCount();
		
		return count;
	}
	
	@RequestMapping(value="/getEtcComAll", method=RequestMethod.GET)
	public @ResponseBody List<EtcComment> getEtcComAll(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<EtcComment> list = etcComDao.getEtcComAll(map);
		
		return list;
	}
	
	@RequestMapping(value="/delEtcCom", method=RequestMethod.POST)
	public @ResponseBody String delEtcCom(
				@RequestParam(value="etc_comment_idx") int etc_comment_idx
			) {
		
		etcComDao.delEtcCom(etc_comment_idx);
		
		return "ok";
	}
	
	
	//domestic
	@RequestMapping(value="/getDomComCount", method=RequestMethod.GET)
	public @ResponseBody int getDomComCount() {
		
		int count = domComDao.getDomComCount();
		
		return count;
	}
	
	@RequestMapping(value="/getDomComAll", method=RequestMethod.GET)
	public @ResponseBody List<DomesticComment> getDomComAll(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<DomesticComment> list = domComDao.getDomComAll(map);
		
		return list;
	}
	
	@RequestMapping(value="/delDomCom", method=RequestMethod.POST)
	public @ResponseBody String delDomCom(
				@RequestParam(value="domestic_comment_idx") int domestic_comment_idx
			) {
		
		domComDao.delDomCom(domestic_comment_idx);
		
		return "ok";
	}
	
	
	//abroad
	@RequestMapping(value="/getAbComCount", method=RequestMethod.GET)
	public @ResponseBody int getAbComCount() {
		
		int count = abComDao.getAbComCount();
		
		return count;
	}
	
	@RequestMapping(value="/getAbComAll", method=RequestMethod.GET)
	public @ResponseBody List<AbroadComment> getAbComAll(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<AbroadComment> list = abComDao.getAbComAll(map);
		
		return list;
	}
	
	@RequestMapping(value="/delAbCom", method=RequestMethod.POST)
	public @ResponseBody String delAbCom(
				@RequestParam(value="abroad_comment_idx") int abroad_comment_idx
			) {
		
		abComDao.delAbCom(abroad_comment_idx);
		
		return "ok";
	}
	
	
	//댓글 총 개수
	@RequestMapping(value="/getTotalComment",method=RequestMethod.GET)
	public @ResponseBody int getTotalComment(
				@RequestParam(value="user_idx") int user_idx
			) throws Exception{
		
		DefaultTransactionDefinition def =new DefaultTransactionDefinition();
        def.setName("total_comment");
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = transactionManager.getTransaction(def);
		
        try {
        	
        	int transCom = transComDao.getTransCountByIdx(user_idx);
        	int accomCom = accomComDao.getAccomCountByIdx(user_idx);
        	int eatCom = eatComDao.getEatCountByIdx(user_idx);
        	int etcCom = etcComDao.getEtcCountByIdx(user_idx);
        	
        	int domCom = domComDao.getDomCountByIdx(user_idx);
        	int abCom = abComDao.getAbCountByIdx(user_idx);
        	
        	int totalCount = transCom+accomCom+eatCom+etcCom+domCom+abCom;
        	
        	transactionManager.commit(status);
        	
        	return totalCount;
        	
        }catch(Exception e) {
        	//트랜잭션 rollback(모두 되돌리기)
			transactionManager.rollback(status);
			
			System.out.println(e.getMessage());
			
			return 0;
        }
        
	}
	
	
}
