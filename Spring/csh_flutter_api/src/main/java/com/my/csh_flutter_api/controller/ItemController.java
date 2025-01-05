package com.my.csh_flutter_api.controller;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.my.csh_flutter_api.service.ItemService;
import com.my.csh_flutter_api.vo.Item;


@RestController
@RequestMapping(value="/api/item")
public class ItemController {

	@Autowired
	ItemService itemService;
	
	
	@PostMapping("create")
	public String create(
			@RequestParam(value="user_idx") int user_idx,
			@RequestParam(value="title") String title,
			@RequestParam(value="content") String content,
			@RequestParam(value="img_url") String img_url
			) {
		
		
		Item item = new Item();
		item.setUser_idx(user_idx);
		item.setTitle(title);
		item.setContent(content);
		item.setImg_url(img_url);
		
		itemService.save(item);
		
		
		
		return "ok";
	}
}
