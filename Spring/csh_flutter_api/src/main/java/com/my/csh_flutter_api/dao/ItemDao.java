package com.my.csh_flutter_api.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.csh_flutter_api.vo.Item;

@Repository
public class ItemDao {

	@Autowired
	SqlSession s;
	
	public void save(Item item) {
		s.insert("ItemMapper.save", item);
	}
}
