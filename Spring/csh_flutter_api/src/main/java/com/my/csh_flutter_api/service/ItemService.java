package com.my.csh_flutter_api.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.csh_flutter_api.dao.ItemDao;
import com.my.csh_flutter_api.vo.Item;

@Service
public class ItemService {

	@Autowired
	ItemDao itemDao;
	
	
	public void save(Item item) {
		itemDao.save(item);
	}
	
	
}
