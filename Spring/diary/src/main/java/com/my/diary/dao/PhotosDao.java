package com.my.diary.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.Photos;

public class PhotosDao extends SqlSessionDaoSupport{

	public int addPhotos(Photos photos) {
		return this.getSqlSession().insert("photos.addPhotos",photos);
	}
	
	public List<Photos> getPhotosByIdx(Photos photos){
		return this.getSqlSession().selectList("photos.getPhotosByIdx",photos);
	}
	
	public int updatePhotosDesc(Photos photos) {
		return this.getSqlSession().update("photos.updatePhotosDesc",photos);
	}
	
	public int getCountByIdx(Photos photos) {
		return this.getSqlSession().selectOne("photos.getCountByIdx",photos);
	}
	
	public int delPhotos(Photos photos) {
		return this.getSqlSession().delete("photos.delPhotos",photos);
	}
	
}
