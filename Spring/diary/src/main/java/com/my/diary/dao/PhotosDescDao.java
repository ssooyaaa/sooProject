package com.my.diary.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.PhotosDesc;

public class PhotosDescDao extends SqlSessionDaoSupport {

	public int addPhotosDesc(PhotosDesc desc) {
		return this.getSqlSession().insert("photosDesc.addPhotosDesc",desc);
	}
}

