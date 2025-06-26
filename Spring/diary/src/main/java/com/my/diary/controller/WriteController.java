package com.my.diary.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary.dao.AbroadDao;
import com.my.diary.dao.AccomodationDao;
import com.my.diary.dao.DomesticDao;
import com.my.diary.dao.EatDao;
import com.my.diary.dao.EtcDao;
import com.my.diary.dao.MydiaryDao;
import com.my.diary.dao.PhotosDao;
import com.my.diary.dao.PhotosDescDao;
import com.my.diary.dao.TransportDao;
import com.my.diary.vo.Abroad;
import com.my.diary.vo.Accomodation;
import com.my.diary.vo.Domestic;
import com.my.diary.vo.Eat;
import com.my.diary.vo.Etc;
import com.my.diary.vo.Mydiary;
import com.my.diary.vo.Photos;
import com.my.diary.vo.PhotosDesc;
import com.my.diary.vo.Transport;
import com.my.diary.vo.User;

@Controller
@RequestMapping(value="/write")
public class WriteController {
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@Resource(name="MydiaryDao")
	private MydiaryDao mydiaryDao;
	
	@Resource(name="PhotosDao")
	private PhotosDao photosDao;
	
	@Resource(name="PhotosDescDao")
	private PhotosDescDao photosDescDao;
	
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
	@RequestMapping(value="/add", method= {RequestMethod.POST} )
	public @ResponseBody String add(
				@RequestBody Map<String, Object> map,
				HttpSession session
			)throws Exception{
				
		
		DefaultTransactionDefinition def =new DefaultTransactionDefinition();
        def.setName("write_add");
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = transactionManager.getTransaction(def);
		
        
		try {
			String date = (String)map.get("write_date");
			String weather = (String)map.get("write_weather");
			String nation = (String)map.get("write_location");
			String title = (String)map.get("write_title_content");
			String abroad = (String)map.get("abroad");
			String location = (String)map.get("write_exact_location");
			String text = (String)map.get("write_diary_full");
			String main_img = (String)map.get("main_img_file");
			
			List<String> photosList = (List<String>)map.get("more_photos");
			List<String> explainTextList = (List<String>)map.get("more_photos_desc");
			
			List<String> transportList = (List<String>)map.get("transport");
			List<String> accomodationList = (List<String>)map.get("accomodation");
			List<String> eatList = (List<String>)map.get("eat");
			List<String> etcList = (List<String>)map.get("etc");
			
			String sight_img = (String)map.get("sight_img");
			String sight_desc = (String)map.get("sight_desc");
			
			List<Integer> sequenceList = (List<Integer>)map.get("sequence");
			List<Integer> sequenceDescList = (List<Integer>)map.get("sequence_desc");
			
			//mydiary 저장
			Mydiary newMydiary = new Mydiary();
			newMydiary.setDate(date);
			newMydiary.setWeather(weather);
			newMydiary.setNation(nation);
			newMydiary.setTitle(title);
			newMydiary.setAbroad(abroad);
			newMydiary.setLocation(location);
			newMydiary.setText(text);
			newMydiary.setMain_img(main_img);
			
			//mydiary-login된 user_idx저장
			User loginUser = (User)session.getAttribute("loginUser");
			Integer loginUser_idx = loginUser.getUser_idx();
			newMydiary.setUser_idx(loginUser_idx);
			
			mydiaryDao.addMydiary(newMydiary);
			
			
			//현재 mydiary_idx가져오기
			int new_mydiary_idx = newMydiary.getMydiary_idx();
			System.out.println(new_mydiary_idx);
			
			//현재 mydiary_location가져오기
			String new_mydiary_nation = newMydiary.getNation();
			System.out.println(new_mydiary_nation);
			
			
			//PhotosDesc 저장
			for(int i=0;i<explainTextList.size();i++) {
				
				PhotosDesc newPhDesc = new PhotosDesc();
				Integer sequence = sequenceDescList.get(i);
				String explain_text = explainTextList.get(i);
				
				newPhDesc.setMydiary_idx(new_mydiary_idx);
				newPhDesc.setSequence(sequence);
				newPhDesc.setExplain_text(explain_text);
				
				photosDescDao.addPhotosDesc(newPhDesc);
			}
			
			
			//Photos 저장
			for(int i=0;i<photosList.size();i++) {
				
				Photos newPhotos = new Photos();
				String photos_url = photosList.get(i);
				Integer sequence = sequenceList.get(i);
				
				/*
				 * System.out.println(photos_url); System.out.println(explain_text);
				 */
				
				newPhotos.setMydiary_idx(new_mydiary_idx);
				newPhotos.setPhotos(photos_url);
				newPhotos.setSequence(sequence);
							
				
				photosDao.addPhotos(newPhotos);
			}
			
			
			//tips-transport저장
			if(new_mydiary_nation==null||new_mydiary_nation=="") {
				
			} else {
				for(int i=0;i<transportList.size();i++) {
					
					Transport newTransport = new Transport();
					String tips_transport = transportList.get(i);
				
					/*
					 * System.out.println(tips_transport); 
					 * System.out.println(new_mydiary_nation);
					 */
					
					newTransport.setMydiary_idx(new_mydiary_idx);
					newTransport.setUser_idx(loginUser_idx);
					newTransport.setNation(new_mydiary_nation);
					newTransport.setTips_transport(tips_transport);
					
					transportDao.addTransport(newTransport);
					
				}
			}
			
			
			//tips-accomodation저장
			if(new_mydiary_nation==null||new_mydiary_nation=="") {
				
			}else {
				for(int i=0;i<accomodationList.size();i++) {
					
					Accomodation newAccomodation = new Accomodation();
					String tips_accomodation = accomodationList.get(i);
					
					newAccomodation.setMydiary_idx(new_mydiary_idx);
					newAccomodation.setUser_idx(loginUser_idx);
					newAccomodation.setNation(new_mydiary_nation);
					newAccomodation.setTips_accomodation(tips_accomodation);
					
					accomodationDao.addAccomodation(newAccomodation);
					
				}
			}
			
			
			//tips-eat저장
			if(new_mydiary_nation==null||new_mydiary_nation=="") {
				
			}else {
				for(int i=0;i<eatList.size();i++) {
					
					Eat newEat = new Eat();
					String tips_eat = eatList.get(i);
					
					newEat.setMydiary_idx(new_mydiary_idx);
					newEat.setUser_idx(loginUser_idx);
					newEat.setNation(new_mydiary_nation);
					newEat.setTips_eat(tips_eat);
					
					eatDao.addEat(newEat);
					
				}
			}
			
			
			//tips-etc저장
			if(new_mydiary_nation==null||new_mydiary_nation=="") {
				
			}else {
				for(int i=0;i<etcList.size();i++) {
					
					Etc newEtc = new Etc();
					String tips_etc = etcList.get(i);
					
					newEtc.setMydiary_idx(new_mydiary_idx);
					newEtc.setUser_idx(loginUser_idx);
					newEtc.setNation(new_mydiary_nation);
					newEtc.setTips_etc(tips_etc);
					
					etcDao.addEtc(newEtc);
				}
			}
			
			
			//abroad또는domestic Table에 저장
			if(sight_img == null || sight_img == "" || 
					sight_desc == null || sight_desc == ""|| 
					nation == null || nation =="") {
			} else {
				//1.abroad에 할지 domestic에 할지 선택
				String savedAbroad = newMydiary.getAbroad();
				
				//2.Y/N 확인 후, 각 table에 저장
				if(savedAbroad.equals("n")) {
					Domestic newDomestic = new Domestic();
					
					newDomestic.setMydiary_idx(new_mydiary_idx);
					newDomestic.setNation(new_mydiary_nation);
					newDomestic.setSight_img(sight_img);
					newDomestic.setSight_desc(sight_desc);
					newDomestic.setUser_idx(loginUser_idx);
					
					domesticDao.addDomestic(newDomestic);
					
				} else {
					Abroad newAbroad = new Abroad();
					
					newAbroad.setMydiary_idx(new_mydiary_idx);
					newAbroad.setNation(new_mydiary_nation);
					newAbroad.setSight_img(sight_img);
					newAbroad.setSight_desc(sight_desc);
					newAbroad.setUser_idx(loginUser_idx);
					
					abroadDao.addAbroad(newAbroad);
				}
				
			}
			
			
			
			
			//트랜잭션 commit
			transactionManager.commit(status);
			
			return "ok";
			
		}catch(Exception e) {
			
			//트랜잭션 rollback(모두 되돌리기)
			transactionManager.rollback(status);
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			
			return "fail";
		} 
		
	}
	
	
}
