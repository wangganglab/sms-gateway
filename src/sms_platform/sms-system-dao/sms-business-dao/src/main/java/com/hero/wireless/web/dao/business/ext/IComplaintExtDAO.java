package com.hero.wireless.web.dao.business.ext;

import com.hero.wireless.web.dao.business.IComplaintDAO;
import com.hero.wireless.web.dao.ext.IExtDAO;
import com.hero.wireless.web.entity.business.Complaint;
import com.hero.wireless.web.entity.business.ComplaintExample;
import com.hero.wireless.web.entity.business.ext.ComplaintExt;

public interface IComplaintExtDAO extends IComplaintDAO<Complaint>, IExtDAO<ComplaintExt, ComplaintExample> {
}
