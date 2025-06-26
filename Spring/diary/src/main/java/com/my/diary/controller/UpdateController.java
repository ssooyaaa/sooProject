package com.my.diary.controller;

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

import com.my.diary.dao.AbroadDao;
import com.my.diary.dao.AccomodationDao;
import com.my.diary.dao.DomesticDao;
import com.my.diary.dao.EatDao;
import com.my.diary.dao.EtcDao;
import com.my.diary.dao.MydiaryDao;
import com.my.diary.dao.PhotosDao;
import com.my.diary.dao.TransportDao;
import com.my.diary.vo.Abroad;
import com.my.diary.vo.Accomodation;
import com.my.diary.vo.Domestic;
import com.my.diary.vo.Eat;
import com.my.diary.vo.Etc;
import com.my.diary.vo.Mydiary;
import com.my.diary.vo.Photos;
import com.my.diary.vo.Transport;


@Controller
@RequestMapping(value="/update")
public class UpdateController {
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@Resource(name="MydiaryDao")
	private MydiaryDao mydiaryDao;
	
	@Resource(name="PhotosDao")
	private PhotosDao photosDao;
	
	@Resource(name="TransportDao")
	private TransportDao transportDao;
	
	@Resource(name="AccomodationDao")
	private AccomodationDao accomodationDao;
	
	@Resource(name="EatDao")
	private EatDao eatDao;
	
	@Resource(name="EtcDao")
	private EtcDao etcDao;
	
	@Resource(name="AbroadDao")
	private AbroadDao abroadDao;
	
	@Resource(name="DomesticDao")
	private DomesticDao domesticDao;
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/del", method=RequestMethod.POST)
	public @ResponseBody String del(
				@RequestParam(value="mydiary_idx") int mydiary_idx
			) throws Exception {
		
		DefaultTransactionDefinition def =new DefaultTransactionDefinition();
        def.setName("update_mydiary");
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = transactionManager.getTransaction(def);
		
        
        try {
        	 
    		//1.다이어리 본문 삭제
    		Mydiary mydiary = new Mydiary();
    		mydiary.setMydiary_idx(mydiary_idx);
    		
    		mydiaryDao.delMydiary(mydiary);
    		
    		//2.photos 삭제
    		Photos photos = new Photos();
    		photos.setMydiary_idx(mydiary_idx);
    		
    		photosDao.delPhotos(photos);
    		
    		//3.tips-transport 삭제
    		Transport trans = new Transport();
    		trans.setMydiary_idx(mydiary_idx);
    		
    		transportDao.delTransport(trans);
    		
    		//4.tips-accomodation 삭제
    		Accomodation accom = new Accomodation();
    		accom.setMydiary_idx(mydiary_idx);
    		
    		accomodationDao.delAccomodation(accom);
    		
    		//5.tips-eat삭제
    		Eat eat = new Eat();
    		eat.setMydiary_idx(mydiary_idx);
    		
    		eatDao.delEat(eat);
    		
    		//6.tips-etc삭제
    		Etc etc = new Etc();
    		etc.setMydiary_idx(mydiary_idx);
    		
    		etcDao.delEtc(etc);
    		
    		//7.sight 삭제
    		Abroad abroad = new Abroad();
    		abroad.setMydiary_idx(mydiary_idx);
    		
    		abroadDao.delAbroad(abroad);
    		
    		Domestic dom = new Domestic();
    		dom.setMydiary_idx(mydiary_idx);
    		
    		domesticDao.delDomestic(dom);
    		
    		//트랜잭션 commit
			transactionManager.commit(status);
    		
    		return "ok";
    		
        }catch(Exception e) {
        	
        	//트랜잭션 rollback(모두 되돌리기)
			transactionManager.rollback(status);
			
			System.out.println(e.getMessage());
			
			return "fail";
			
        }
        
       
	}
	
	
	

}
