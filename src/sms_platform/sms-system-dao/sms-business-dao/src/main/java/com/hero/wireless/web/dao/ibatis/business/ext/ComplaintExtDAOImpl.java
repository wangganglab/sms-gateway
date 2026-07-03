package com.hero.wireless.web.dao.ibatis.business.ext;

import com.hero.wireless.web.dao.business.ext.IComplaintExtDAO;
import com.hero.wireless.web.dao.ibatis.MybatisBaseBusinessExtDao;
import com.hero.wireless.web.entity.business.Complaint;
import com.hero.wireless.web.entity.business.ComplaintExample;
import com.hero.wireless.web.entity.business.ext.ComplaintExt;
import org.springframework.stereotype.Repository;

@Repository("complaintExtDAO")
public class ComplaintExtDAOImpl extends MybatisBaseBusinessExtDao<ComplaintExt, ComplaintExample, Complaint> implements IComplaintExtDAO {
}
